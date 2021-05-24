//
//  FollowersViewController.swift
//  GitHubFollowers
//
//  Created by Садык Мусаев on 24.05.2021.
//

import UIKit

class FollowersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func configurateViewController(){
        view.backgroundColor = .systemBackground //Установка цвета задника
        
        self.hideKeyboardWhenTappedAround() // Прятать клавиатуру при нажатии на экран
        
    }

}
