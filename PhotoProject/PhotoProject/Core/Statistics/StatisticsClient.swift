//
//  StatisticsClient.swift
//  PhotoProject
//
//  Created by 김도형 on 1/20/25.
//

import Foundation

final class StatisticsClient {
    static let shared = StatisticsClient()
    
    private let provider = NetworkProvider<StatisticsEndPoint>()
    
    private init() { }
    
    func fetchStatistics(
        _ id: String,
        completion: @escaping (Result<StatisticsResponse, Error>) -> Void
    ) {
        provider.request(.fetchStatistics(id), completion: completion)
    }
}
