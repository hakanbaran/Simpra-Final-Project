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
        let commentVC = UINavigationController(rootViewController: CommentVC())
        
        
        
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        favoriteGamesVC.tabBarItem.image = UIImage(systemName: "star.fill")
        commentVC.tabBarItem.image = UIImage(systemName: "pencil.circle")
        
        
        
        homeVC.title = "Home"
        favoriteGamesVC.title = "Favorite Games"
        commentVC.title = "Game Comments"
        
        
        
        setViewControllers([homeVC, favoriteGamesVC, commentVC], animated: true)
        tabBar.backgroundColor = .systemBackground
        
        

        
    }
    

    
}
