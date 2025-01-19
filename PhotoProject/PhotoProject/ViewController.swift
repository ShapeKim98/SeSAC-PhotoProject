//
//  ViewController.swift
//  PhotoProject
//
//  Created by 김도형 on 1/18/25.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBarController()
        
        configureTabBarAppearance()
    }

}

private extension ViewController {
    func configureTabBarController() {
        let topicViewController = UINavigationController(rootViewController: TopicViewController())
        topicViewController.tabBarItem.title = "토픽"
        topicViewController.tabBarItem.image = UIImage(systemName: "magazine")
        topicViewController.tabBarItem.selectedImage = UIImage(systemName: "magazine.fill")
        
        let searchViewController = UINavigationController(rootViewController: SearchViewController())
        searchViewController.tabBarItem.title = "검색"
        searchViewController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        searchViewController.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass.fill")
        
        setViewControllers(
            [topicViewController, searchViewController],
            animated: true
        )
    }
    
    func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = .black
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}
