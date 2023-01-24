//
//  CommentCell.swift
//  Simpra Final Project
//
//  Created by Hakan Baran on 25.01.2023.
//

import UIKit

class CommentCell: UITableViewCell {

    static let identifier = "CommentsCell"
    
    public let nameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hakan Baran"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    public let commentLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hhjelwjcwjecwecjkwcwleckwnclwnlcewnclwnlcnwefwelnflkwelwenflweknlcwnfnewfwlfnwlfnwlfw"
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.numberOfLines = 0
        
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
        contentView.addSubview(commentLabel)
        
        configureConstraints()
        

        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureConstraints() {
        
        let nameLabelConstraints = [
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ]
        
        let commentLabelConstraints = [
            commentLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            commentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            commentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            commentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10 )
        
        ]
        
        
        NSLayoutConstraint.activate(nameLabelConstraints)
        NSLayoutConstraint.activate(commentLabelConstraints)
        
        
    }

}
