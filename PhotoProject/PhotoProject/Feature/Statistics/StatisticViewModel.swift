//
//  StatisticViewModel.swift
//  PhotoProject
//
//  Created by 김도형 on 2/10/25.
//

import Foundation

final class StatisticViewModel: ViewModel {
    enum Input {
        case viewDidLoad
    }
    
    enum Output {
        case statistics(_ value: StatisticsResponse?)
        case errorMessage(_ value: String?)
    }
    
    struct Model {
        let photo: PhotoCellProtocol
        var statistics: StatisticsResponse? {
            didSet {
                guard oldValue != statistics else { return }
                continuation?.yield(.statistics(statistics))
            }
        }
        var errorMessage: String? {
            didSet {
                guard
                    oldValue != errorMessage,
                    errorMessage != nil
                else { return }
                continuation?.yield(.errorMessage(errorMessage))
                errorMessage = nil
            }
        }
        
        fileprivate var continuation: AsyncStream<Output>.Continuation?
    }
    
    private(set) var model: Model
    
    private let statisticsClient = StatisticsClient.shared
    
    init(photo: PhotoCellProtocol) {
        self.model = Model(photo: photo)
    }
    
    deinit { model.continuation?.finish() }
    
    var output: AsyncStream<Output> {
        return AsyncStream { continuation in
            model.continuation = continuation
        }
    }
    
    func input(_ action: Input) {
        switch action {
        case .viewDidLoad:
            fetchStatistics()
        }
    }
}

private extension StatisticViewModel {
    func fetchStatistics() {
        statisticsClient.fetchStatistics(model.photo.id) { [weak self] result in
            guard let `self` else { return }
            switch result {
            case .success(let success):
                model.statistics = success
            case .failure(let failure):
                if let baseError = failure as? BaseError {
                    let message =  baseError.errors.joined(separator: "\n")
                    model.errorMessage = message
                } else {
                    print(failure)
                }
            }
        }
    }
}
