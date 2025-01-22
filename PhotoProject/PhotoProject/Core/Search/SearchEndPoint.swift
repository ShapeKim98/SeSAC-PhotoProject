//
//  SearchEndPoint.swift
//  PhotoProject
//
//  Created by 김도형 on 1/19/25.
//

import Foundation

import Alamofire

enum SearchEndPoint: EndPoint, Sendable {
    case fetchSearch(_ model: SearchRequest)
    
    var path: String {
        switch self {
        case .fetchSearch: return "/search/photos"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchSearch: return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case let .fetchSearch(model):
            var queryItems: Parameters = [
                "query": model.query,
                "page": model.page,
                "per_page": model.perPage,
                "order_by": model.orderBy
            ]
            if let color = model.color {
                queryItems.updateValue(color, forKey: "color")
            }
            return queryItems
        }
    }
    
    var headers: HTTPHeaders? {
        return .authorization
    }
}
