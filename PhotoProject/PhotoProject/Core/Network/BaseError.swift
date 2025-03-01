//
//  BaseError.swift
//  PhotoProject
//
//  Created by 김도형 on 1/19/25.
//

import Foundation

struct BaseError: Decodable, Error, Equatable {
    let errors: [String]
}
