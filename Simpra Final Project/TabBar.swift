//
//  TabBar.swift
//  Simpra Final Project
//
//  Created by Hakan Baran on 25.01.2023.
//

import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = UINavigationController(rootViewController: HomeVC())
        let favoriteGamesVC = UINavigationController(rootViewController: FavoriteGamesVC())
        
        
        
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        favoriteGamesVC.tabBarItem.image = UIImage(systemName: "star.fill")
        
        
        
        homeVC.title = "Home"
        favoriteGamesVC.title = "Favorite Games"
        
        
        
        setViewControllers([homeVC, favoriteGamesVC], animated: true)
        tabBar.backgroundColor = .systemBackground
        
        

        
    }
    

    
}
