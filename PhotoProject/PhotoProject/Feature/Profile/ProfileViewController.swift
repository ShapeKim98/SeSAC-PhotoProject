//
//  ProfileViewController.swift
//  SeSACDay22Assignment
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {

    private let nicknameButton = UIButton()
    private let birthdayButton = UIButton()
    private let levelButton = UIButton()
    private let saveButton = UIButton()
    
    private let nicknameLabel = UILabel()
    private let birthdayLabel = UILabel()
    private let levelLabel = UILabel()
    
    @UserDefaults(
        forKey: .userDefaults(.nickname),
        defaultValue: "NO NAME"
    )
    private var nickname: String?
    @UserDefaults(
        forKey: .userDefaults(.birthday),
        defaultValue: "NO DATE"
    )
    private var birthday: String?
    @UserDefaults(
        forKey: .userDefaults(.level),
        defaultValue: "NO LEVEL"
    )
    private var level: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
        subscribed(
            observer: self,
            selector: #selector(sinkBirthDayPublisher),
            name: "BirthdayViewController"
        )
    }

    @objc
    private func okButtonTapped() {
        print(#function)
    }
    
    private func configureView() {
        navigationItem.title = "프로필 화면"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "탈퇴하기", style: .plain, target: self, action: #selector(okButtonTapped))
        view.backgroundColor = .white
        
        view.addSubview(nicknameButton)
        view.addSubview(birthdayButton)
        view.addSubview(levelButton)
        view.addSubview(saveButton)
        
        view.addSubview(nicknameLabel)
        view.addSubview(birthdayLabel)
        view.addSubview(levelLabel)
        
        nicknameButton.snp.makeConstraints { make in
            make.leading.top.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        birthdayButton.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.top.equalTo(nicknameButton.snp.bottom).offset(24)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }

        levelButton.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.top.equalTo(birthdayButton.snp.bottom).offset(24)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(50)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.leading.equalTo(nicknameButton.snp.trailing).offset(24)
            make.height.equalTo(50)
        }
        
        birthdayLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(24)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.leading.equalTo(birthdayButton.snp.trailing).offset(24)
            make.height.equalTo(50)
        }

        levelLabel.snp.makeConstraints { make in
            make.top.equalTo(birthdayLabel.snp.bottom).offset(24)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.leading.equalTo(levelButton.snp.trailing).offset(24)
            make.height.equalTo(50)
        }
        
        nicknameButton.setTitleColor(.black, for: .normal)
        birthdayButton.setTitleColor(.black, for: .normal)
        levelButton.setTitleColor(.black, for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        
        nicknameButton.setTitle("닉네임", for: .normal)
        birthdayButton.setTitle("생일", for: .normal)
        levelButton.setTitle("레벨", for: .normal)
        saveButton.setTitle("시작하기", for: .normal)
        
        saveButton.layer.cornerRadius = 25
        
        nicknameButton.addTarget(
            self,
            action: #selector(nicknameButtonTouchUpInside),
            for: .touchUpInside
        )
        birthdayButton.addTarget(
            self,
            action: #selector(birthdayButtonTouchUpInside),
            for: .touchUpInside
        )
        levelButton.addTarget(
            self,
            action: #selector(levelButtonTouchUpInside),
            for: .touchUpInside
        )
        saveButton.addTarget(
            self,
            action: #selector(saveButtonTouchUpInside),
            for: .touchUpInside
        )

        nicknameLabel.text = nickname
        nicknameLabel.textColor = .lightGray
        nicknameLabel.textAlignment = .right
        
        birthdayLabel.text = birthday
        birthdayLabel.textColor = .lightGray
        birthdayLabel.textAlignment = .right
        
        levelLabel.text = level
        levelLabel.textColor = .lightGray
        levelLabel.textAlignment = .right
        
        setSaveButtonState()
    }
}

// MARK: Functions
private extension ProfileViewController {
    @objc
    func nicknameButtonTouchUpInside() {
        let nickname = nicknameLabel.text
        let viewController = NicknameViewController(
            nickname: nickname == "NO NAME" ? nil : nickname,
            delegateAction: scopeNicknameViewController
        )
        push(viewController)
    }
    
    @objc
    func birthdayButtonTouchUpInside() {
        let birthday = birthdayLabel.text
        push(BirthdayViewController(birthday: birthday))
    }
    
    @objc
    func levelButtonTouchUpInside() {
        let level = levelLabel.text
        let viewController = LevelViewController(level: level)
        viewController.delegate = self
        push(viewController)
    }
    
    @objc
    func sinkBirthDayPublisher(_ notification: Notification) {
        let value = notification.userInfo?["birthday"] as? String
        birthdayLabel.text = value
        setSaveButtonState()
    }
    
    @objc
    func saveButtonTouchUpInside() {
        nickname = nicknameLabel.text
        birthday = birthdayLabel.text
        level = levelLabel.text
        
        presentAlert(title: "저장되었습니다.")
    }
    
    func scopeNicknameViewController(
        _ action: NicknameViewController.Delegate
    ) {
        switch action {
        case .okButtonTapped(let nickname):
            let isEmpty = nickname?.isEmpty ?? true
            nicknameLabel.text = isEmpty ? "NO NAME" : nickname
            setSaveButtonState()
        }
    }
    
    func setSaveButtonState() {
        let isNoName = nicknameLabel.text?.isEmpty ?? true
        || nicknameLabel.text == "NO NAME"
        let isNoDate = birthdayLabel.text?.isEmpty ?? true
        || birthdayLabel.text == "NO DATE"
        let isNoLevel = levelLabel.text?.isEmpty ?? true
        || levelLabel.text == "NO LEVEL"
        let isDisable = isNoName || isNoDate || isNoLevel
        saveButton.backgroundColor = isDisable ? .secondaryLabel : .systemBlue
        saveButton.isEnabled = !isDisable
    }
}

extension ProfileViewController: LevelViewControllerDelegate {
    func okLevelButtonTapped(_ level: String?) {
        levelLabel.text = level
        setSaveButtonState()
    }
}
