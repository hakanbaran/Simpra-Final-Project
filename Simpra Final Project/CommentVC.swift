//
//  CommentVC.swift
//  Simpra Final Project
//
//  Created by Hakan Baran on 25.01.2023.
//

import UIKit

class CommentVC: UIViewController {
    
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .done, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .lightGray

        
    }
    

    

}

extension CommentVC : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.identifier, for: indexPath) as! CommentCell
        
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.2
        
        return cell
    }
    
    
    
    
    
}
