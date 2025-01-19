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
    private let topics: [[TopicResponse]] = [.mock, .mock, .mock]
    private let contentView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        configureLayout()
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
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "OUR TOPIC"
    }
    
    func configureScrollView() {
        scrollView.isScrollEnabled = true
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
        for type in TopicType.allCases {
            let container = TopicCollectionViewContainer(
                title: type.title,
                topic: topics[type.tag],
                tag: type.tag
            )
            container.collectionView.delegate = self
            container.collectionView.dataSource = self
            topicCollectionViews.append(container)
            vstack.addArrangedSubview(container)
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
}

extension TopicViewController {
    enum TopicType: String, CaseIterable {
        case goldenHour = "golden-hour"
        case businessWork = "buisimess-work"
        case architectureInterior = "architecture-interior"
        
        var title: String {
            switch self {
            case .goldenHour: return "골든 아워"
            case .businessWork: return "비지니스 및 업무"
            case .architectureInterior: return "건축 및 인테리어"
            }
        }
        
        var tag: Int {
            switch self {
            case .goldenHour: return 0
            case .businessWork: return 1
            case .architectureInterior: return 2
            }
        }
    }
}
