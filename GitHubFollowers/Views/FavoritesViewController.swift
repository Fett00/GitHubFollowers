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

        //Настройка вью
        configurateViewController()
    }
    

    func configurateViewController(){
        view.backgroundColor = .systemBackground //Установка цвета задника
        self.title = "Favorites"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.hideKeyboardWhenTappedAround() // Прятать клавиатуру при нажатии на экран
    }
}
