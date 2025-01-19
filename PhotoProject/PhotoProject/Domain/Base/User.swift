//
//  User.swift
//  PhotoProject
//
//  Created by 김도형 on 1/19/25.
//

import Foundation

struct User: Decodable {
    let name: String
    let profileImage: ProfileImage
    
    enum CodingKeys: String, CodingKey {
        case name
        case profileImage = "profile_image"
    }
}

extension User {
    struct ProfileImage: Decodable {
        let medium: String
    }
}
