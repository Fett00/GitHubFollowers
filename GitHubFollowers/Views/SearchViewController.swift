//
//  FollowersViewController.swift
//  GitHubFollowers
//
//  Created by Садык Мусаев on 23.05.2021.
//

import UIKit

//Класс для главного окна
class SearchViewController: UIViewController {
    
    //Избражение гитхаб лого
    let logoImageView = UIImageView()
    
    //Форма для ввода имени
    let userNameTextField = GHTextField()
    
    //Кнопка поиска
    let searchButton = GHButton(bgColor: Colors.blueButton, title: "Get Followers")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Настройка вью
        configurateViewController()
        //Настройка лого
        configurateLogo()
        //Настройка поля
        configurateTextField()
        //Настройка кнопки
        configurateButton()
    }
    
    //Настройка
    func configurateViewController(){
        view.backgroundColor = .systemBackground //Установка цвета задника
        
        self.hideKeyboardWhenTappedAround() // Прятать клавиатуру при нажатии на экран
    }
    
    func configurateLogo() {
        
        view.addSubview(logoImageView)//Добавление картинки на вью
        
        logoImageView.image = Images.ghLogo //Установка картинки
        logoImageView.contentMode = .scaleAspectFit //Установка границ изображения
        
        //Создание констрейнтов
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        //Отключение перевода AResMask
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configurateTextField() {

        view.addSubview(userNameTextField)//Добавление поля ввода на вью
        
        userNameTextField.delegate = self
        
        //Создание констрейнтов
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor,constant: 30),
            userNameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -50),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        //
        
        //Отключение перевода AResMask
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configurateButton() {
        view.addSubview(searchButton)//Добавление кнопки поиска на вью
        
        searchButton.addTarget(self, action: #selector(goToFollowers), for: .touchDown)
        
        //Создание констрейнтов
        NSLayoutConstraint.activate([
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -20),
            searchButton.heightAnchor.constraint(equalToConstant: 50),
            searchButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 50),
            searchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -50)
        ])
        //
        
        //Отключение перевода AResMask
        searchButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //Нажатие на кнопку
    @objc func goToFollowers(){
        
        if !userNameTextField.text!.isEmpty{ //Поверка на наличие имени
            
            self.navigationController?.pushViewController(FollowersViewController(withName: userNameTextField.text!), animated: true)
        }
        else{ //Уведомление если имя пустое
            
            let popUp = UIAlertController(title: nil, message: Titles.emptyName, preferredStyle: .alert)
            popUp.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(popUp, animated: true, completion: nil)
        }
    }
}

extension SearchViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if !userNameTextField.text!.isEmpty{ //Поверка на наличие имени
            
            self.navigationController?.pushViewController(FollowersViewController(withName: textField.text!), animated: true)
        }
        else{ //Уведомление если имя пустое
            
            let popUp = UIAlertController(title: nil, message: Titles.emptyName, preferredStyle: .alert)
            popUp.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(popUp, animated: true, completion: nil)
        }
        
        return true
    }
}
