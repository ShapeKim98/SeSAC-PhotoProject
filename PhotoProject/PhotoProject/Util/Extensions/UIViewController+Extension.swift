//
//  UIViewController+Extension.swift
//  PhotoProject
//
//  Created by 김도형 on 1/20/25.
//

import UIKit

extension UIViewController {
    func presentAlert(title: String?, message: String? = nil) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let confirm = UIAlertAction(title: "확인", style: .default)
        alert.addAction(confirm)
        present(alert, animated: true)
    }
}
