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
    var currentUser: UserModel?
    var currentUserName:String
    
    init(withName name:String) {
        
        currentUserName = name
        
        super.init(nibName: nil, bundle: nil)
        
        self.title = currentUserName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Подгрузка данных
        //Здесь ли его место?
        NetworkHelper.shared.getUser(withProfileName: currentUserName){[weak self] result in
            
            guard let strongSelf = self else{return}
            
            switch result{
            
            case .failure(let error):
                debugPrint(error)
                
            case .success(let model):
                print(model.followersModel)
                strongSelf.currentUser = model
                
                DispatchQueue.main.async {
                    strongSelf.followersCollectionView?.reloadData()
                }
                print(Double(MemoryLayout.size(ofValue: model))/1024, " kB")
            }
        }
        
        //Настройка вью
        configurateViewController()
        //Настройка collectionView
        configurateCollectionView()
    }
    
    func configurateViewController(){
        
        view.backgroundColor = .systemBackground //Установка цвета задника
        self.navigationController?.navigationBar.prefersLargeTitles = true // Большой заголовок
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: SFSymbols.person, style: .plain, target: self, action: #selector(getUserInfo))
        
        self.hideKeyboardWhenTappedAround() // Прятать клавиатуру при нажатии на экран
    }
    
    func configurateCollectionView() {
        
        
        //Настройка отображения CollectionView
        let width =  view.bounds.width // Ширина экрана
        let padding: CGFloat = 10
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        let nameHigth:CGFloat = 37 // font heigh + 20(space)
        
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
    
    
    @objc func getUserInfo(){
        
        present(UINavigationController(rootViewController: UserInfoViewController()), animated: true, completion: nil)
    }
}

extension FollowersViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        currentUser?.followersModel.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowersCollectionViewCell.cellID, for: indexPath) as! FollowersCollectionViewCell
        
        let defaultFollower = FollowerModel(login: "sdq", id: 123, avatarUrl: "13123", url: "1312")
        cell.set(follower:currentUser?.followersModel[indexPath.row] ?? defaultFollower)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        present(UINavigationController(rootViewController: UserInfoViewController()), animated: true, completion: nil)
    }
}
