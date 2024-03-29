//
//  FavoritesViewController.swift
//  GitHubFollowers
//
//  Created by Садык Мусаев on 24.05.2021.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    let favoritesUsersTableView = UITableView()
    
    var users = [Users]()

    override func viewDidLoad() {
        super.viewDidLoad()

        //Настройка вью
        configurateViewController()
        //Настройка Таблицы
        configurateFUTableView()
        //Получение пользователей
        getUsers()
    }
    
    
    func getUsers(){
        
        let dBGetter = UsersCDHelper.shared
        
        users = dBGetter.get(withName: nil)
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
        
        favoritesUsersTableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: FavoritesTableViewCell.cellID)//регистрация ячейки
        favoritesUsersTableView.delegate = self //назначение делегата
        favoritesUsersTableView.dataSource = self // назначение источника данных
        
        favoritesUsersTableView.tableFooterView = UIView() // Установка футера
//        favoritesUsersTableView.insetsContentViewsToSafeArea = true //Что дает?
//        favoritesUsersTableView.cellLayoutMarginsFollowReadableWidth = true //Что дает?
        favoritesUsersTableView.separatorStyle = .none
        
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
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.cellID) as! FavoritesTableViewCell
        
        cell.set(user: users[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.navigationController?.pushViewController(FollowersViewController(withName: users[indexPath.row].name!), animated: true)
    }
    
    func configurateDeleteAction(){
        
        //let deleteAction = UITableView
    }
}
