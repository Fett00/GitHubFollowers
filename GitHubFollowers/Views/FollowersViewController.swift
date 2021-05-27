//
//  Main2ViewController.swift
//  GitHubFollowers
//
//  Created by Садык Мусаев on 27.05.2021.
//

import UIKit

//Тут отображется список фоловеров
class FollowersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Настройка вью
        configurateViewController()
    }
    
    func configurateViewController(){
        view.backgroundColor = .systemBackground //Установка цвета задника
        
        self.hideKeyboardWhenTappedAround() // Прятать клавиатуру при нажатии на экран
    }
}
