//
//  TopicClient.swift
//  PhotoProject
//
//  Created by 김도형 on 1/19/25.
//

import Foundation

actor TopicClient {
    static let shared = TopicClient()
    
    private let provider = NetworkProvider<TopicEndPoint>()
    
    private init() { }
    
    func fetchTopics(_ model: TopicRequest) async throws -> [TopicResponse] {
        try await provider.request(.fetchTopic(model))
    }
}
