//
//  BirthdayViewController.swift
//  SeSACDay22Assignment
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit
import BaseKit

@Configurable
class BirthdayViewController: UIViewController {

    let datePicker = UIDatePicker()
    
    init(birthday: String?) {
        let date = birthday?.date(format: .yyyy년_M월_d일)
        datePicker.date = date ?? .now
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @objc func okButtonTapped() {
        print(#function)
        let value = datePicker.date.string(format: .yyyy년_M월_d일)
        published(
            name: "BirthdayViewController",
            userInfo: ["birthday": value]
        )
        pop()
    }
    
    func configureView() {
        navigationItem.title = "생일"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(okButtonTapped))
        view.backgroundColor = .white
        view.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.centerX.top.equalTo(view.safeAreaLayoutGuide)
        }
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
    }
}
