//
//  OnboardingViewController.swift
//  SeSACDay22Assignment
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit

final class OnboardingViewController: UIViewController {

    private let button = UIButton()
    
    @UserDefaults(
        forKey: .userDefaults(.authenticated)
    )
    private var authenticated: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(50)
        }
        button.layer.cornerRadius = 25
        button.backgroundColor = .white
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitle("시작하기", for: .normal)
        button.addTarget(
            self,
            action: #selector(buttonTouchUpInside),
            for: .touchUpInside
        )
    }
    
    @objc
    private func buttonTouchUpInside() {
        let viewController = ProfileViewController()
        authenticated = true
        switchRoot(UINavigationController(
            rootViewController: viewController
        ))
    }
}
