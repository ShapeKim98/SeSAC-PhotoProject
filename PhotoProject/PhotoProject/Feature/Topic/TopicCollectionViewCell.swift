//
//  TopicCollectionViewCell.swift
//  PhotoProject
//
//  Created by 김도형 on 1/19/25.
//

import UIKit

import SnapKit
import BaseKit

@Configurable
final class TopicCollectionViewCell: UICollectionViewCell {
    private let photoCell: PhotoViewCell
    
    override init(frame: CGRect) {
        self.photoCell = PhotoViewCell(frame: frame, isTopic: true)
        super.init(frame: frame)
        backgroundColor = .clear
        
        contentView.addSubview(photoCell)
        photoCell.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        photoCell.roundLikesLabel()
    }
    
    func cellForItemAt(_ result: TopicResponse) {
        photoCell.cellForItemAt(result)
    }
    
    func cancelImageDownload() {
        photoCell.cancelImageDownload()
    }
}

extension String {
    static let topicCollectionCell = "TopicCollectionViewCell"
}
