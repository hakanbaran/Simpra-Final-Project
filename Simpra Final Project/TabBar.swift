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
        
        
        
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        
        
        
        homeVC.title = "Home"
        
        
        
        setViewControllers([homeVC], animated: true)
        tabBar.backgroundColor = .systemBackground
        
        

        
    }
    

    
}
