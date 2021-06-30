//
//  File.swift
//  GitHubFollowers
//
//  Created by Садык Мусаев on 30.06.2021.
//

import UIKit

class GHButton:  UIButton{
    
    init(bgColor: UIColor, title: String) {
        super.init(frame: .zero)
        
        configurateButton(color: bgColor, title: title)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurateButton(color: UIColor, title: String){
        
        self.layer.cornerCurve = .continuous
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        self.backgroundColor = color
        self.setTitle(title, for: .normal)
    }
}

