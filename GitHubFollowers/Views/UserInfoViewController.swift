//
//  UserInfoViewController.swift
//  GitHubFollowers
//
//  Created by Садык Мусаев on 24.05.2021.
//

import UIKit
import SafariServices

// Отображение информации о юзере
class UserInfoViewController: UIViewController {
    
    let user:UserModel
    
    let firstBlock = UIView() //Первый блок с аватаркой, ником, локацией и био
    let secondBlock = UIView() // Блок связанный с репозиториями и гистами
    let thirdBlock = UIView() // Блок связанный с фоловерами и тд
    let dateLable = UILabel() // Дата создания акка

    
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
        //Настройка таблички с датой создания акка
        configurateDateBlock()
    }
    
    func configurateViewController(){
        view.backgroundColor = .systemBackground //Установка цвета задника
        
        self.hideKeyboardWhenTappedAround() // Прятать клавиатуру при нажатии на экран
        
        
        navigationItem.leftBarButtonItem = .init(title: "Done", style: .done, target: self, action: #selector(doneButton))
        navigationItem.rightBarButtonItem = .init(image: SFSymbols.star, landscapeImagePhone: SFSymbols.star, style: .done, target: self, action: #selector(addToFavorite))
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
        
        NSLayoutConstraint.activate([
        
            firstBlock.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            firstBlock.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 10),
            firstBlock.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
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
        firstBlockStack.distribution = .equalCentering
        
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
            geoSymbol.centerYAnchor.constraint(equalTo: geoSymbol.superview!.centerYAnchor,constant: -3),
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
        
        bio.text = user.bio
        
        firstBlock.addSubview(bio)
        
        bio.numberOfLines = 3
        
        NSLayoutConstraint.activate([
            
            bio.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20),
            bio.leadingAnchor.constraint(equalTo: bio.superview!.leadingAnchor, constant: 10),
            bio.trailingAnchor.constraint(equalTo: bio.superview!.trailingAnchor, constant: -10),
            bio.bottomAnchor.constraint(equalTo: bio.superview!.bottomAnchor)
        ])
        
        bio.translatesAutoresizingMaskIntoConstraints = false
        //
    }
    
    func configurateSecondBlock(){
        
        
        //Настройка второго блока
        
        view.addSubview(secondBlock)
        secondBlock.backgroundColor = .systemGray6 //УБРАТЬ
        
        NSLayoutConstraint.activate([
        
            secondBlock.topAnchor.constraint(equalTo: firstBlock.bottomAnchor, constant: 40),
            secondBlock.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            secondBlock.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            secondBlock.heightAnchor.constraint(lessThanOrEqualToConstant: 135)
        ])
        
        secondBlock.translatesAutoresizingMaskIntoConstraints = false
        //
        
        //Информация о репозиториях
        
        let repoBlock = UIView()
        let repoImage = UIImageView()
        let repoLabel = UILabel()
        let repoCount = UILabel()
                    
        secondBlock.addSubview(repoBlock)
        repoBlock.addSubview(repoImage)
        repoBlock.addSubview(repoLabel)
        repoBlock.addSubview(repoCount)
        
        repoImage.image = SFSymbols.repos
        repoImage.tintColor = .secondaryLabel
        repoLabel.text = "Public Repos"
        repoCount.text = String(user.publicRepos)
        
        NSLayoutConstraint.activate([
            
            repoBlock.topAnchor.constraint(equalTo: repoBlock.superview!.topAnchor, constant: 10),
            repoBlock.leadingAnchor.constraint(equalTo: repoBlock.superview!.leadingAnchor, constant: 10),
            repoBlock.trailingAnchor.constraint(equalTo: repoBlock.superview!.centerXAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            
            repoImage.topAnchor.constraint(equalTo: repoImage.superview!.topAnchor),
            repoImage.heightAnchor.constraint(equalToConstant: repoLabel.font.pointSize),
            repoImage.leadingAnchor.constraint(equalTo: repoImage.superview!.leadingAnchor),
            
            repoLabel.topAnchor.constraint(equalTo: repoLabel.superview!.topAnchor),
            repoLabel.leadingAnchor.constraint(equalTo: repoImage.trailingAnchor,constant: 10),
            repoLabel.trailingAnchor.constraint(equalTo: repoLabel.superview!.trailingAnchor),
            
            repoCount.topAnchor.constraint(equalTo: repoLabel.bottomAnchor, constant: 10),
            repoCount.centerXAnchor.constraint(equalTo: repoLabel.centerXAnchor)
        ])

        repoBlock.translatesAutoresizingMaskIntoConstraints = false
        repoImage.translatesAutoresizingMaskIntoConstraints = false
        repoLabel.translatesAutoresizingMaskIntoConstraints = false
        repoCount.translatesAutoresizingMaskIntoConstraints = false
        //
        
        //Информация о гистах(?)
        
        let gistBlock = UIView()
        let gistImage = UIImageView()
        let gistLabel = UILabel()
        let gistCount = UILabel()
            
        secondBlock.addSubview(gistBlock)
        gistBlock.addSubview(gistImage)
        gistBlock.addSubview(gistLabel)
        gistBlock.addSubview(gistCount)
        
        gistImage.image = SFSymbols.gists
        gistImage.tintColor = .secondaryLabel
        gistLabel.text = "Public Gists"
        gistCount.text = String(user.publicGists)
        
        NSLayoutConstraint.activate([
            
            gistBlock.topAnchor.constraint(equalTo: gistBlock.superview!.topAnchor, constant: 10),
            gistBlock.leadingAnchor.constraint(equalTo: gistBlock.superview!.centerXAnchor, constant: 10),
            gistBlock.trailingAnchor.constraint(equalTo: gistBlock.superview!.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            
            gistImage.topAnchor.constraint(equalTo: gistImage.superview!.topAnchor),
            gistImage.heightAnchor.constraint(equalToConstant: gistLabel.font.pointSize),
            gistImage.leadingAnchor.constraint(equalTo: gistImage.superview!.leadingAnchor),
            
            gistLabel.topAnchor.constraint(equalTo: gistLabel.superview!.topAnchor),
            gistLabel.leadingAnchor.constraint(equalTo: gistImage.trailingAnchor,constant: 10),
            gistLabel.trailingAnchor.constraint(equalTo: gistLabel.superview!.trailingAnchor),
            
            gistCount.topAnchor.constraint(equalTo: gistLabel.bottomAnchor, constant: 10),
            gistCount.centerXAnchor.constraint(equalTo: gistLabel.centerXAnchor)
        ])
        
        gistBlock.translatesAutoresizingMaskIntoConstraints = false
        gistImage.translatesAutoresizingMaskIntoConstraints = false
        gistLabel.translatesAutoresizingMaskIntoConstraints = false
        gistCount.translatesAutoresizingMaskIntoConstraints = false
        //
        
        //Переход в профиль ГХ
        
        let toProfielButton = UIButton()
        
        secondBlock.addSubview(toProfielButton)
        
        toProfielButton.setTitle("Safari", for: .normal)
        toProfielButton.backgroundColor = .cyan
        toProfielButton.addTarget(self, action: #selector(goToProfileFromSafari), for: .touchDown)
        
        NSLayoutConstraint.activate([
        
            toProfielButton.topAnchor.constraint(equalTo: repoCount.bottomAnchor, constant: 20),
            toProfielButton.leadingAnchor.constraint(equalTo: toProfielButton.superview!.leadingAnchor, constant: 10),
            toProfielButton.trailingAnchor.constraint(equalTo: toProfielButton.superview!.trailingAnchor, constant: -10),
            toProfielButton.heightAnchor.constraint(equalToConstant: 40),//ПОТОМ УБРАТЬ,
            toProfielButton.bottomAnchor.constraint(equalTo: toProfielButton.superview!.bottomAnchor, constant: -10)
        ])
        
        toProfielButton.translatesAutoresizingMaskIntoConstraints = false
        //
        

    }
    
    func configurateThirdBlock(){
        
        thirdBlock.setContentHuggingPriority(.defaultLow, for: .vertical)
        thirdBlock.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        secondBlock.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        secondBlock.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        
        //Настройка третьего блока
        
        view.addSubview(thirdBlock)
        thirdBlock.backgroundColor = .systemGray6 //УБРАТЬ
        
        NSLayoutConstraint.activate([
        
            thirdBlock.topAnchor.constraint(equalTo: secondBlock.bottomAnchor, constant: 40),
            thirdBlock.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            thirdBlock.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            thirdBlock.heightAnchor.constraint(lessThanOrEqualToConstant: 135)
        ])
        
        thirdBlock.translatesAutoresizingMaskIntoConstraints = false
        //
        
        //Информация о фоловерах
        
        let followerBlock = UIView()
        let followerImage = UIImageView()
        let followerLabel = UILabel()
        let followerCount = UILabel()
                    
        thirdBlock.addSubview(followerBlock)
        followerBlock.addSubview(followerImage)
        followerBlock.addSubview(followerLabel)
        followerBlock.addSubview(followerCount)
        
        followerImage.image = SFSymbols.heart
        followerImage.tintColor = .secondaryLabel
        followerLabel.text = "Followers"
        followerCount.text = String(user.followers)
        
        NSLayoutConstraint.activate([
            
            followerBlock.topAnchor.constraint(equalTo: followerBlock.superview!.topAnchor, constant: 10),
            followerBlock.leadingAnchor.constraint(equalTo: followerBlock.superview!.leadingAnchor, constant: 10),
            followerBlock.trailingAnchor.constraint(equalTo: followerBlock.superview!.centerXAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            
            followerImage.topAnchor.constraint(equalTo: followerImage.superview!.topAnchor),
            followerImage.heightAnchor.constraint(equalToConstant: followerLabel.font.pointSize),
            followerImage.leadingAnchor.constraint(equalTo: followerImage.superview!.leadingAnchor),
            
            followerLabel.topAnchor.constraint(equalTo: followerLabel.superview!.topAnchor),
            followerLabel.leadingAnchor.constraint(equalTo: followerImage.trailingAnchor,constant: 10),
            followerLabel.trailingAnchor.constraint(equalTo: followerLabel.superview!.trailingAnchor),
            
            followerCount.topAnchor.constraint(equalTo: followerLabel.bottomAnchor, constant: 10),
            followerCount.centerXAnchor.constraint(equalTo: followerLabel.centerXAnchor)
        ])

        followerBlock.translatesAutoresizingMaskIntoConstraints = false
        followerImage.translatesAutoresizingMaskIntoConstraints = false
        followerLabel.translatesAutoresizingMaskIntoConstraints = false
        followerCount.translatesAutoresizingMaskIntoConstraints = false
        //
        
        //Информация о фоловингах)))
        
        let followingBlock = UIView()
        let followingImage = UIImageView()
        let followingLabel = UILabel()
        let followingCount = UILabel()
            
        thirdBlock.addSubview(followingBlock)
        followingBlock.addSubview(followingImage)
        followingBlock.addSubview(followingLabel)
        followingBlock.addSubview(followingCount)
        
        followingImage.image = SFSymbols.persons
        followingImage.tintColor = .secondaryLabel
        followingLabel.text = "Following"
        followingCount.text = String(user.following)
        
        NSLayoutConstraint.activate([
            
            followingBlock.topAnchor.constraint(equalTo: followingBlock.superview!.topAnchor, constant: 10),
            followingBlock.leadingAnchor.constraint(equalTo: followingBlock.superview!.centerXAnchor, constant: 10),
            followingBlock.trailingAnchor.constraint(equalTo: followingBlock.superview!.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            
            followingImage.topAnchor.constraint(equalTo: followingImage.superview!.topAnchor),
            followingImage.heightAnchor.constraint(equalToConstant: followingLabel.font.pointSize),
            followingImage.leadingAnchor.constraint(equalTo: followingImage.superview!.leadingAnchor),
            
            followingLabel.topAnchor.constraint(equalTo: followingLabel.superview!.topAnchor),
            followingLabel.leadingAnchor.constraint(equalTo: followingImage.trailingAnchor,constant: 10),
            followingLabel.trailingAnchor.constraint(equalTo: followingLabel.superview!.trailingAnchor),
            
            followingCount.topAnchor.constraint(equalTo: followingLabel.bottomAnchor, constant: 10),
            followingCount.centerXAnchor.constraint(equalTo: followingLabel.centerXAnchor)
        ])
        
        followingBlock.translatesAutoresizingMaskIntoConstraints = false
        followingImage.translatesAutoresizingMaskIntoConstraints = false
        followingLabel.translatesAutoresizingMaskIntoConstraints = false
        followingCount.translatesAutoresizingMaskIntoConstraints = false
        //
        
        //Переход к фоловерам пользователя
        
        let getFollowersButton = UIButton()
        
        thirdBlock.addSubview(getFollowersButton)
        
        getFollowersButton.setTitle("Tap me!", for: .normal)
        getFollowersButton.backgroundColor = .cyan
        
        NSLayoutConstraint.activate([
        
            getFollowersButton.topAnchor.constraint(equalTo: followerCount.bottomAnchor, constant: 20),
            getFollowersButton.leadingAnchor.constraint(equalTo: getFollowersButton.superview!.leadingAnchor, constant: 10),
            getFollowersButton.trailingAnchor.constraint(equalTo: getFollowersButton.superview!.trailingAnchor, constant: -10),
            getFollowersButton.heightAnchor.constraint(equalToConstant: 40),//ПОТОМ УБРАТЬ
            getFollowersButton.bottomAnchor.constraint(equalTo: getFollowersButton.superview!.bottomAnchor, constant: -10)
        ])
        
        getFollowersButton.translatesAutoresizingMaskIntoConstraints = false
        //
    }
    
    func configurateDateBlock(){
        
        view.addSubview(dateLable)
        
        dateLable.text = "Created since " + Date.gHStringToDateString(ghString: user.created)
        
        dateLable.textAlignment = .center
        
        NSLayoutConstraint.activate([
        
            dateLable.bottomAnchor.constraint(equalTo: dateLable.superview!.safeAreaLayoutGuide.bottomAnchor,constant: -10),
            dateLable.leadingAnchor.constraint(equalTo: dateLable.superview!.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            dateLable.trailingAnchor.constraint(equalTo: dateLable.superview!.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
        
        dateLable.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func getFollowers(){
        
    }
    
    @objc func goToProfileFromSafari(){
        
        guard let urlForSafari = URL(string:user.pageURL) else {return}
        let safariPage = SFSafariViewController(url: urlForSafari)
        
        present(safariPage, animated: true, completion: nil)
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
