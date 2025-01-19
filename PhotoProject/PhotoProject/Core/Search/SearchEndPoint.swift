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
    
    var parameters: [URLQueryItem]? {
        switch self {
        case let .fetchSearch(model):
            var queryItems = [
                URLQueryItem(name: "query", value: model.query),
                URLQueryItem(name: "page", value: "\(model.page)"),
                URLQueryItem(name: "per_page", value: "\(model.perPage)"),
                URLQueryItem(name: "order_by", value: "\(model.orderBy)"),
            ]
            if let color = model.color {
                queryItems.append(URLQueryItem(name: "color", value: color))
            }
            return queryItems
        }
    }
}
