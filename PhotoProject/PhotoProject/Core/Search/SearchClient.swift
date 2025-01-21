//
//  SearchClient.swift
//  PhotoProject
//
//  Created by 김도형 on 1/19/25.
//

import Foundation

actor SearchClient {
    static let shared = SearchClient()
    
    private let provider = NetworkProvider<SearchEndPoint>()
    
    private init() { }
    
    func fetchSearch(
        _ model: SearchRequest,
        completion: @escaping (Result<SearchResponse, Error>) -> Void
    )  {
        provider.request(.fetchSearch(model), completion: completion)
    }
}
