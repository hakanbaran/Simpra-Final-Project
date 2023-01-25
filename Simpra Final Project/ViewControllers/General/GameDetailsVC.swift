//
//  GameDetailsVC.swift
//  Simpra Final Project
//
//  Created by Hakan Baran on 25.01.2023.
//

import UIKit
import WebKit
import SnapKit

class GameDetailsVC: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    private let titleLabel : UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "The Witcher 3: Wild Hunt"
        label.numberOfLines = 0
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private let gameDateLabel: UILabel = {
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .lightGray
        label.text = "This is the best game ever to watch as a kid"
        return label
    }()
    
    public let gamePosterDetailsView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.image = UIImage(named: "testPoster")
        return imageView
    }()
    
    private let webView: WKWebView = {
        
       let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.layer.cornerRadius = 10
        webView.layer.borderWidth = 0.5
        webView.layer.borderColor = UIColor.white.cgColor
        return webView
    }()
    
    private let descriptionLabel : UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let userScoreLabel : UILabel = {
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private let userScoreCirle  = {
        
        let roundView = UIView(frame: CGRectMake(310, 380, 60, 60))
        roundView.backgroundColor    = UIColor.systemBackground
        roundView.layer.cornerRadius = roundView.frame.width / 2
        return roundView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .white
        scrollView.frame = view.bounds
        
        let views = [titleLabel, gameDateLabel, gamePosterDetailsView, webView, descriptionLabel, userScoreCirle]
        views.forEach { contentView.addSubview($0) }
        
        userScoreCirle.addSubview(userScoreLabel)
        
        configureConstraints()
        setupScrollView()
    }
    
    func setupScrollView(){
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            contentView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(scrollView)
            scrollView.addSubview(contentView)
            
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        }
    
    func configureConstraints() {
        
        let webViewConstraints = [
            webView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            webView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        let gamePosterConstraints = [
            gamePosterDetailsView.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 10),
            gamePosterDetailsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            gamePosterDetailsView.heightAnchor.constraint(equalToConstant: 140),
            gamePosterDetailsView.widthAnchor.constraint(equalToConstant: 98)
        ]
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor,constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: gamePosterDetailsView.trailingAnchor,constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ]
        
        let overViewLabelConsTraints = [
            gameDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            gameDateLabel.leadingAnchor.constraint(equalTo: gamePosterDetailsView.trailingAnchor,constant: 15),
        ]
        
        let descriptionLabelConstraints = [
            descriptionLabel.topAnchor.constraint(equalTo: gamePosterDetailsView.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10)
        ]
        
        userScoreLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        NSLayoutConstraint.activate(webViewConstraints)
        NSLayoutConstraint.activate(gamePosterConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(overViewLabelConsTraints)
        NSLayoutConstraint.activate(descriptionLabelConstraints)
    }
    
    func configure(with model: GameDetailsViewModel) {
        
        view.backgroundColor = .systemBackground
        title = model.gameName
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.backButtonTitle = "Back"
        
        titleLabel.text = model.gameName
        let date = model.gameDate
        let index = date.firstIndex(of: "-") ?? date.endIndex
        let year = date[..<index]
        gameDateLabel.text = "Released Date:   \(year)"
        
        let gamePosterURL = URL(string: model.gamePoster)
        gamePosterDetailsView.sd_setImage(with: gamePosterURL)
        
        let youtubeVideoID = model.youtubeView.id.videoId
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(youtubeVideoID)") else {return}
        webView.load(URLRequest(url: youtubeURL))
        
        let gameID = model.id.description
        APICaller.shared.getGameDescription(with: gameID) { result in
            switch result {
            case .success(let gameResponse):
                DispatchQueue.main.async {
                    self.descriptionLabel.attributedText =  gameResponse.description?.htmlAsAttributed
                    self.descriptionLabel.font = .systemFont(ofSize: 18, weight: .regular)
                    self.descriptionLabel.textColor = .lightGray
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        configureScoreLabel(with: model)
    }
    
    private func configureScoreLabel(with model: GameDetailsViewModel) {
        let score           = Int(model.gameRating * 20)
        let percentageScore = model.gameRating / 5
        userScoreLabel.text = "\(score)﹪"
        configureCircleStroke(with: percentageScore)
    }
    
    private func configureCircleStroke(with score: Double) {
        let circlePath = UIBezierPath(arcCenter: CGPoint (x: userScoreCirle.frame.width / 2, y: userScoreCirle.frame.width / 2),
                                      radius: userScoreCirle.frame.width / 2,
                                      startAngle: CGFloat(-0.5 * Double.pi),
                                      endAngle: CGFloat(1.5 * Double.pi),
                                      clockwise: true)
        let circleShape         = CAShapeLayer()
        circleShape.path        = circlePath.cgPath
        circleShape.strokeColor = UIColor.yellow.cgColor
        circleShape.fillColor   = UIColor.white.withAlphaComponent(0.00001).cgColor
        circleShape.lineWidth   = 5
        circleShape.strokeStart = 0.0
        circleShape.strokeEnd   = score
        userScoreCirle.layer.addSublayer(circleShape)
    }
}
