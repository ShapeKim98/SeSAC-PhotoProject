//
//  TopicEndPoint.swift
//  PhotoProject
//
//  Created by 김도형 on 1/19/25.
//

import Foundation

import Alamofire

enum TopicEndPoint: EndPoint, Sendable {
    case fetchTopic(_ model: TopicRequest)
    
    var path: String {
        switch self {
        case .fetchTopic(let model): return "/topics/\(model.topic)/photos"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchTopic: return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case let .fetchTopic(model):
            let queryItems: Parameters = [
                "page": model.page,
                "per_page": model.perPage
            ]
            
            return queryItems
        }
    }
    
    var headers: HTTPHeaders? {
        return .authorization
    }
}
