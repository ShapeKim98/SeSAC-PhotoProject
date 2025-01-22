//
//  TopicCollectionViewContainer.swift
//  PhotoProject
//
//  Created by 김도형 on 1/19/25.
//

import UIKit

import SnapKit

final class TopicCollectionViewContainer: UIView {
    private let titleLabel = UILabel()
    lazy var collectionView: UICollectionView = {
        configureCollectionView()
    }()
    
    private var title: String
    private let topic: [TopicResponse]
    
    init(title: String, topic: [TopicResponse] = .mock, tag: Int) {
        self.title = title
        self.topic = topic
        super.init(frame: .zero)
        self.collectionView.tag = tag
        
        configureUI()
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(_ title: String) {
        self.titleLabel.text = title
        self.title = title
    }
}

private extension TopicCollectionViewContainer {
    func configureUI() {
        addSubview(collectionView)
        
        configureTitleLabel()
    }
    
    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(200 * 1.2)
        }
    }
    
    func configureCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        let width: CGFloat = 200
        layout.itemSize = CGSize(width: width, height: width * 1.2)
        layout.sectionInset = UIEdgeInsets(
            top: 8,
            left: 16,
            bottom: 8,
            right: 16
        )
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.backgroundColor = .clear
        collectionView.register(
            TopicCollectionViewCell.self,
            forCellWithReuseIdentifier: .topicCollectionCell
        )
        
        return collectionView
    }
    
    func configureTitleLabel() {
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        addSubview(titleLabel)
    }
}
