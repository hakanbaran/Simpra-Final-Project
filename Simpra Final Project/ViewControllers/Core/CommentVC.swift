//
//  CommentVC.swift
//  Simpra Final Project
//
//  Created by Hakan Baran on 25.01.2023.
//

import UIKit

class CommentVC: UIViewController {
    
    var gameCommentList : [GameComments]?
    
    let commentTableView : UITableView = {
       
        let table = UITableView()
        table.register(CommentCell.self, forCellReuseIdentifier: CommentCell.identifier)

        return table
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(commentTableView)
        commentTableView.frame = view.bounds
        
        commentTableView.delegate = self
        commentTableView.dataSource = self
        
        view.backgroundColor = .systemBackground
        title = "Comment Games"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .done, target: self, action: #selector(addCommentGame))
        navigationController?.navigationBar.tintColor = .lightGray

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getCommentData()
    }
    
    @objc func addCommentGame() {
        self.navigationController?.pushViewController(EditCommentVC(), animated: true)
    }
    
    @objc func getCommentData() {
        
        DataPersistenceManager.shared.fetchingGamesCommentsFromDataBase { result in
            switch result {
            case .success(let gameCommits):
                self.gameCommentList = gameCommits
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        NotificationCenter.default.addObserver(self, selector: #selector(getCommentData), name: NSNotification.Name("newData"), object: nil)
        self.commentTableView.reloadData()
    }
    

    

}

extension CommentVC : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameCommentList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.identifier, for: indexPath) as! CommentCell
        
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.2
        
        cell.nameLabel.text = gameCommentList?[indexPath.row].gameName
        cell.commentLabel.text = gameCommentList?[indexPath.row].gameComment
        
        return cell
    }
    
    
    
    
    
}
