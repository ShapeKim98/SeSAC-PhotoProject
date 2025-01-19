//
//  NetworkManager.swift
//  DoBongShopping
//
//  Created by 김도형 on 1/16/25.
//

import Foundation

import Alamofire

struct NetworkProvider<E: EndPoint>: Sendable {
    func request<T: Decodable & Sendable>(_ endPoint: E) async throws -> T {
        var urlComponent = URLComponents(string: "https://api.unsplash.com")
        urlComponent?.path = endPoint.path
        urlComponent?.queryItems = endPoint.parameters
        
        let url = urlComponent?.url?.absoluteString
        guard let url else {
            throw AFError.parameterEncodingFailed(reason: .missingURL)
        }
        
        let header = HTTPHeaders([
            "Authorization": "Client-ID " + Bundle.main.clientId
        ])
        
        print(url)
        
        return try await withCheckedThrowingContinuation { continuation in
            AF
                .request(url, method: endPoint.method, headers: header)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let data):
//                        dump(data)
                        continuation.resume(returning: data)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}
