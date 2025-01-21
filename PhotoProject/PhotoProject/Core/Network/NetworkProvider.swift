//
//  NetworkManager.swift
//  DoBongShopping
//
//  Created by 김도형 on 1/16/25.
//

import Foundation

import Alamofire

struct NetworkProvider<E: EndPoint>: Sendable {
    func request<T: Decodable & Sendable>(
        _ endPoint: E,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard
            let url = try? (String.baseURL + endPoint.path).asURL()
        else {
            let error = AFError.parameterEncodingFailed(reason: .missingURL)
            completion(.failure(error))
            return
        }
        
        AF.request(
            url,
            method: endPoint.method,
            parameters: endPoint.parameters,
            encoding: URLEncoding.queryString,
            headers: endPoint.headers
        )
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                if let data = response.data {
                    if let baseError = try? JSONDecoder().decode(BaseError.self, from: data) {
                        completion(.failure(baseError))
                        return
                    }
                    
                    if let errorString = String(data: data, encoding: .utf8) {
                        completion(.failure(BaseError(errors: [errorString])))
                        return
                    }
                }
                
                completion(.failure(error))
            }
        }
    }
}

extension String {
    static let baseURL = "https://api.unsplash.com"
}

extension HTTPHeaders {
    static let authorization: HTTPHeaders = [
        "Authorization": "Client-ID " + Bundle.main.clientId
    ]
}
