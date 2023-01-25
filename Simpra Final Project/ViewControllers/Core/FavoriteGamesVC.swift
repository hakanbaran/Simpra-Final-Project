//
//  FavoriteGamesVC.swift
//  Simpra Final Project
//
//  Created by Hakan Baran on 25.01.2023.
//

import UIKit

class FavoriteGamesVC: UIViewController {
    
    var gameList: [GameItem]?
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchLocalStorageForFavorite()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func fetchLocalStorageForFavorite() {
        
        DataPersistenceManager.shared.fetchingGamesFromDataBase {  result in
            switch result {
            case .success(let games):
                self.gameList = games
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    

   

}


extension FavoriteGamesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteGamesTableViewCell.identifier, for: indexPath) as! FavoriteGamesTableViewCell
        
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.2
        cell.clipsToBounds = true
        
        let gameResults = gameList?[indexPath.row]
        
        cell.nameLabel.text = gameResults?.name
        
        let date = gameResults?.released
        let index = date?.firstIndex(of: "-") ?? date?.endIndex
        let year = date?[..<index!]
        cell.dateLabel.text = "Released Date:   \(year ?? "")"
        let posterURL = URL(string: gameResults?.background_image ?? "")
        cell.gamePosterView.sd_setImage(with: posterURL)
        
        return cell
        
    }
    
    
    
    
}
