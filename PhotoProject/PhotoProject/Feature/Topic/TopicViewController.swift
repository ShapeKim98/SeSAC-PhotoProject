//
//  TopicViewController.swift
//  PhotoProject
//
//  Created by 김도형 on 1/19/25.
//

import UIKit

import SnapKit

class TopicViewController: UIViewController {
    private var topicCollectionViews = [TopicCollectionViewContainer]()
    private let vstack = UIStackView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let activityIndicatorView = UIActivityIndicatorView(style: .large)
    
    private var topics: [[TopicResponse]] = [[], [], []] {
        didSet { didSetTopics() }
    }
    private var isLoading = false {
        didSet { didSetIsLoading() }
    }
    
    private var topicTypes = TopicType.allCases.shuffled() {
        didSet { didSetTopicTypes() }
    }
    
    private let topicClient = TopicClient.shared
    private var lastTime = CFAbsoluteTimeGetCurrent()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        configureLayout()
        
        fetchTopics()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        configureNavigationBar()
    }
}

// MARK: Configure View
private extension TopicViewController {
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        configureNavigationBar()
        
        configureScrollView()
        
        scrollView.addSubview(contentView)
        
        configureVStack()
        
        configureCollectionViews()
        
        configureActivityIndicator()
    }
    
    func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.verticalEdges.equalToSuperview()
        }
        
        vstack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        for collectionView in topicCollectionViews {
            collectionView.snp.makeConstraints { make in
                make.horizontalEdges.equalToSuperview()
            }
        }
        
        activityIndicatorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "OUR TOPIC"
    }
    
    func configureScrollView() {
        scrollView.isScrollEnabled = true
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(
            self,
            action: #selector(refreshControlValueChanged),
            for: .valueChanged
        )
        view.addSubview(scrollView)
    }
    
    func configureVStack() {
        vstack.axis = .vertical
        vstack.spacing = 16
        vstack.distribution = .fill
        vstack.alignment = .center
        contentView.addSubview(vstack)
    }
    
    func configureCollectionViews() {
        for (index, topic) in topics.enumerated() {
            let type = topicTypes[index]
            
            let container = TopicCollectionViewContainer(
                title: type.title,
                topic: topic,
                tag: index
            )
            container.collectionView.delegate = self
            container.collectionView.dataSource = self
            topicCollectionViews.append(container)
            vstack.addArrangedSubview(container)
        }
    }
    
    func configureActivityIndicator() {
        activityIndicatorView.isHidden = true
        view.addSubview(activityIndicatorView)
    }
}

// MARK: Data Bindings
private extension TopicViewController {
    func didSetTopics() {
        for container in topicCollectionViews {
            container.collectionView.reloadData()
        }
    }
    
    func didSetIsLoading() {
        activityIndicatorView.isHidden = !isLoading
        if isLoading {
            activityIndicatorView.startAnimating()
        } else {
            activityIndicatorView.stopAnimating()
        }
    }
    
    func didSetTopicTypes() {
        for (index, container) in topicCollectionViews.enumerated() {
            let type = topicTypes[index]
            container.setTitle(type.title)
        }
    }
}

// MARK: Functions
private extension TopicViewController {
    func fetchTopics(group: DispatchGroup = DispatchGroup()) {
        self.isLoading = true
        
        group.enter()
        topicClient.fetchTopics(TopicRequest(
            topic: topicTypes[0].rawValue
        )) { [weak self] result in
            guard let `self` else { return }
            switch result {
            case .success(let success):
                self.topics[0] = success
            case .failure(let failure):
                self.handleFailure(failure)
            }
            group.leave()
        }
        
        group.enter()
        topicClient.fetchTopics(TopicRequest(
            topic: topicTypes[1].rawValue
        )) { [weak self] result in
            guard let `self` else { return }
            switch result {
            case .success(let success):
                self.topics[1] = success
            case .failure(let failure):
                self.handleFailure(failure)
            }
            group.leave()
        }
        
        group.enter()
        topicClient.fetchTopics(TopicRequest(
            topic: topicTypes[2].rawValue
        )) { [weak self] result in
            guard let `self` else { return }
            switch result {
            case .success(let success):
                self.topics[2] = success
            case .failure(let failure):
                self.handleFailure(failure)
            }
            group.leave()
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let `self` else { return }
            self.lastTime = CFAbsoluteTimeGetCurrent()
            self.isLoading = false
        }
    }
    
    @objc
    func refreshControlValueChanged(_ sender: UIRefreshControl) {
        guard !isLoading else { return }
        guard (CFAbsoluteTimeGetCurrent() - lastTime) > 60 else {
            self.isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                sender.endRefreshing()
                self.isLoading = false
            }
            return
        }
        self.topicTypes.shuffle()
        
        let group = DispatchGroup()
        
        fetchTopics(group: group)
        
        group.notify(queue: .main) { [weak self] in
            guard let `self` else { return }
            self.lastTime = CFAbsoluteTimeGetCurrent()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                sender.endRefreshing()
                self.isLoading = false
            }
        }
    }
    
    func handleFailure(_ failure: Error) {
        if let baseError = failure as? BaseError {
            let message =  baseError.errors.joined(separator: "\n")
            self.presentAlert(title: "오류", message: message)
        } else {
            print(failure)
        }
    }
}

extension TopicViewController: UICollectionViewDelegate,
                               UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topics[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: .topicCollectionCell,
            for: indexPath
        ) as? TopicCollectionViewCell
        guard let cell else { return UICollectionViewCell() }
        
        cell.cellForItemAt(topics[collectionView.tag][indexPath.item])
        cell.layoutIfNeeded()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let topic = topics[collectionView.tag][indexPath.item]
        navigationController?.pushViewController(
            StatisticsViewController(photo: topic),
            animated: true
        )
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension TopicViewController {
    enum TopicType: String, CaseIterable {
        case goldenHour = "golden-hour"
        case businessWork = "business-work"
        case architectureInterior = "architecture-interior"
        case wallpapers = "wallpapers"
        case nature = "nature"
        case _3dRenders = "3d-renders"
        case travel = "travel"
        case texturesPatterns = "textures-patterns"
        case streetPhotography = "street-photography"
        case film = "film"
        case archival = "archival"
        case experimental = "experimental"
        case animals = "animals"
        case fashionBeauty = "fashion-beauty"
        case people = "people"
        case foodDrink = "food-drink"
        
        var title: String {
            switch self {
            case .goldenHour: return "골든 아워"
            case .businessWork: return "비지니스 및 업무"
            case .architectureInterior: return "건축 및 인테리어"
            case .wallpapers: return "배경 화면"
            case .nature: return "자연"
            case ._3dRenders: return "3D 렌더링"
            case .travel: return "여행하다"
            case .texturesPatterns: return "텍스쳐 및 패턴"
            case .streetPhotography: return "거리 사진"
            case .film: return "필름"
            case .archival: return "기록의"
            case .experimental: return "실험적인"
            case .animals: return "동물"
            case .fashionBeauty: return "패션 및 뷰티"
            case .people: return "사람"
            case .foodDrink: return "식음료"
            }
        }
    }
}
