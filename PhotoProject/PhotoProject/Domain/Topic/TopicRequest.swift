//
//  TopicRequest.swift
//  PhotoProject
//
//  Created by 김도형 on 1/19/25.
//

import Foundation

struct TopicRequest {
    let topic: String
    let page: Int
    let perPage: Int
    
    init(topic: String, page: Int = 1, perPage: Int = 10) {
        self.topic = topic
        self.page = page
        self.perPage = perPage
    }
}
