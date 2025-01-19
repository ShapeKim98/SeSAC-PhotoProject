//
//  StatisticsClient.swift
//  PhotoProject
//
//  Created by 김도형 on 1/20/25.
//

import Foundation

actor StatisticsClient {
    static let shared = StatisticsClient()
    
    private let provider = NetworkProvider<StatisticsEndPoint>()
    
    private init() { }
    
    func fetchStatistics(_ id: String) async throws -> StatisticsResponse {
        try await provider.request(.fetchStatistics(id))
    }
}
