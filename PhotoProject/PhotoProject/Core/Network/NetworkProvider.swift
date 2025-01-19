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
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let data):
                        continuation.resume(returning: data)
                    case .failure(let error):
                        if let data = response.data {
                            if let baseError = try? JSONDecoder().decode(BaseError.self, from: data) {
                                continuation.resume(throwing: baseError)
                                return
                            }
                            
                            if let errorString = String(data: data, encoding: .utf8) {
                                continuation.resume(throwing: BaseError(errors: [errorString]))
                                return
                            }
                        }
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}
