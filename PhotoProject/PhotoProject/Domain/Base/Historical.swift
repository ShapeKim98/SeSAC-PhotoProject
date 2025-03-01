//
//  Value.swift
//  PhotoProject
//
//  Created by 김도형 on 1/19/25.
//

import Foundation

struct Historical: Decodable, Equatable {
    let values: [Value]
}

extension Historical {
    struct Value: Decodable, Equatable {
        let date: String
        let value: Int
    }
}
