//
//  CustomUIView.swift
//  GitHubFollowers
//
//  Created by Садык Мусаев on 30.06.2021.
//

import UIKit

class GHView: UIView{
    
    init(bgColor: UIColor){
        super.init(frame: .zero)
        
        configurateView(color: bgColor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurateView(color: UIColor){
        
        self.layer.cornerCurve = .continuous
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        self.backgroundColor = color
    }
    
    
}
