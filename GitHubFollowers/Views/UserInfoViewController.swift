//
//  UserInfoViewController.swift
//  GitHubFollowers
//
//  Created by Садык Мусаев on 24.05.2021.
//

import UIKit

// Отображение информации о юзере
class UserInfoViewController: UIViewController {
    
    let user:UserModel
    
    let firstBlock = UIView()
    let secondBlock = UIView()
    let thirdBlock = UIView()

    
    init(user:UserModel) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("User \(user.login) was deinited!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Настройка вью
        configurateViewController()
        //Настройка первого блока
        configurateFirstBlock()
        //Настройка второго блока
        configurateSecondBlock()
        //Настройка третьего блока
        configurateThirdBlock()
    }
    
    
    func configurateFirstBlock(){
        
        let firstBlockStack = UIStackView()
        let avatarImageView = UIImageView()
        let name = UILabel()
        let realName = UILabel()
        let geo = UIView()
        let bio = UILabel()
        

        //НАСТРОЙКА БЛОКА
        
        view.addSubview(firstBlock)
        firstBlock.setContentHuggingPriority(.defaultHigh, for: .vertical) //Сжатие вью по размерам его контента(мб временное)
        
        NSLayoutConstraint.activate([
        
            firstBlock.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            firstBlock.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 10),
            firstBlock.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            //firstBlock.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        firstBlock.translatesAutoresizingMaskIntoConstraints = false
        //
        
        //НАСТРОЙКА АВАТАРКИ
        avatarImageView.image = user.avatarImage ?? Images.placeHolder
        
        firstBlock.addSubview(avatarImageView)
        
        let width =  view.bounds.width // Ширина экрана
        let padding: CGFloat = 10
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        //Настройка аватарки
        avatarImageView.layer.cornerRadius = 10 // Велечина закругления картинки
        avatarImageView.layer.cornerCurve = .continuous // Закругление в виде суперэлипса
        avatarImageView.contentMode = .scaleAspectFill // подогнать картинку под размеры imageView
        avatarImageView.clipsToBounds = true// Ограничивает внутреннию иерархию границами этого элемента
        //
        
        NSLayoutConstraint.activate([
            
            avatarImageView.topAnchor.constraint(equalTo: avatarImageView.superview!.topAnchor, constant: 10),
            avatarImageView.leadingAnchor.constraint(equalTo: avatarImageView.superview!.leadingAnchor,constant: 10),
            avatarImageView.heightAnchor.constraint(equalToConstant: itemWidth),
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor)
        ])
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        //
        
        //НАСТРОЙКА СТЭКА
        
        firstBlock.addSubview(firstBlockStack)
        
        firstBlockStack.axis = .vertical
        firstBlockStack.alignment = .fill
        firstBlockStack.distribution = .fillEqually
        
        NSLayoutConstraint.activate([
            
            firstBlockStack.topAnchor.constraint(equalTo: firstBlockStack.superview!.topAnchor, constant: 10),
            firstBlockStack.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor,constant: 10),
            firstBlockStack.trailingAnchor.constraint(equalTo: firstBlockStack.superview!.trailingAnchor, constant: -10),
            firstBlockStack.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor)
        ])
        
        firstBlockStack.translatesAutoresizingMaskIntoConstraints = false
        //
        
        //НАСТРОЙКА ИМЕНИ
        name.text = user.login
        
        firstBlockStack.addArrangedSubview(name)
        
        name.numberOfLines = 1
        name.font = UIFont.preferredFont(forTextStyle: .title1)
        //
        
        //Настройка настоящего имени
        realName.text = user.name
        
        firstBlockStack.addArrangedSubview(realName)
        
        realName.numberOfLines = 1
        //
        
        //Настройка названия местоположения
        
        firstBlockStack.addArrangedSubview(geo)
        
        let geoSymbol = UIImageView()
        let geoName = UILabel()
        
        geo.addSubview(geoSymbol)
        geo.addSubview(geoName)
        
        geoSymbol.tintColor = .secondaryLabel
        geoSymbol.contentMode = .center
        if user.location != nil{
            geoSymbol.image = SFSymbols.location
        }
        
        
        geoName.text = user.location
        geoName.numberOfLines = 1
        
        //TODO: - Починить кривую картинку mapPin
        
        NSLayoutConstraint.activate([
        
            geoSymbol.leadingAnchor.constraint(equalTo: geoSymbol.superview!.leadingAnchor),
            geoSymbol.topAnchor.constraint(equalTo: geoSymbol.superview!.topAnchor),
            //geoSymbol.bottomAnchor.constraint(equalTo: geoSymbol.superview!.bottomAnchor),
            geoSymbol.heightAnchor.constraint(equalToConstant: geoName.font.pointSize),
            geoSymbol.widthAnchor.constraint(equalTo: geoSymbol.heightAnchor),

            geoName.leadingAnchor.constraint(equalTo: geoSymbol.trailingAnchor, constant: 5),
            geoName.topAnchor.constraint(equalTo: geoName.superview!.topAnchor),
            geoName.bottomAnchor.constraint(equalTo: geoName.superview!.bottomAnchor),
            geoName.trailingAnchor.constraint(equalTo: geoName.superview!.trailingAnchor)
        ])
        
        geoName.translatesAutoresizingMaskIntoConstraints = false
        geoSymbol.translatesAutoresizingMaskIntoConstraints = false
        //
        
        //Настройка био
        
        bio.text = user.bio ?? "Тут какой то текст.Тут какой то текст.Тут какой то текст.Тут какой то текст.Тут какой то текст."
        
        firstBlock.addSubview(bio)
        
        bio.numberOfLines = 5
        
        NSLayoutConstraint.activate([
            
            bio.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 10),
            bio.leadingAnchor.constraint(equalTo: bio.superview!.leadingAnchor, constant: 10),
            bio.trailingAnchor.constraint(equalTo: bio.superview!.trailingAnchor, constant: -10)
        ])
        
        bio.translatesAutoresizingMaskIntoConstraints = false
        //
    }
    
    func configurateSecondBlock(){
        
    }
    
    func configurateThirdBlock(){
        
    }
    
    func configurateViewController(){
        view.backgroundColor = .systemBackground //Установка цвета задника
        
        self.hideKeyboardWhenTappedAround() // Прятать клавиатуру при нажатии на экран
        
        
        navigationItem.leftBarButtonItem = .init(title: "Done", style: .done, target: self, action: #selector(doneButton))
        navigationItem.rightBarButtonItem = .init(image: SFSymbols.star, landscapeImagePhone: SFSymbols.star, style: .done, target: self, action: #selector(addToFavorite))
    }
    
    func configurateAvatar(){

    }
    
    func configurateOtherText(){
        
        

        
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
