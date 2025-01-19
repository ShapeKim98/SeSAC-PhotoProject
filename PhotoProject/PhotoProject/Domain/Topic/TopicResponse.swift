//
//  TopicResponse.swift
//  PhotoProject
//
//  Created by 김도형 on 1/19/25.
//

import Foundation

struct TopicResponse: Decodable, PhotoCellProtocol {
    let id: String
    let createdAt: String
    let width: CGFloat
    let height: CGFloat
    let urls: URLs
    let likes: Int
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case id, width, height, urls, likes, user
        case createdAt = "created_at"
    }
}

extension [TopicResponse] {
    static let mock: [TopicResponse] = [
        TopicResponse(
            id: "SLFgkJrNwV8",
            createdAt: "2025-01-17T11:36:34Z",
            width: 2207,
            height: 3130,
            urls: URLs(
                raw: "https://images.unsplash.com/photo-1737113725171-3d6860f7cbc0?ixid=M3w2OTg2MTN8MHwxfHRvcGljfHxobWVudlFoVW14TXx8fHx8Mnx8MTczNzI3NzcyMnw&ixlib=rb-4.0.3",
                small: "https://images.unsplash.com/photo-1737113725171-3d6860f7cbc0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.0.3&q=80&w=400"
            ),
            likes: 1,
            user: User(
                name: "Richard Stachmann",
                profileImage: User.ProfileImage(
                    medium: "https://images.unsplash.com/profile-fb-1661599666-081b04e75823.jpg?ixlib=rb-4.0.3&crop=faces&fit=crop&w=128&h=128"
                )
            )
        ),
        TopicResponse(
            id: "xkhAeb6fnGM",
            createdAt: "2025-01-17T11:36:34Z",
            width: 2207,
            height: 3130,
            urls: URLs(
                raw: "https://images.unsplash.com/photo-1737113725148-aa383a71ecd2?ixid=M3w2OTg2MTN8MHwxfHRvcGljfHxobWVudlFoVW14TXx8fHx8Mnx8MTczNzI3NzcyMnw&ixlib=rb-4.0.3",
                small: "https://images.unsplash.com/photo-1737113725148-aa383a71ecd2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.0.3&q=80&w=400"
            ),
            likes: 2,
            user: User(
                name: "Richard Stachmann",
                profileImage: User.ProfileImage(
                    medium: "https://images.unsplash.com/profile-fb-1661599666-081b04e75823.jpg?ixlib=rb-4.0.3&crop=faces&fit=crop&w=128&h=128"
                )
            )
        ),
        TopicResponse(
            id: "RMRdx4DQUv4",
            createdAt: "2025-01-16T15:33:37Z",
            width: 6774,
            height: 4492,
            urls: URLs(
                raw: "https://images.unsplash.com/photo-1737041315337-c555db33887f?ixid=M3w2OTg2MTN8MHwxfHRvcGljfHxobWVudlFoVW14TXx8fHx8Mnx8MTczNzI3NzcyMnw&ixlib=rb-4.0.3",
                small: "https://images.unsplash.com/photo-1737041315337-c555db33887f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.0.3&q=80&w=400"
            ),
            likes: 1,
            user: User(
                name: "Zhen Yao",
                profileImage: User.ProfileImage(
                    medium: "https://images.unsplash.com/profile-1545600588648-05099ce74acf?ixlib=rb-4.0.3&crop=faces&fit=crop&w=128&h=128"
                )
            )
        ),
        TopicResponse(
            id: "Mk69XDUR7Vo",
            createdAt: "2025-01-15T12:16:18Z",
            width: 2075,
            height: 3130,
            urls: URLs(
                raw: "https://images.unsplash.com/photo-1736942901968-cdc44bff3295?ixid=M3w2OTg2MTN8MHwxfHRvcGljfHxobWVudlFoVW14TXx8fHx8Mnx8MTczNzI3NzcyMnw&ixlib=rb-4.0.3",
                small: "https://images.unsplash.com/photo-1736942901968-cdc44bff3295?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.0.3&q=80&w=400"
            ),
            likes: 35,
            user: User(
                name: "Victor Oonk",
                profileImage: User.ProfileImage(
                    medium: "https://images.unsplash.com/profile-1589377215536-772fac430761image?ixlib=rb-4.0.3&crop=faces&fit=crop&w=128&h=128"
                )
            )
        ),
        TopicResponse(
            id: "Ef1zwl1kfiQ",
            createdAt: "2025-01-16T21:50:31Z",
            width: 1830,
            height: 2740,
            urls: URLs(
                raw: "https://images.unsplash.com/photo-1737064144135-4e6e46974261?ixid=M3w2OTg2MTN8MHwxfHRvcGljfHxobWVudlFoVW14TXx8fHx8Mnx8MTczNzI3NzcyMnw&ixlib=rb-4.0.3",
                small: "https://images.unsplash.com/photo-1737064144135-4e6e46974261?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixlib=rb-4.0.3&q=80&w=400"
            ),
            likes: 46,
            user: User(
                name: "Jessica Christian",
                profileImage: User.ProfileImage(
                    medium: "https://images.unsplash.com/profile-1589377215536-772fac430761image?ixlib=rb-4.0.3&crop=faces&fit=crop&w=128&h=128"
                )
            )
        )
    ]
}
