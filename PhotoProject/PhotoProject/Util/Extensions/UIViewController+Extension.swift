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
    
    func switchRoot(_ viewController: UIViewController) {
        let scene = UIApplication.shared.connectedScenes.first
        guard
            let windowScene = scene as? UIWindowScene,
            let window = windowScene.windows.first
        else { return }
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    func push(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func pop() {
        navigationController?.popViewController(animated: true)
    }
    
    func subscribed(observer: Any, selector: Selector, name: String) {
        NotificationCenter.default.addObserver(
            observer,
            selector: selector,
            name: NSNotification.Name(name),
            object: nil
        )
    }
    
    func published(name: String, userInfo: [AnyHashable: Any]) {
        NotificationCenter.default.post(
            name: NSNotification.Name(name),
            object: nil,
            userInfo: userInfo
        )
    }
}
