//
//  PhotoCellProtocol.swift
//  PhotoProject
//
//  Created by 김도형 on 1/19/25.
//

import Foundation

protocol PhotoCellProtocol {
    var id: String { get }
    var urls: URLs { get }
    var likes: Int { get}
    var user: User { get }
    var width: CGFloat { get }
    var height: CGFloat { get }
    var createdAt: String { get }
}
