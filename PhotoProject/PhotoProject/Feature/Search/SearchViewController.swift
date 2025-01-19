//
//  SearchViewController.swift
//  PhotoProject
//
//  Created by 김도형 on 1/19/25.
//

import UIKit

import SnapKit

class SearchViewController: UIViewController {
    private let colorButtonScrollView = UIScrollView()
    private let colorButtonHStack = UIStackView()
    private var colorButtons = [ColorButton]()
    private let sortButton = UIButton()
    private let noticeLabel = UILabel()
    private let activityIndicatorView = UIActivityIndicatorView(style: .large)
    private lazy var collectionView: UICollectionView = {
        return configureCollectionView()
    }()
    
    private var colorFilter: ColorFilter? {
        didSet { didSetColorFilter() }
    }
    private var sort = Sort.relevant {
        didSet { didSetSort() }
    }
    private var search: SearchResponse? {
        didSet { didSetSearch() }
    }
    private var page = 1
    private var query = ""
    private var isLoading = false {
        didSet { didSetIsLoading() }
    }
    private var isPaging = false
    
    private let searchClient = SearchClient.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        configureLayout()
    }
}

// MARK: Configure View
private extension SearchViewController {
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        configureNavigationBar()
        
        configureSearchController()
        
        configureColorButtons()
        
        configureColorButtonHStack()
        
        configureColorButtonScrollView()
        
        configureSortButton()
        
        configureNoticeLabel()
        
        configureActivityIndicator()
    }
    
    func configureLayout() {
        colorButtonScrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(colorButtonHStack)
        }
        
        let sortButtonSize = sortButton.intrinsicContentSize
        
        sortButton.snp.makeConstraints { make in
            make.centerY.equalTo(colorButtonScrollView)
            make.trailing.equalToSuperview().offset(sortButtonSize.height / 2 - 6)
        }
        
        colorButtonHStack.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(sortButtonSize.width)
        }
        
        for colorButton in colorButtons {
            colorButton.snp.makeConstraints { make in
                make.verticalEdges.equalToSuperview()
            }
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(colorButtonScrollView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        noticeLabel.snp.makeConstraints { make in
            make.center.equalTo(collectionView)
        }
        
        activityIndicatorView.snp.makeConstraints { make in
            make.center.equalTo(collectionView)
        }
    }
    
    func configureNavigationBar() {
        navigationItem.title = "SEARCH PHOTO"
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "키워드 검색"
        searchController.automaticallyShowsCancelButton = false
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    func configureColorButtons() {
        for filter in ColorFilter.allCases {
            let colorButton = ColorButton(filter: filter)
            colorButton.addTarget(
                self,
                action: #selector(colorButtonTouchUpInside),
                for: .touchUpInside
            )
            colorButtons.append(colorButton)
            colorButtonHStack.addArrangedSubview(colorButton)
        }
    }
    
    func configureColorButtonHStack() {
        colorButtonHStack.axis = .horizontal
        colorButtonHStack.spacing = 8
        colorButtonHStack.distribution = .fillProportionally
        colorButtonHStack.alignment = .leading
        colorButtonScrollView.addSubview(colorButtonHStack)
    }
    
    func configureColorButtonScrollView() {
        colorButtonScrollView.showsHorizontalScrollIndicator = false
        view.addSubview(colorButtonScrollView)
    }
    
    func configureSortButton() {
        sortButton.tintColor = .label
        
        var configuration = UIButton.Configuration.plain()
        configuration.cornerStyle = .capsule
        configuration.background.backgroundColor = .systemBackground
        configuration.imagePlacement = .leading
        configuration.imagePadding = 4
        configuration.attributedTitle = AttributedString(
            sort.title,
            attributes: AttributeContainer([
                .foregroundColor: UIColor.label,
                .font: UIFont.systemFont(ofSize: 14, weight: .bold)
            ])
        )
        configuration.background.strokeColor = .separator
        configuration.background.strokeWidth = 1
        configuration.image = UIImage(systemName: "arrow.up.arrow.down")
        sortButton.configuration = configuration
        sortButton.addTarget(
            self,
            action: #selector(sortButtonTouchUpInside),
            for: .touchUpInside
        )
        view.addSubview(sortButton)
    }
    
    func configureCollectionView() -> UICollectionView {
        let collectionView = VerticalCollectionView(
            superSize: view.frame,
            multipliedBy: 1.2,
            colCount: 2,
            colSpacing: 8,
            rowSpacing: 8,
            inset: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0)
        )
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        
        collectionView.register(
            SearchCollectionViewCell.self,
            forCellWithReuseIdentifier: .searchCollectionCell
        )
        view.addSubview(collectionView)
        
        return collectionView
    }
    
    func configureNoticeLabel() {
        noticeLabel.text = "사진을 검색해보세요."
        noticeLabel.font = .systemFont(ofSize: 16, weight: .bold)
        view.addSubview(noticeLabel)
    }
    
    func configureActivityIndicator() {
        activityIndicatorView.isHidden = true
        collectionView.addSubview(activityIndicatorView)
    }
}

// MARK: Functions
private extension SearchViewController {
    @objc
    func colorButtonTouchUpInside(_ sender: ColorButton) {
        if colorFilter == sender.filter {
            colorFilter = nil
        } else {
            colorFilter = sender.filter
        }
        
        fetchSearch()
    }
    
    @objc
    func sortButtonTouchUpInside(_ sender: UIButton) {
        switch sort {
        case .relevant: sort = .latest
        case .latest: sort = .relevant
        }
        
        fetchSearch()
    }
    
    func fetchSearch() {
        Task { [weak self] in
            guard let `self` else { return }
            self.isLoading = true
            defer { self.isLoading = false }
            
            let request = SearchRequest(
                query: self.query,
                page: self.page,
                perPage: 20,
                orderBy: self.sort.rawValue,
                color: self.colorFilter?.rawValue
            )
            do {
                self.search = try await searchClient.fetchSearch(request)
            } catch {
                print(error)
            }
        }
    }
    
    func paginationSearch() {
        guard
            !isPaging,
            let search,
            search.results.count < search.total,
            page < search.totalPages
        else { return }
        
        Task { [weak self] in
            guard let `self` else { return }
            self.isPaging = true
            defer { isPaging = false }
            self.page += 1
            
            let request = SearchRequest(
                query: self.query,
                page: self.page,
                perPage: 20,
                orderBy: self.sort.rawValue,
                color: self.colorFilter?.rawValue
            )
            
            do {
                self.search?.results += try await searchClient.fetchSearch(request).results
            } catch {
                print(error)
            }
        }
    }
}

// MARK: Data Bindings
private extension SearchViewController {
    func didSetColorFilter() {
        UIView.animate(.easeInOut) {
            for button in colorButtons {
                button.isSelected(button.filter == colorFilter)
            }
        }
        
        guard !(search?.results.isEmpty ?? true) else { return }
        collectionView.scrollToItem(
            at: IndexPath(item: 0, section: 0),
            at: .top,
            animated: true
        )
    }
    
    func didSetSort() {
        sortButton.configuration?.attributedTitle = AttributedString(
            sort.title,
            attributes: AttributeContainer([
                .foregroundColor: UIColor.label,
                .font: UIFont.systemFont(ofSize: 14, weight: .bold)
            ])
        )
        guard !(search?.results.isEmpty ?? true) else { return }
        collectionView.scrollToItem(
            at: IndexPath(item: 0, section: 0),
            at: .top,
            animated: true
        )
    }
    
    func didSetSearch() {
        if search?.results.isEmpty ?? true {
            noticeLabel.text = "검색 결과가 없어요."
            noticeLabel.isHidden = false
        } else {
            noticeLabel.isHidden = true
        }
        collectionView.reloadData()
    }
    
    func didSetIsLoading() {
        activityIndicatorView.isHidden = !isLoading
        if isLoading {
            activityIndicatorView.startAnimating()
        } else {
            activityIndicatorView.stopAnimating()
        }
    }
}

extension SearchViewController: UISearchResultsUpdating,
                                    UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        query = searchBar.text ?? ""
        view.endEditing(true)
        colorFilter = nil
        sort = .relevant
        
        fetchSearch()
    }
}

extension SearchViewController: UICollectionViewDelegate,
                                UICollectionViewDataSource,
                                UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return search?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: .searchCollectionCell,
            for: indexPath
        ) as? SearchCollectionViewCell
        guard
            let cell,
            let result = search?.results[indexPath.item]
        else { return UICollectionViewCell() }
        
        cell.cellForItemAt(result)
        cell.layoutIfNeeded()
        
        if search?.results.count == indexPath.item + 1 {
            paginationSearch()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            guard
                search?.results.count == indexPath.item + 2
            else { continue }
            paginationSearch()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let search else { return }
        let result = search.results[indexPath.item]
        navigationController?.pushViewController(
            StatisticsViewController(photo: result),
            animated: true
        )
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension SearchViewController {
    class ColorButton: UIButton {
        let filter: ColorFilter
        
        init(filter: ColorFilter) {
            self.filter = filter
            super.init(frame: .zero)
            
            tintColor = filter.color
            
            var configuration = UIButton.Configuration.plain()
            configuration.cornerStyle = .capsule
            configuration.background.backgroundColor = .secondarySystemBackground
            configuration.imagePlacement = .leading
            configuration.imagePadding = 4
            configuration.attributedTitle = AttributedString(
                filter.title,
                attributes: AttributeContainer([
                    .foregroundColor: UIColor.label,
                    .font: UIFont.systemFont(ofSize: 16, weight: .semibold)
                ])
            )
            configuration.image = UIImage(systemName: "circle.fill")
            self.configuration = configuration
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func isSelected(_ selected: Bool) {
            self.configuration?.background.backgroundColor = selected
            ? .systemBlue
            : .secondarySystemBackground
            
            self.configuration?
                .attributedTitle?
                .foregroundColor = selected ? .white : .label
        }
    }
}

extension SearchViewController {
    enum ColorFilter: String, CaseIterable {
        case black = "black"
        case white = "white"
        case blue = "blue"
        case yellow = "yellow"
        case red = "red"
        case green = "green"
        case purple = "purple"
        
        var color: UIColor {
            switch self {
            case .black: return UIColor(resource: .searchBlack)
            case .white: return UIColor(resource: .searchWhite)
            case .blue: return UIColor(resource: .searchBlue)
            case .yellow: return UIColor(resource: .searchYellow)
            case .red: return UIColor(resource: .searchRed)
            case .green: return UIColor(resource: .searchGreen)
            case .purple: return UIColor(resource: .searchPurple)
            }
        }
        
        var title: String {
            switch self {
            case .black: return "블랙"
            case .white: return "화이트"
            case .blue: return "블루"
            case .yellow: return "옐로우"
            case .red: return "레드"
            case .green: return "그린"
            case .purple: return "퍼플"
            }
        }
    }
    
    enum Sort: String {
        case relevant = "relevant"
        case latest = "latest"
        
        var title: String {
            switch self {
            case .relevant: return "관련순"
            case .latest: return "최신순"
            }
        }
    }
}
