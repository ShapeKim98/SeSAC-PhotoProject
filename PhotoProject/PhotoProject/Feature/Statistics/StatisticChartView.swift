//
//  StatisticChartView.swift
//  PhotoProject
//
//  Created by 김도형 on 1/20/25.
//

import SwiftUI
import Charts

struct StatisticChartView: View {
    @State
    private var selectedTab: Tab = .views
    
    private let statistics: StatisticsResponse?
    
    init(statistics: StatisticsResponse? = nil) {
        self.statistics = statistics
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            picker
            
            chart
        }
    }
}

private extension StatisticChartView {
    var picker: some View {
        Picker("", selection: $selectedTab) {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                Text(tab.rawValue)
                    .tag(tab)
            }
        }
        .pickerStyle(.segmented)
        .fixedSize()
    }
    
    var chart: some View {
        Chart {
            ForEach(values, id: \.date) { value in
                AreaMark(
                    x: .value("날짜", value.date.date(format: .yyyy_MM_dd) ?? .now),
                    y: .value("값", value.value)
                )
            }
        }
        .animation(.easeInOut, value: values)
    }
    
    var values: [Historical.Value] {
        if let statistics {
            switch selectedTab {
            case .views: return statistics.views.historical.values
            case .downloads: return statistics.downloads.historical.values
            }
        } else {
            return []
        }
    }
}

private extension StatisticChartView {
    enum Tab: String, CaseIterable {
        case views = "조회"
        case downloads = "다운로드"
    }
}

#Preview {
    StatisticChartView(statistics: .mock)
}
