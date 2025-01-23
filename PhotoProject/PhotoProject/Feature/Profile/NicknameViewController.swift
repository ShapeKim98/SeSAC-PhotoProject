//
//  NicknameViewController.swift
//  SeSACDay22Assignment
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit
import BaseKit

@Configurable
final class NicknameViewController: UIViewController {
    enum Delegate {
        case okButtonTapped(nickname: String?)
    }
    
    private let textField = UITextField()
    private var delegateAction: ((Delegate) -> Void)?
    
    init(
        nickname: String?,
        delegateAction: ((Delegate) -> Void)?
    ) {
        self.delegateAction = delegateAction
        self.textField.text = nickname
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @objc
    private func okButtonTapped() {
        delegateAction?(.okButtonTapped(nickname: textField.text))
        pop()
    }
    
    private func configureView() {
        navigationItem.title = "닉네임"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(okButtonTapped))
        view.backgroundColor = .white
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.centerX.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        textField.placeholder = "닉네임을 입력해주세요"
    }
}
