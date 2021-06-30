//
//  CustomTextField.swift
//  GitHubFollowers
//
//  Created by Садык Мусаев on 30.06.2021.
//

import UIKit

class GHTextField: UITextField{
    
    init(){
        
        super.init(frame: .zero)
        configurateTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurateTextField(){
        
        self.placeholder = "Username"
        
        self.layer.borderWidth = 0.6
        self.layer.borderColor = UIColor.systemGray2.cgColor
        self.layer.cornerCurve = CALayerCornerCurve.continuous
        self.layer.cornerRadius = 10
        
        self.textColor = .label
        self.tintColor = .label
        self.backgroundColor = .secondarySystemBackground

        self.textAlignment = .center
        self.font = UIFont.preferredFont(forTextStyle: .title2)
        
        self.adjustsFontSizeToFitWidth = true
        self.minimumFontSize = 12
        
        self.autocorrectionType = .no
        self.returnKeyType = .go
        self.clearButtonMode = .whileEditing
    }
}
