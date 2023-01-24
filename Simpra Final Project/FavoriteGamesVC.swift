//
//  FavoriteGamesVC.swift
//  Simpra Final Project
//
//  Created by Hakan Baran on 25.01.2023.
//

import UIKit

class FavoriteGamesVC: UIViewController {
    
    public let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(FavoriteGamesTableViewCell.self, forCellReuseIdentifier: FavoriteGamesTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        
        view.backgroundColor = .systemBackground
        title = "Favorites Games"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    

   

}


extension FavoriteGamesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteGamesTableViewCell.identifier, for: indexPath) as! FavoriteGamesTableViewCell
        
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.2
        cell.clipsToBounds = true
        
        return cell
        
    }
    
    
    
    
}
