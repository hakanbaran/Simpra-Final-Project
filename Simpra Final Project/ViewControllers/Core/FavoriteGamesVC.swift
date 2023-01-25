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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            
            
            DataPersistenceManager.shared.deleteGameWith(model: (gameList?[indexPath.row])!) { [weak self] result in
                switch result {
                case .success():
                    
                    self?.alertMessage(alertTitle: "Deletion Successful!", alertMessage: "Favorite game deleted from the list.")
                    
                    
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self?.gameList?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadData()
            }
        default:
            break;
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gameResults = gameList?[indexPath.row]
        
        guard let gameTitle = gameResults?.name else {return}
        guard let gameDate = gameResults?.released else {return}
        guard let posterURL = gameResults?.background_image else {return}
        
        guard let gameRating = gameResults?.rating else {return}
        
        //let gameID = Int(gameResults?.id ?? 3498)
        
         APICaller.shared.getYoutubeMovie(with: gameTitle + "trailer") { result in
             switch result {

             case .success(let videoElement):
                 
                 DispatchQueue.main.async {
                     
                     let vc = GameDetailsVC()
//                     vc.configure(with: GameDetailsViewModel(id: Int(gameResults?.id ?? 3498),gameName: gameTitle,  youtubeView: videoElement, gamePoster: posterURL, gameDate: gameDate))
                     
                     vc.configure(with: GameDetailsViewModel(id: Int(gameResults?.id ?? 3498), gameName: gameTitle, youtubeView: videoElement, gamePoster: posterURL, gameDate: gameDate, gameRating: gameRating))
                     
                     self.navigationController?.pushViewController(vc, animated: true)
                 }
             case .failure(let error):
                 print(error.localizedDescription)
             }
         }
    }
    
    func alertMessage( alertTitle: String, alertMessage: String) {
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
        
    }
    
    
    
    
}
