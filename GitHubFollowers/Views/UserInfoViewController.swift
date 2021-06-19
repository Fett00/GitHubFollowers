//
//  UserInfoViewController.swift
//  GitHubFollowers
//
//  Created by Садык Мусаев on 24.05.2021.
//

import UIKit

// Отображение информации о юзере
class UserInfoViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Настройка вью
        configurateViewController()
        
    }
    
    func configurateViewController(){
        view.backgroundColor = .systemBackground //Установка цвета задника
        
        self.hideKeyboardWhenTappedAround() // Прятать клавиатуру при нажатии на экран
        
        
        navigationItem.leftBarButtonItem = .init(title: "Done", style: .done, target: self, action: #selector(doneButton))
        navigationItem.rightBarButtonItem = .init(image: SFSymbols.star, landscapeImagePhone: SFSymbols.star, style: .done, target: self, action: #selector(addToFavorite))
    }
    
    
    @objc func doneButton(){
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func addToFavorite(){
        //Добавление пользователя в избранное
        navigationItem.rightBarButtonItem = .init(image: SFSymbols.starFill, landscapeImagePhone: SFSymbols.starFill, style: .done, target: self, action: #selector(removeFromFavorite)) //Заполнение кнопки
    }
    
    @objc func removeFromFavorite(){
        navigationItem.rightBarButtonItem = .init(image: SFSymbols.star, landscapeImagePhone: SFSymbols.star, style: .done, target: self, action: #selector(addToFavorite))
    }
}
