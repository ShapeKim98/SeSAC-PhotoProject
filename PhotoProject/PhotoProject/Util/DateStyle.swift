//
//  DateStyle.swift
//  SnapKitPractice
//
//  Created by 김도형 on 1/15/25.
//

import Foundation

public enum DateStyle: String, CaseIterable {
    case yyyy_MM_dd = "yyyy-MM-dd"
    case yyyy년_M월_d일 = "yyyy년 MM월 dd일"
    
    public var strategy: Date.ParseStrategy {
        switch self {
        case .yyyy_MM_dd:
            return Date.ParseStrategy(
                format: "\(year: .defaultDigits)-\(month: .twoDigits)-\(day: .twoDigits)",
                timeZone: .autoupdatingCurrent
            )
        case .yyyy년_M월_d일:
            return Date.ParseStrategy(
                format: "\(year: .defaultDigits)년 \(month: .defaultDigits)월 \(day: .defaultDigits)일",
                timeZone: .autoupdatingCurrent
            )
        }
    }
    
    static var cachedFormatter: [DateStyle: DateFormatter] {
        var cache: [DateStyle: DateFormatter] = [:]
        for style in DateStyle.allCases {
            let formatter = DateFormatter()
            formatter.dateFormat = style.rawValue
            cache[style] = formatter
        }
        return cache
    }
}

public extension DateFormatter {
    static let cached = DateStyle.cachedFormatter
}

public extension String {
    func date(format: DateStyle) -> Date? {
        return try? Date(self, strategy: format.strategy)
    }
}

public extension Date {
    func string(format: DateStyle) -> String {
        let formatter: DateFormatter = .cached[format] ?? DateFormatter()
        return formatter.string(from: self)
    }
}
