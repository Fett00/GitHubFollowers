//
//  FollowersCollectionViewCell.swift
//  GitHubFollowers
//
//  Created by Садык Мусаев on 02.06.2021.
//

import UIKit

class FollowersCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "FCCell"
    
    let avatarImageView = UIImageView()
    let nameLable = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Настройка ячейки
        configurateCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(avatarImage:UIImage?,name:String){
        
        avatarImageView.image = avatarImage ?? UIImage(named: "rocket")
        nameLable.text = name
    }
    
    
    func configurateCell(){
        addSubview(avatarImageView)
        addSubview(nameLable)
        
        nameLable.textAlignment = .center
        
        NSLayoutConstraint.activate([
            
            avatarImageView.topAnchor.constraint(equalTo: self.topAnchor,constant: 5),
            //avatarImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -5),
            avatarImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -5),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 5),
            
            nameLable.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor,constant: 5),
            nameLable.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -5),
            nameLable.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -5),
            nameLable.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 5)
        ])
        
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        //avatarImageView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLable.translatesAutoresizingMaskIntoConstraints = false
    }
}
