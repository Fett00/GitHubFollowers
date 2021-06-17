//
//  Main2ViewController.swift
//  GitHubFollowers
//
//  Created by Садык Мусаев on 27.05.2021.
//

import UIKit

//Тут отображется список фоловеров
class FollowersViewController: UIViewController {
    
    var followersCollectionView:UICollectionView?
    
    init(withName name:String?) {
        super.init(nibName: nil, bundle: nil)
        self.title = name ?? "User"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Подгрузка данных
        NetworkHelper.shared.getUsers(withProfileName: "Fett00")//Здесь ли его место?
        //Настройка вью
        configurateViewController()
        //Настройка collectionView
        configurateCollectionView()
    }
    
    func configurateViewController(){
        
        view.backgroundColor = .systemBackground //Установка цвета задника
        self.navigationController?.navigationBar.prefersLargeTitles = true // Большой заголовок
        
        self.hideKeyboardWhenTappedAround() // Прятать клавиатуру при нажатии на экран
    }
    
    func configurateCollectionView() {
        
        
        
        
        
        //Настройка отображения CollectionView
        let width =  view.bounds.width // Ширина экрана
        let padding: CGFloat = 10
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        let nameHigth:CGFloat = 37
        
        let lo = UICollectionViewFlowLayout()
        lo.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        lo.itemSize = CGSize(width: itemWidth, height: itemWidth + nameHigth)
        //
        
        followersCollectionView = UICollectionView(frame: .zero, collectionViewLayout: lo)
        
        followersCollectionView?.dataSource = self
        followersCollectionView?.delegate = self
        followersCollectionView?.register(FollowersCollectionViewCell.self, forCellWithReuseIdentifier: FollowersCollectionViewCell.cellID)
        
        
        view.addSubview(followersCollectionView!)
        followersCollectionView?.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([

            followersCollectionView!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            followersCollectionView!.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            followersCollectionView!.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            followersCollectionView!.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
        followersCollectionView!.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension FollowersViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowersCollectionViewCell.cellID, for: indexPath) as! FollowersCollectionViewCell
        cell.set(avatarImage: nil, name: "Fett00")
        
        return cell
    }
}
