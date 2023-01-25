//
//  ViewController.swift
//  Simpra Final Project
//
//  Created by Hakan Baran on 25.01.2023.
//

import UIKit
import SDWebImage

class HomeVC: UIViewController, UISearchControllerDelegate {
    
    let searchBar = UISearchBar()
    
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
        searchBar.sizeToFit()
        searchBar.delegate = self
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchItemClicked)),
            UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .lightGray
    }
    
    @objc func searchItemClicked() {
        search(shouldShow: true)
        searchBar.becomeFirstResponder()
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

extension HomeVC: UISearchBarDelegate {
    
    func showSearchBarButton(shouldShow: Bool ) {
        if shouldShow {
            var image = UIImage(named: "joystick")
            image = image?.withRenderingMode(.alwaysOriginal)
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: nil)

            navigationItem.rightBarButtonItems = [
                UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchItemClicked)),
                UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .done, target: self, action: nil)
            ]
        }else {
            navigationItem.rightBarButtonItems = nil
            navigationItem.leftBarButtonItem = nil
        }

    }
    
    func search(shouldShow: Bool) {
        showSearchBarButton(shouldShow: !shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : nil
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(shouldShow: false)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // GET SEARCH RESULT
        
        guard let query = searchBar.text else {return}
        APICaller.shared.search(with: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let game):
                    //print(game)
                    self.gameList = game
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
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
        
        
        APICaller.shared.getYoutubeMovie(with: gameTitle + "trailer") { result in
            switch result {

            case .success(let videoElement):
                
                DispatchQueue.main.async {
                    
                    let vc = GameDetailsVC()
                    vc.configure(with: GameDetailsViewModel(id: Int(gameResults?.id ?? 3498), gameName: gameTitle, youtubeView: videoElement, gamePoster: posterURL, gameDate: gameDate, gameRating: gameRating))
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset

        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))


    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == tableView.numberOfSections - 1 &&
                indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
                // Notify interested parties that end has been reached
            
            getNextGames { resultsGame in
                
                switch resultsGame {
                case .success(let games):
                    self.gameList?.append(contentsOf: games)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    public func getNextGames(completion: @escaping (Result <[Game], Error>)-> Void) {
        
        Constants.pageNumber += 1
        
        let APIURL = URL(string: "\(Constants.baseURL)/api/games?key=\(Constants.API_KEY)&page=\(Constants.pageNumber)")!

        let task = URLSession.shared.dataTask(with: URLRequest(url: APIURL)) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                    do {
                        let results = try JSONDecoder().decode(Response.self, from: data)
                        completion(.success(results.results!))
                    } catch {
                        completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
}




