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
    
    var parameters: [URLQueryItem]? {
        switch self {
        case let .fetchTopic(model):
            let queryItems: [URLQueryItem] = [
                URLQueryItem(name: "page", value: "\(model.page)"),
                URLQueryItem(name: "per_page", value: "\(model.perPage)")
            ]
            
            return queryItems
        }
    }
}
