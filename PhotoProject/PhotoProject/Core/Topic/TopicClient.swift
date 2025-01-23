//
//  TopicClient.swift
//  PhotoProject
//
//  Created by 김도형 on 1/19/25.
//

import Foundation

final class TopicClient {
    static let shared = TopicClient()
    
    private let provider = NetworkProvider<TopicEndPoint>()
    
    private init() { }
    
    func fetchTopics(
        _ model: TopicRequest,
        completion: @escaping (Result<[TopicResponse], Error>) -> Void
    ) {
        provider.request(.fetchTopic(model), completion: completion)
    }
}
