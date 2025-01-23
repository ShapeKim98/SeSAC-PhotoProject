//
//  LevelViewController.swift
//  SeSACDay22Assignment
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit
import BaseKit

protocol LevelViewControllerDelegate: AnyObject {
    func okLevelButtonTapped(_ level: String?)
}

@Configurable
final class LevelViewController: UIViewController {
    static let segmentItems = ["상", "중", "하"]
    
    private let segmentedControl = UISegmentedControl(items: LevelViewController.segmentItems)
    
    weak var delegate: (any LevelViewControllerDelegate)?
    
    init(level: String?) {
        let index = LevelViewController.segmentItems.firstIndex(of: level ?? "") ?? 0
        print(index)
        segmentedControl.selectedSegmentIndex = index
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @objc
    private func okButtonTapped() {
        print(#function)
        let index = segmentedControl.selectedSegmentIndex
        let level = segmentedControl.titleForSegment(at: index)
        delegate?.okLevelButtonTapped(level)
        pop()
    }
    
    private func configureView() {
        navigationItem.title = "레벨"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(okButtonTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.backward"),
            style: .plain,
            target: self,
            action: #selector(okButtonTapped)
        )
        view.backgroundColor = .white
        view.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.centerX.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
    }
}
