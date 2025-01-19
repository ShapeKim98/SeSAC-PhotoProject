//
//  TopicCollectionViewCell.swift
//  PhotoProject
//
//  Created by 김도형 on 1/19/25.
//

import UIKit

class TopicCollectionViewCell: UICollectionViewCell {
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
