//
//  ViewController.swift
//  Simpra Final Project
//
//  Created by Hakan Baran on 25.01.2023.
//

import UIKit
import SDWebImage

class HomeVC: UIViewController {
    
    var gameList: [Game]?
    
    
    public let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        configureNavBar()
        
        getGamesData()
        
        

        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
    func configureNavBar() {
        
        title = "Home Page"
        var image = UIImage(named: "joystick")
        image = image?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .search, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .lightGray
    }
    
    
    private func getGamesData() {
        
        APICaller.shared.getGames { results in
            switch results {
            case .success(let games):
                self.gameList = games
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell

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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let gameResults = gameList?[indexPath.row]
        
        guard let gameTitle = gameResults?.name else {return}
        guard let gameDate = gameResults?.released else {return}
        guard let posterURL = gameResults?.background_image else {return}
        
        guard let gameRating = gameResults?.rating else {return}
        
        let vc = GameDetailsVC()
        vc.configure(with: GameDetailsViewModel(id: Int(gameResults?.id ?? 3498), gameName: gameTitle, gamePoster: posterURL, gameDate: gameDate, gameRating: gameRating))
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
    
    
}


