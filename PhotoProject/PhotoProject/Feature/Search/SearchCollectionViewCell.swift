//
//  SearchCollectionViewCell.swift
//  PhotoProject
//
//  Created by 김도형 on 1/19/25.
//

import UIKit

import Kingfisher
import SnapKit

class SearchCollectionViewCell: UICollectionViewCell {
    private let imageView = UIImageView()
    private let likesLabel = UILabel()
    private let likesLabelBackgroundView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        configureUI()
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        let cornerRadius = likesLabelBackgroundView.frame.height / 2
        likesLabelBackgroundView.layer.cornerRadius = cornerRadius
    }
    
    func cellForItemAt(_ result: SearchResponse.Result) {
        let size = imageView.bounds.size
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: URL(string: result.urls.small),
            options: [
                .processor(DownsamplingImageProcessor(size: size)),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage
            ]
        )
        
        likesLabel.text = result.likes.formatted()
    }
    
    func cancelImageDownload() {
        imageView.kf.cancelDownloadTask()
    }
}

private extension SearchCollectionViewCell {
    func configureUI() {
        configureImageView()
        
        configureLikesLabelBackgroundView()
        
        configureLikesLabel()
    }
    
    func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(imageView.snp.width).multipliedBy(1.2)
        }
        
        likesLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(12)
            make.verticalEdges.equalToSuperview().inset(8)
        }
        
        likesLabelBackgroundView.snp.makeConstraints { make in
            make.bottom.leading.equalToSuperview().inset(20)
        }
    }
    
    func configureImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
    }
    
    func configureLikesLabelBackgroundView() {
        likesLabelBackgroundView.backgroundColor = .darkGray
        likesLabelBackgroundView.addSubview(likesLabel)
        contentView.addSubview(likesLabelBackgroundView)
    }
    
    func configureLikesLabel() {
        likesLabel.textColor = .white
        likesLabel.font = .systemFont(ofSize: 14)
        
        let star = UIImage(systemName: "star.fill")
        let starImage = UIImageView(image: star)
        starImage.tintColor = .systemYellow
        
        likesLabelBackgroundView.addSubview(starImage)
        starImage.snp.makeConstraints { make in
            make.size.equalTo(16)
            make.trailing.equalTo(likesLabel.snp.leading).offset(-8)
            make.verticalEdges.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(12)
        }
    }
}

extension String {
    static let searchCollectionCell = "SearchCollectionViewCell"
}
