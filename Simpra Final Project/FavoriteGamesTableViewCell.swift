//
//  FavoriteGamesTableViewCell.swift
//  Simpra Final Project
//
//  Created by Hakan Baran on 25.01.2023.
//

import UIKit

class FavoriteGamesTableViewCell: UITableViewCell {
    
    static let identifier = "FavoritesCell"
    
    
    public let deleteFavoriteButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .yellow
        let image = UIImage(systemName: "star.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24))
        button.setImage(image, for: .normal)
        
        return button
    }()
    
    public let gamePosterView: UIImageView = {
       
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.layer.borderWidth = 0.8
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.image = UIImage(named: "testPoster")
        return imageView
    }()
    
    public let nameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hakan Baran"
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    public let dateLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "01.10.2023"
        label.font = .systemFont(ofSize: 18, weight: .light)
        
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(gamePosterView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(deleteFavoriteButton)

        configureConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func deleteFavoriteClicked() {
        
        
        
    }
    
    func configureConstraints() {
        
        let gamePosterConstraints = [
            gamePosterView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            gamePosterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            gamePosterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            gamePosterView.widthAnchor.constraint(equalToConstant: 98)
        ]
        
        let nameLabelConstraints = [
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 30),
            nameLabel.leadingAnchor.constraint(equalTo: gamePosterView.trailingAnchor,constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30)
        ]
        
        let dateLabelConstraints = [
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 15),
            dateLabel.leadingAnchor.constraint(equalTo: gamePosterView.trailingAnchor,constant: 15),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100)
        ]
        
        let addFavoriteButtonConstraints = [
            deleteFavoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            deleteFavoriteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        

        
        NSLayoutConstraint.activate(nameLabelConstraints)
        NSLayoutConstraint.activate(gamePosterConstraints)
        NSLayoutConstraint.activate(dateLabelConstraints)
        NSLayoutConstraint.activate(addFavoriteButtonConstraints)

    }

}
