//
//  FavoritesTableViewCell.swift
//  GitHubFollowers
//
//  Created by Садык Мусаев on 02.06.2021.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    static let cellID = "FavCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configurateCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurateCell(){
        self.textLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
        self.accessoryType = .disclosureIndicator
    }
    
    func set(user:Users){ //УСтановка значений
        
        self.textLabel?.text = user.name
        self.imageView?.image = UIImage(data: user.image!)
    }

}
