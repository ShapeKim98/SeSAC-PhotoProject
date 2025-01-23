//
//  PhotoViewCell.swift
//  PhotoProject
//
//  Created by 김도형 on 1/19/25.
//

import UIKit

import Kingfisher
import SnapKit
import BaseKit

@Configurable
class PhotoViewCell: UIView {
    private let imageView = UIImageView()
    private let likesLabel = UILabel()
    private let likesLabelBackgroundView = UIView()
    
    private let isTopic: Bool
    
    init(frame: CGRect, isTopic: Bool) {
        self.isTopic = isTopic
        super.init(frame: frame)
        
        configureUI()
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
fatalError("init(coder:) has not been implemented")
    }
    
    func cellForItemAt<C: PhotoCellProtocol>(_ result: C) {
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: URL(string: result.urls.small),
            options: [.transition(.fade(0.3))]
        )
        
        likesLabel.text = result.likes.formatted()
    }
    
    func cancelImageDownload() {
        imageView.kf.cancelDownloadTask()
    }
    
    func roundLikesLabel() {
        let cornerRadius = likesLabelBackgroundView.frame.height / 2
        likesLabelBackgroundView.layer.cornerRadius = cornerRadius
    }
    
    private func configureImageView() {
        if isTopic {
            imageView.layer.cornerRadius = 16
            imageView.clipsToBounds = true
        }
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        addSubview(imageView)
    }
    
    private func configureLikesLabelBackgroundView() {
        likesLabelBackgroundView.backgroundColor = .darkGray
        likesLabelBackgroundView.addSubview(likesLabel)
        addSubview(likesLabelBackgroundView)
    }
    
    private func configureLikesLabel() {
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

private extension PhotoViewCell {
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
}
