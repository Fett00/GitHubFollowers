//
//  FavoritesViewController.swift
//  GitHubFollowers
//
//  Created by Садык Мусаев on 24.05.2021.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    let favoritesUsersTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        //Настройка вью
        configurateViewController()
        //Настройка Таблицы
        configurateFUTableView()
    }
    

    func configurateViewController(){
        view.backgroundColor = .systemBackground //Установка цвета задника
        self.title = "Favorites"
        self.navigationController?.navigationBar.prefersLargeTitles = true //Большое название
        
        self.hideKeyboardWhenTappedAround() // Прятать клавиатуру при нажатии на экран
    }
    
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func configurateFUTableView() {
        
        view.addSubview(favoritesUsersTableView)//добавление таблицы на вью
        
        favoritesUsersTableView.register(UITableViewCell.self, forCellReuseIdentifier: "FUCell")//регистрация ячейки
        favoritesUsersTableView.delegate = self //назначение делегата
        favoritesUsersTableView.dataSource = self // назначение источника данных
        
        favoritesUsersTableView.tableFooterView = UIView() // Установка футера
        
        //Настройка констрейнтов для таблицы
        NSLayoutConstraint.activate([
            favoritesUsersTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favoritesUsersTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            favoritesUsersTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            favoritesUsersTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        favoritesUsersTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FUCell")!
        cell.textLabel?.text = String(indexPath.row)
        
        return cell
    }
}
