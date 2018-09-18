//
//  MainTabBarController.swift
//  PodcastClone
//
//  Created by Jacobo Hernandez on 9/17/18.
//  Copyright © 2018 Jacobo Hernandez. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().prefersLargeTitles = true
        
        tabBar.tintColor = .green
        
        setupViewControllers()
    }
    
    //MARK:- Setup Functions
    
    func setupViewControllers() {
        viewControllers = [
            generateNavigationController(with: PodcastsSearchController(), title: "Search", image: #imageLiteral(resourceName: "search")),
            generateNavigationController(with: ViewController(), title: "Favorites", image: #imageLiteral(resourceName: "favorites")),
            generateNavigationController(with: ViewController(), title: "Downloads", image: #imageLiteral(resourceName: "downloads"))
        ]
    }
    
    //MARK:- Helper Functions
    
    fileprivate func generateNavigationController(with rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        rootViewController.navigationItem.title = title
        // navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        
        return navController
    }
}
