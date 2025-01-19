//
//  Search.swift
//  PhotoProject
//
//  Created by 김도형 on 1/19/25.
//

import Foundation

struct SearchResponse: Decodable {
    let total: Int
    let totalPages: Int
    let results: [Result]
    
    enum CodingKeys: String, CodingKey {
        case total, results
        case totalPages = "total_pages"
    }
}

extension SearchResponse {
    struct Result: Decodable {
        let id: String
        let createdAt: String
        let width: CGFloat
        let height: CGFloat
        let urls: URLs
        let likes: Int
        
        enum CodingKeys: String, CodingKey {
            case id, width, height, urls, likes
            case createdAt = "created_at"
        }
    }
}

extension SearchResponse.Result {
    struct URLs: Decodable {
        let raw: String
        let small: String
    }
}

extension SearchResponse.Result {
    struct User: Decodable {
        let name: String
        let profileImage: ProfileImage
        
        enum CodingKeys: String, CodingKey {
            case name
            case profileImage = "profile_image"
        }
    }
}

extension SearchResponse.Result.User {
    struct ProfileImage: Decodable {
        let medium: String
    }
}

extension SearchResponse {
    static let mock = SearchResponse(
        total: 12,
        totalPages: 1,
        results: [
            SearchResponse.Result(
                id: "GwsGc5DM5Cs",
                createdAt: "2020-09-08T13:55:04Z",
                width: 5182,
                height: 3455,
                urls: SearchResponse.Result.URLs(
                    raw: "https://images.unsplash.com/photo-1599572743109-61c820b3a79d?ixlib=rb-4.0.3",
                    small: "https://images.unsplash.com/photo-1599572743109-61c820b3a79d?ixlib=rb-4.0.3&q=80&w=400"
                ),
                likes: 32
            ),
            SearchResponse.Result(
                id: "GX1fXQ97UdM",
                createdAt: "2022-08-01T20:46:54Z",
                width: 6000,
                height: 4000,
                urls: SearchResponse.Result.URLs(
                    raw: "https://images.unsplash.com/photo-1659386509213-b39ca54f9d68?ixlib=rb-4.0.3",
                    small: "https://images.unsplash.com/photo-1659386509213-b39ca54f9d68?ixlib=rb-4.0.3&q=80&w=400"
                ),
                likes: 2
            ),
            SearchResponse.Result(
                id: "bkwd7T4CYbM",
                createdAt: "2019-04-11T23:25:18Z",
                width: 6559,
                height: 4344,
                urls: SearchResponse.Result.URLs(
                    raw: "https://images.unsplash.com/photo-1555025093-6929dde6e070?ixlib=rb-4.0.3",
                    small: "https://images.unsplash.com/photo-1555025093-6929dde6e070?ixlib=rb-4.0.3&q=80&w=400"
                ),
                likes: 22
            ),
            SearchResponse.Result(
                id: "-hsCoQtcvCI",
                createdAt: "2019-11-02T15:44:19Z",
                width: 2340,
                height: 2925,
                urls: SearchResponse.Result.URLs(
                    raw: "https://images.unsplash.com/photo-1572709373673-0d3f985b4e30?ixlib=rb-4.0.3",
                    small: "https://images.unsplash.com/photo-1572709373673-0d3f985b4e30?ixlib=rb-4.0.3&q=80&w=400"
                ),
                likes: 41
            ),
            SearchResponse.Result(
                id: "ozLLvabH1pw",
                createdAt: "2022-08-30T13:30:34Z",
                width: 5616,
                height: 3744,
                urls: SearchResponse.Result.URLs(
                    raw: "https://images.unsplash.com/photo-1661866143866-7c4db1f004ac?ixlib=rb-4.0.3",
                    small: "https://images.unsplash.com/photo-1661866143866-7c4db1f004ac?ixlib=rb-4.0.3&q=80&w=400"
                ),
                likes: 65
            ),
            SearchResponse.Result(
                id: "DDRq7IetULc",
                createdAt: "2024-05-24T20:52:08Z",
                width: 2573,
                height: 3852,
                urls: SearchResponse.Result.URLs(
                    raw: "https://images.unsplash.com/photo-1716583731452-86cf639722f4?ixlib=rb-4.0.3",
                    small: "https://images.unsplash.com/photo-1716583731452-86cf639722f4?ixlib=rb-4.0.3&q=80&w=400"
                ),
                likes: 12
            ),
            SearchResponse.Result(
                id: "A6MQjINBCPM",
                createdAt: "2021-04-22T19:06:17Z",
                width: 4608,
                height: 3072,
                urls: SearchResponse.Result.URLs(
                    raw: "https://images.unsplash.com/photo-1619118295137-e83b05cfa8a9?ixlib=rb-4.0.3",
                    small: "https://images.unsplash.com/photo-1619118295137-e83b05cfa8a9?ixlib=rb-4.0.3&q=80&w=400"
                ),
                likes: 5
            ),
            SearchResponse.Result(
                id: "zbnOYJo6mKc",
                createdAt: "2019-05-31T12:06:24Z",
                width: 4143,
                height: 2685,
                urls: SearchResponse.Result.URLs(
                    raw: "https://images.unsplash.com/photo-1559303970-6d3f3a61b1b4?ixlib=rb-4.0.3",
                    small: "https://images.unsplash.com/photo-1559303970-6d3f3a61b1b4?ixlib=rb-4.0.3&q=80&w=400"
                ),
                likes: 142
            ),
            SearchResponse.Result(
                id: "yXt2BNgUHCI",
                createdAt: "2021-11-10T15:35:51Z",
                width: 3872,
                height: 2581,
                urls: SearchResponse.Result.URLs(
                    raw: "https://images.unsplash.com/photo-1636558287093-4a1362f95da4?ixlib=rb-4.0.3",
                    small: "https://images.unsplash.com/photo-1636558287093-4a1362f95da4?ixlib=rb-4.0.3&q=80&w=400"
                ),
                likes: 5
            ),
            SearchResponse.Result(
                id: "t2XsyKrWsNc",
                createdAt: "2021-11-10T15:35:51Z",
                width: 3872,
                height: 2581,
                urls: SearchResponse.Result.URLs(
                    raw: "https://images.unsplash.com/photo-1636558287093-4a1362f95da4?ixlib=rb-4.0.3",
                    small: "https://images.unsplash.com/photo-1636558287093-4a1362f95da4?ixlib=rb-4.0.3&q=80&w=400"
                ),
                likes: 5
            ),
            SearchResponse.Result(
                id: "UtbMaFYC83Y",
                createdAt: "2020-11-07T23:03:45Z",
                width: 6000,
                height: 4000,
                urls: SearchResponse.Result.URLs(
                    raw: "https://images.unsplash.com/photo-1604788893124-fe5c0e999602?ixlib=rb-4.0.3",
                    small: "https://images.unsplash.com/photo-1604788893124-fe5c0e999602?ixlib=rb-4.0.3&q=80&w=400"
                ),
                likes: 10
            ),
            SearchResponse.Result(
                id: "HoC9ttceIGo",
                createdAt: "2021-03-07T10:12:19Z",
                width: 3507,
                height: 5261,
                urls: SearchResponse.Result.URLs(
                    raw: "https://images.unsplash.com/photo-1615111784767-4d7c527f32a1?ixlib=rb-4.0.3",
                    small: "https://images.unsplash.com/photo-1615111784767-4d7c527f32a1?ixlib=rb-4.0.3&q=80&w=400"
                ),
                likes: 432
            )
        ]
    )
}
