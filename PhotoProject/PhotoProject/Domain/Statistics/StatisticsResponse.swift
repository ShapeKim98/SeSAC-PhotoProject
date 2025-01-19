//
//  Statistics.swift
//  PhotoProject
//
//  Created by 김도형 on 1/19/25.
//

import Foundation

struct StatisticsResponse: Decodable {
    let id: String
    let downloads: DownLoads
    let views: Views
}

extension StatisticsResponse {
    struct DownLoads: Decodable {
        let total: Int
        let historical: Historical
    }
    
    struct Views: Decodable {
        let total: Int
        let historical: Historical
    }
}

extension StatisticsResponse {
    static let mock = StatisticsResponse(
        id: "SLFgkJrNwV8",
        downloads: StatisticsResponse.DownLoads(
            total: 16,
            historical: Historical(values: [
                Historical.Value(date: "2024-12-20", value: 0),
                Historical.Value(date: "2024-12-21", value: 0),
                Historical.Value(date: "2024-12-22", value: 0),
                Historical.Value(date: "2024-12-23", value: 0),
                Historical.Value(date: "2024-12-24", value: 0),
                Historical.Value(date: "2024-12-25", value: 0),
                Historical.Value(date: "2024-12-26", value: 0),
                Historical.Value(date: "2024-12-27", value: 0),
                Historical.Value(date: "2024-12-28", value: 0),
                Historical.Value(date: "2024-12-29", value: 0),
                Historical.Value(date: "2024-12-30", value: 0),
                Historical.Value(date: "2024-12-31", value: 0),
                Historical.Value(date: "2025-01-01", value: 0),
                Historical.Value(date: "2025-01-02", value: 0),
                Historical.Value(date: "2025-01-03", value: 0),
                Historical.Value(date: "2025-01-04", value: 0),
                Historical.Value(date: "2025-01-05", value: 0),
                Historical.Value(date: "2025-01-06", value: 0),
                Historical.Value(date: "2025-01-07", value: 0),
                Historical.Value(date: "2025-01-08", value: 0),
                Historical.Value(date: "2025-01-09", value: 0),
                Historical.Value(date: "2025-01-10", value: 0),
                Historical.Value(date: "2025-01-11", value: 0),
                Historical.Value(date: "2025-01-12", value: 0),
                Historical.Value(date: "2025-01-13", value: 0),
                Historical.Value(date: "2025-01-14", value: 0),
                Historical.Value(date: "2025-01-15", value: 0),
                Historical.Value(date: "2025-01-16", value: 0),
                Historical.Value(date: "2025-01-17", value: 3),
                Historical.Value(date: "2025-01-18", value: 9)
            ])
        ),
        views: StatisticsResponse.Views(
            total: 42021,
            historical: Historical(values: [
                Historical.Value(date: "2024-12-20", value: 0),
                Historical.Value(date: "2024-12-21", value: 0),
                Historical.Value(date: "2024-12-22", value: 0),
                Historical.Value(date: "2024-12-23", value: 0),
                Historical.Value(date: "2024-12-24", value: 0),
                Historical.Value(date: "2024-12-25", value: 0),
                Historical.Value(date: "2024-12-26", value: 0),
                Historical.Value(date: "2024-12-27", value: 0),
                Historical.Value(date: "2024-12-28", value: 0),
                Historical.Value(date: "2024-12-29", value: 0),
                Historical.Value(date: "2024-12-30", value: 0),
                Historical.Value(date: "2024-12-31", value: 0),
                Historical.Value(date: "2025-01-01", value: 0),
                Historical.Value(date: "2025-01-02", value: 0),
                Historical.Value(date: "2025-01-03", value: 0),
                Historical.Value(date: "2025-01-04", value: 0),
                Historical.Value(date: "2025-01-05", value: 0),
                Historical.Value(date: "2025-01-06", value: 0),
                Historical.Value(date: "2025-01-07", value: 0),
                Historical.Value(date: "2025-01-08", value: 0),
                Historical.Value(date: "2025-01-09", value: 0),
                Historical.Value(date: "2025-01-10", value: 0),
                Historical.Value(date: "2025-01-11", value: 0),
                Historical.Value(date: "2025-01-12", value: 0),
                Historical.Value(date: "2025-01-13", value: 0),
                Historical.Value(date: "2025-01-14", value: 0),
                Historical.Value(date: "2025-01-15", value: 0),
                Historical.Value(date: "2025-01-16", value: 0),
                Historical.Value(date: "2025-01-17", value: 27),
                Historical.Value(date: "2025-01-18", value: 29173)
            ])
        )
    )
}
