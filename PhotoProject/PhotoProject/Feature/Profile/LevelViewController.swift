//
//  LevelViewController.swift
//  SeSACDay22Assignment
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit

protocol LevelViewControllerDelegate: AnyObject {
    func okLevelButtonTapped(_ level: String?)
}

class LevelViewController: UIViewController {

    let segmentedControl = UISegmentedControl(items: ["상", "중", "하"])
    
    weak var delegate: (any LevelViewControllerDelegate)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    @objc func okButtonTapped() {
        print(#function)
        let index = segmentedControl.selectedSegmentIndex
        let level = segmentedControl.titleForSegment(at: index)
        delegate?.okLevelButtonTapped(level)
        pop()
    }
    
    func configureView() {
        navigationItem.title = "레벨"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(okButtonTapped))
        view.backgroundColor = .white
        view.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.centerX.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        segmentedControl.selectedSegmentIndex = 0
    }
}
