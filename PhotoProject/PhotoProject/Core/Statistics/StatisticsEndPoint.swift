//
//  StatisticsEndPoint.swift
//  PhotoProject
//
//  Created by 김도형 on 1/20/25.
//

import Foundation

import Alamofire

enum StatisticsEndPoint: EndPoint, Sendable {
    case fetchStatistics(_ id: String)
    
    var path: String {
        switch self {
        case .fetchStatistics(let id): return "/photos/\(id)/statistics"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchStatistics: return .get
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        case .fetchStatistics: return nil
        }
    }
}
