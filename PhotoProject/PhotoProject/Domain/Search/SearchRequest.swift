//
//  SearchRequest.swift
//  PhotoProject
//
//  Created by 김도형 on 1/19/25.
//

import Foundation

struct SearchRequest {
    let query: String
    let page: Int
    let perPage: Int
    let orderBy: String
    let color: String?
}
