//
//  EditCommentVC.swift
//  Simpra Final Project
//
//  Created by Hakan Baran on 25.01.2023.
//

import UIKit
import CoreData

class EditCommentVC: UIViewController, UITextViewDelegate {
    
    private let titleLabel : UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Enter Your Comment"
        label.numberOfLines = 0
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    
    private let nameText : UITextField = {
        
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.placeholder = "  Enter Game Name"
        text.backgroundColor = .lightGray
        text.font = .systemFont(ofSize: 24)
        text.textColor = .black
        text.layer.cornerRadius = 8
        text.layer.masksToBounds = true
        return text
    }()
    
    private let saveButton : UIButton = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.tintColor = .white
        button.setTitle("SAVE", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(saveButtonClicked) , for: .touchUpInside)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    var CommantTextView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CommantTextView = UITextView(frame: CGRect(x: 20.0, y: 200.0, width: view.frame.width - 40, height: 140.0))
        configureCommentTextView()
        
        view.addSubview(CommantTextView)
        view.backgroundColor = .systemBackground
        view.addSubview(nameText)
        view.addSubview(titleLabel)
        view.addSubview(saveButton)
        configureConstraints()
    }
    
    func configureCommentTextView() {
        CommantTextView.contentInsetAdjustmentBehavior = .automatic
        CommantTextView.textAlignment = NSTextAlignment.justified
        CommantTextView.font = .systemFont(ofSize: 20, weight: .regular)
        CommantTextView.textColor = UIColor.placeholderText
        CommantTextView.backgroundColor = UIColor.lightGray
        CommantTextView.layer.cornerRadius = 8
        CommantTextView.layer.masksToBounds = true
        CommantTextView.delegate = self
        CommantTextView.text = "Enter Comment..."
    }
    
    @objc func saveButtonClicked() {
        
        if nameText.text == "" {
            self.alertMessage(alertTitle: "Error...", alertMessage: "Please Enter Game Name")
        }
        
        if CommantTextView.text == "" || CommantTextView.text == "Enter Comment..." {
            self.alertMessage(alertTitle: "Error", alertMessage: "Enter Comment")
        }
        
        DataPersistenceManager.shared.addGameComment(model: GameComment(gameName: nameText.text, gameComment: CommantTextView.text)) { result in
            switch result {
            case .success():
                NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
                self.navigationController?.popViewController(animated: true)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func configureConstraints() {
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ]
        let nameTextConstraints = [
            nameText.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            nameText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameText.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20)
        ]
        let saveButtonConstraints = [
            saveButton.topAnchor.constraint(equalTo: CommantTextView.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 140),
            saveButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(nameTextConstraints)
        NSLayoutConstraint.activate(saveButtonConstraints)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if CommantTextView.text == "Enter Comment..."  {
            CommantTextView.text = ""
            CommantTextView.textColor = .black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if CommantTextView.text == "" {
            CommantTextView.text = "Enter Comment..."
            CommantTextView.textColor = .placeholderText
        }
    }
    
    func alertMessage( alertTitle: String, alertMessage: String) {
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}
