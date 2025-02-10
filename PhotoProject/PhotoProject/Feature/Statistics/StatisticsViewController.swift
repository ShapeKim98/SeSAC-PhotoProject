//
//  StatisticsViewController.swift
//  PhotoProject
//
//  Created by 김도형 on 1/19/25.
//

import UIKit
import SwiftUI

import Kingfisher
import SnapKit
import BaseKit

@Configurable
final class StatisticsViewController: UIViewController {
    private let imageView = UIImageView()
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let createdAtLabel = UILabel()
    private let infoLabel = UILabel()
    private let chartLabel = UILabel()
    private let infoVStack = UIStackView()
    private let contentView = UIView()
    private let scrollView = UIScrollView()
    private var infoDetailLabels = [InfoDetailLabel]()
    private let activityIndicatorView = UIActivityIndicatorView(style: .large)
    private var chartController = UIHostingController(rootView: StatisticChartView())
    
    private let viewModel: StatisticViewModel
    
    init(viewModel: StatisticViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataBinding()
        
        view.backgroundColor = .systemBackground
        
        configureUI()
        
        addChild(chartController)
        contentView.addSubview(chartController.view)
        chartController.didMove(toParent: self)
        
        configureLayout()
        
        viewModel.input(.viewDidLoad)
    }
    
    private func configureScrollView() {
        scrollView.isScrollEnabled = true
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
    }
    
    private func configureNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .label
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    private func configureProfileImageView() {
        let url = URL(string: viewModel.model.photo.user.profileImage.medium)
        profileImageView.kf.setImage(
            with: url,
            options: [.transition(.fade(0.3))]
        )
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.cornerRadius = 16
        profileImageView.clipsToBounds = true
        contentView.addSubview(profileImageView)
    }
    
    private func configureImageView() {
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: URL(string: viewModel.model.photo.urls.regular)
        )
        imageView.contentMode = .scaleAspectFill
        contentView.addSubview(imageView)
    }
    
    private func configureNameLabel() {
        nameLabel.text = viewModel.model.photo.user.name
        nameLabel.font = .systemFont(ofSize: 12)
        contentView.addSubview(nameLabel)
    }
    
    private func configureCreatedAtLabel() {
        let date = viewModel.model.photo.createdAt.date(format: .yyyy_MM_dd)
        createdAtLabel.text = date?.string(format: .yyyy년_M월_d일)
        createdAtLabel.font = .systemFont(ofSize: 10, weight: .bold)
        contentView.addSubview(createdAtLabel)
    }
    
    private func configureInfoLabel() {
        infoLabel.text = "정보"
        infoLabel.font = .systemFont(ofSize: 20, weight: .bold)
        contentView.addSubview(infoLabel)
    }
    
    private func configureChartLabel() {
        chartLabel.text = "차트"
        chartLabel.font = .systemFont(ofSize: 20, weight: .bold)
        contentView.addSubview(chartLabel)
    }
    
    private func configureInfoVStack() {
        infoVStack.axis = .vertical
        infoVStack.spacing = 12
        infoVStack.distribution = .fillProportionally
        contentView.addSubview(infoVStack)
    }
    
    private func configureInfoDetailLabel() {
        let size = InfoDetailLabel(
            title: "크기",
            value: "\(Int(viewModel.model.photo.height)) x \(Int(viewModel.model.photo.width))"
        )
        infoDetailLabels.append(size)
        infoVStack.addArrangedSubview(size)
        let views = InfoDetailLabel(
            title: "조회수",
            value: viewModel.model.statistics?.views.total.formatted() ?? "0"
        )
        infoDetailLabels.append(views)
        infoVStack.addArrangedSubview(views)
        let downloads = InfoDetailLabel(
            title: "다운로드",
            value: viewModel.model.statistics?.downloads.total.formatted() ?? "0"
        )
        infoDetailLabels.append(downloads)
        infoVStack.addArrangedSubview(downloads)
    }
    
    private func configureActivityIndicator() {
        view.addSubview(activityIndicatorView)
    }
}

// MARK: Configure View
private extension StatisticsViewController {
    func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.verticalEdges.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints { make in
            make.size.equalTo(32)
            make.top.equalTo(contentView.snp.top).inset(16)
            make.leading.equalToSuperview().inset(16)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top).inset(2)
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
        }
        
        createdAtLabel.snp.makeConstraints { make in
            make.bottom.equalTo(profileImageView.snp.bottom).inset(2)
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
        }
        
        imageView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(contentView.snp.width)
                .multipliedBy(viewModel.model.photo.height / viewModel.model.photo.width)
            
            make.top.equalTo(profileImageView.snp.bottom).offset(16)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.width.equalTo(100)
        }
        
        infoVStack.snp.makeConstraints { make in
            make.leading.equalTo(infoLabel.snp.trailing)
            make.trailing.equalToSuperview().inset(16)
            make.top.equalTo(imageView.snp.bottom).offset(16)
        }
        
        activityIndicatorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        chartLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(infoVStack.snp.bottom).offset(16)
            make.width.equalTo(100)
        }
        
        chartController.view.snp.makeConstraints { make in
            make.leading.equalTo(chartLabel.snp.trailing)
            make.trailing.equalToSuperview().inset(16)
            make.top.equalTo(infoVStack.snp.bottom).offset(16)
            make.height.equalTo(300)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: Data Bindings
private extension StatisticsViewController {
    func dataBinding() {
        Task {
            for await output in viewModel.output {
                switch output {
                case let .statistics(statistics):
                    bindedStatistics(statistics)
                case let .errorMessage(message):
                    bindedErrorMessage(message)
                }
            }
        }
    }
    
    func bindedStatistics(_ statistics: StatisticsResponse?) {
        guard let statistics else { return }
        
        let views = statistics.views.total.formatted()
        infoDetailLabels[1].setValue(value: views)
        let downloads = statistics.downloads.total.formatted()
        infoDetailLabels[2].setValue(value: downloads)
        chartController.rootView = StatisticChartView(statistics: statistics)
        
        activityIndicatorView.isHidden = true
        activityIndicatorView.stopAnimating()
    }
    
    func bindedErrorMessage(_ message: String?) {
        presentAlert(title: "오류", message: message)
    }
}

private extension StatisticsViewController {
    final class InfoDetailLabel: UIView {
        private let titleLabel = UILabel()
        private let valueLabel = UILabel()
        
        init(title: String, value: String) {
            super.init(frame: .zero)
            
            configureUI(title: title, value: value)
            
            configureLayout()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setValue(value: String) {
            valueLabel.text = value
        }
        
        private func configureUI(title: String, value: String) {
            titleLabel.text = title
            titleLabel.font = .systemFont(ofSize: 14, weight: .bold)
            addSubview(titleLabel)
            
            valueLabel.text = value
            valueLabel.textColor = .darkGray
            valueLabel.font = .systemFont(ofSize: 14)
            addSubview(valueLabel)
        }
        
        private func configureLayout() {
            titleLabel.snp.makeConstraints { make in
                make.leading.equalToSuperview()
                make.verticalEdges.equalToSuperview()
            }
            
            valueLabel.snp.makeConstraints { make in
                make.trailing.equalToSuperview()
                make.verticalEdges.equalToSuperview()
            }
        }
    }
}
