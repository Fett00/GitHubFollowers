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
    
    func set(follower:FollowerModel){
        
        NetworkHelper.shared.getImage(fromUrlString: follower.avatarUrl) { [weak self] resultingImage in
            
            if let strongSelf = self{
                
                DispatchQueue.main.async {
                    strongSelf.avatarImageView.image = resultingImage ?? Images.placeHolder
                }
            }
        }

        nameLable.text = follower.login
    }
    
    
    func configurateCell(){
        addSubview(avatarImageView)
        addSubview(nameLable)
        
        //Настройка аватарки
        avatarImageView.layer.cornerRadius = 10 // Велечина закругления картинки
        avatarImageView.layer.cornerCurve = .continuous // Закругление в виде суперэлипса
        avatarImageView.contentMode = .scaleAspectFill // подогнать картинку под размеры imageView
        avatarImageView.clipsToBounds = true// Ограничивает внутреннию иерархию границами этого элемента
        //
        
        //Настройка имени
        nameLable.textAlignment = .center
        nameLable.font = UIFont.boldSystemFont(ofSize: nameLable.font.pointSize)
        //
        
        NSLayoutConstraint.activate([
            
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor),
            avatarImageView.topAnchor.constraint(equalTo: self.topAnchor,constant: 5),
            avatarImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -5),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 5),
            
            nameLable.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor,constant: 10),
            nameLable.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -5),
            nameLable.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 5),
            nameLable.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])

        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLable.translatesAutoresizingMaskIntoConstraints = false
    }
}
