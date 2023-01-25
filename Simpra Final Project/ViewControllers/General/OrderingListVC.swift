//
//  OrderingListVC.swift
//  Simpra Final Project
//
//  Created by Hakan Baran on 25.01.2023.
//

import UIKit

//public typealias StringHandler = ((String) -> Void)
class OrderingListVC: UIViewController {
    
    
    
    var doneBlock : StringHandler?
    
    public let nameOrdering : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .yellow
        
        button.setTitle("Name Ordering", for: .normal)
        button.tag = GameOrdering.name.rawValue
        button.addTarget(self, action: #selector(labelClicked), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
    public let releasedOrdering : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .yellow
        
        button.setTitle("Released Ordering", for: .normal)
        button.tag = GameOrdering.released.rawValue
        button.addTarget(self, action: #selector(labelClicked), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
    public let metacriticOrdering : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .yellow
        
        button.setTitle("Metacritic Ordering", for: .normal)
        button.tag = GameOrdering.metacritic.rawValue
        button.addTarget(self, action: #selector(labelClicked), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stackView = UIStackView(arrangedSubviews: [nameOrdering, releasedOrdering, metacriticOrdering])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isUserInteractionEnabled = true
        stackView.spacing = 8
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        ])
    }
    
    
    @objc func labelClicked(_ sender: Any) {
        
        guard let sender = sender as? UIButton else {return}
        dismiss(animated: true) {
            self.doneBlock?(GameOrdering.init(rawValue: sender.tag)?.stringValue ?? GameOrdering.name.stringValue)
        }

    }
}
