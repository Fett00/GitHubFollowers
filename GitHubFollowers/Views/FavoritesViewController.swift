//
//  FavoritesViewController.swift
//  GitHubFollowers
//
//  Created by Садык Мусаев on 24.05.2021.
//

import UIKit

class FavoritesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func configurateViewController(){
        view.backgroundColor = .systemBackground //Установка цвета задника
        
        self.hideKeyboardWhenTappedAround() // Прятать клавиатуру при нажатии на экран
        
    }

}
