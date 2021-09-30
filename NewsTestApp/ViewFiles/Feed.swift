//
//  ViewController.swift
//  NewsTestApp
//
//  Created by Caleb Mesfien on 11/13/20.
//

import UIKit
import Foundation
import Lottie
import SDWebImage
import RealmSwift
import SWXMLHash
import OpenGraph
import SafariServices
import SideMenu
//import MSPeekCollectionViewDelegateImplementation



struct results: Decodable{
    var results: [ArticleObjects]
}

struct mainObject: Decodable{
    var data: results
//    var number: Int
}


protocol PostCollectionViewDel {
    func PostInteraction(btnItem: Int, image: UIImage?, url: String?, title: String?, description: String?, date: String?, sourceName: String?, imageURL: String?)
    func openView(url: String)
}


struct ArticleObjects: Decodable{
    var id: String?
    var url: String?
    var title: String?
    var description: String?
    var author: String?
    var date: String?
    var source_name: String?
    var image: String?
  }



var listOfTopicObject = [ArticleObjects]()
//{
//    didSet{
//        let realm = try! Realm()
//        try! realm.write {
//            realm.objects(trendingArtTop.self).first!.Technology.removeAll()
//        }
//
//        var item = [TrendingArticleObject]()
//        listOfTopicObject.forEach { (ArticleObjects) in
//            let objectArt = TrendingArticleObject()
//            objectArt.id = ArticleObjects.id
//            objectArt.url = ArticleObjects.url
//            objectArt.title = ArticleObjects.title
//            objectArt.desc = ArticleObjects.description
//            objectArt.author = ArticleObjects.author
//            objectArt.date = ArticleObjects.date
//            objectArt.source_name = ArticleObjects.source_name
//            objectArt.image = ArticleObjects.image
//            item.append(objectArt)
//        }
//                try! realm.write {
//                    realm.objects(trendingArtTop.self)[0].Technology.append(objectsIn: item)
//                }
//    }
//}
//var listItemSelected = [ArticleObjects]()

var ListObjectTrending = [ArticleItem](){
    didSet{
        let realm = try! Realm()
        if ListObjectTrending.count == 1{
            try! realm.write {
                realm.objects(trendingArtTop.self).first!.Trending.removeAll()
            }
        }
//        var item = [TrendingArticleObject]()
//        ListObjectTrending.forEach { (ArticleObjects) in
        let ArticleObjects = ListObjectTrending.last!

            let objectArt = TrendingArticleObject()
//            objectArt.id = ArticleObjects.id
            objectArt.url = ArticleObjects.url
            objectArt.title = ArticleObjects.title
            objectArt.desc = ArticleObjects.desc
//            objectArt.author = ArticleObjects.author
            objectArt.date = ArticleObjects.date
            objectArt.source_name = ArticleObjects.source_name
            objectArt.image = ArticleObjects.image
//            item.append(objectArt)
//        }
                try! realm.write {
                    realm.objects(trendingArtTop.self)[0].Trending.append(objectArt)
                }
        print("Finished")
    }
}
var ListObjectTechnology = [ArticleItem](){
    didSet{
        let realm = try! Realm()
        if ListObjectTechnology.count == 1{
            try! realm.write {
                realm.objects(trendingArtTop.self).first!.Technology.removeAll()
            }
        }

//        var item = [TrendingArticleObject]()
//        ListObjectTechnology.forEach { (ArticleObjects) in
        let ArticleObjects = ListObjectTechnology.last!

            let objectArt = TrendingArticleObject()
//            objectArt.id = ArticleObjects.id
            objectArt.url = ArticleObjects.url
            objectArt.title = ArticleObjects.title
            objectArt.desc = ArticleObjects.desc
//            objectArt.author = ArticleObjects.author
            objectArt.date = ArticleObjects.date
            objectArt.source_name = ArticleObjects.source_name
            objectArt.image = ArticleObjects.image
//            item.append(objectArt)
//        }
                try! realm.write {
                    realm.objects(trendingArtTop.self)[0].Technology.append(objectArt)
                }
    }
}
var ListObjectEntertainment = [ArticleItem](){
    didSet{
        let realm = try! Realm()
        if ListObjectEntertainment.count == 1{
            try! realm.write {
                realm.objects(trendingArtTop.self).first!.Entertainment.removeAll()
            }
        }
//        var item = [TrendingArticleObject]()
//        ListObjectEntertainment.forEach { (ArticleObjects) in
        let ArticleObjects = ListObjectEntertainment.last!

            let objectArt = TrendingArticleObject()
//            objectArt.id = ArticleObjects.id
            objectArt.url = ArticleObjects.url
            objectArt.title = ArticleObjects.title
            objectArt.desc = ArticleObjects.desc
//            objectArt.author = ArticleObjects.author
            objectArt.date = ArticleObjects.date
            objectArt.source_name = ArticleObjects.source_name
            objectArt.image = ArticleObjects.image
//            item.append(objectArt)
//        }
                try! realm.write {
                    realm.objects(trendingArtTop.self)[0].Entertainment.append(objectArt)
                }
    }
}
var ListObjectSports = [ArticleItem](){
    didSet{
        let realm = try! Realm()
        if ListObjectSports.count == 1{
            try! realm.write {
                realm.objects(trendingArtTop.self).first!.Sports.removeAll()
            }
        }
//        var item = [TrendingArticleObject]()
//        ListObjectSports.forEach { (ArticleObjects) in
        let ArticleObjects = ListObjectSports.last!

            let objectArt = TrendingArticleObject()
//            objectArt.id = ArticleObjects.id
            objectArt.url = ArticleObjects.url
            objectArt.title = ArticleObjects.title
            objectArt.desc = ArticleObjects.desc
//            objectArt.author = ArticleObjects.author
            objectArt.date = ArticleObjects.date
            objectArt.source_name = ArticleObjects.source_name
            objectArt.image = ArticleObjects.image
//            item.append(objectArt)
//        }
                try! realm.write {
                    realm.objects(trendingArtTop.self)[0].Sports.append(objectArt)
                }
    }
}
var ListObjectBuisness = [ArticleItem](){
    didSet{
        let realm = try! Realm()
        if ListObjectBuisness.count == 1{
            try! realm.write {
                realm.objects(trendingArtTop.self).first!.Buisness.removeAll()
            }
        }

//        var item = [TrendingArticleObject]()
//        ListObjectBuisness.forEach { (ArticleObjects) in
        let ArticleObjects = ListObjectBuisness.last!

            let objectArt = TrendingArticleObject()
//            objectArt.id = ArticleObjects.id
            objectArt.url = ArticleObjects.url
            objectArt.title = ArticleObjects.title
            objectArt.desc = ArticleObjects.desc
//            objectArt.author = ArticleObjects.author
            objectArt.date = ArticleObjects.date
            objectArt.source_name = ArticleObjects.source_name
            objectArt.image = ArticleObjects.image
//            item.append(objectArt)
//        }
                try! realm.write {
                    realm.objects(trendingArtTop.self)[0].Buisness.append(objectArt)
                }
    }
}
var ListObjectPolitics = [ArticleItem](){
    didSet{
        let realm = try! Realm()
        if ListObjectPolitics.count == 1{
            try! realm.write {
                realm.objects(trendingArtTop.self).first!.Politics.removeAll()
            }
        }

//        var item = [TrendingArticleObject]()
//        ListObjectPolitics.forEach { (ArticleObjects) in
        let ArticleObjects = ListObjectPolitics.last!

            let objectArt = TrendingArticleObject()
//            objectArt.id = ArticleObjects.id
            objectArt.url = ArticleObjects.url
            objectArt.title = ArticleObjects.title
            objectArt.desc = ArticleObjects.desc
            objectArt.date = ArticleObjects.date
            objectArt.source_name = ArticleObjects.source_name
            objectArt.image = ArticleObjects.image
//            item.append(objectArt)
//        }
                try! realm.write {
                    realm.objects(trendingArtTop.self)[0].Politics.append(objectArt)
                }
    }
}
var ListObjectScience = [ArticleItem](){
    didSet{
        let realm = try! Realm()
        if ListObjectScience.count == 1{
        try! realm.write {
            realm.objects(trendingArtTop.self).first!.Science.removeAll()
        }
        }
        let ArticleObjects = ListObjectScience.last!
//        var item = [TrendingArticleObject]()
            let objectArt = TrendingArticleObject()
            objectArt.url = ArticleObjects.url
            objectArt.title = ArticleObjects.title
            objectArt.desc = ArticleObjects.desc
            objectArt.date = ArticleObjects.date
            objectArt.source_name = ArticleObjects.source_name
            objectArt.image = ArticleObjects.image
//            item.append(objectArt)
                try! realm.write {
                    realm.objects(trendingArtTop.self)[0].Science.append(objectArt)
                }
    }
}
//let objectArt = TrendingArticleObject()








protocol MenuProtocol {
    func ItemSelected(_ Item: Int)
}



//      MARK: FEEDVIEWCONTROLLERS
class FeedViewController: UIViewController, PostCollectionViewDel, PostOption, blackViewProtocol,SearchTopicCollectionProtocol, SideMenuNavigationControllerDelegate, MenuProtocol, scrollViewPro, UIGestureRecognizerDelegate{
    
    let maxMainViewHeight: CGFloat = 55
    var currentAt: CGFloat = 0
//    var mainViewHeight:NSLayoutConstraint?
    func scroll(at: CGFloat) {
//        print(at)
        
//        var newViewHeight: CGFloat = mainViewHeight!.constant - at
////        mainView.alpha = 1
//        if currentAt > at{
//        mainViewHeight?.constant = 55
//         mainNavView.alpha = 1
//        }
//        currentAt = at
//
//        if newViewHeight > maxMainViewHeight{
//            mainViewHeight?.constant = maxMainViewHeight
//        }else if mainViewHeight!.constant < 0{
//            mainViewHeight?.constant = 0
//        }else{
//            mainNavView.alpha = 1-at/10
//            mainViewHeight?.constant = newViewHeight
//        }
    }
        
        
    func ItemSelected(_ Item: Int) {
        switch Item {
        case 0:
//            let vc = EditProfileView()
//            vc.hidesBottomBarWhenPushed = true
//            self.navigationController?.pushViewController(vc, animated: true)
            let vc = LoadingTopicsScreen()
            vc.delegate = self
            self.tabBarController?.tabBar.isHidden = true
            present(vc, animated: true, completion: nil)

        case 1:
//            let vc = RelationshipViewController()
//            vc.hidesBottomBarWhenPushed = true
//            navigationController?.pushViewController(vc, animated: true)
            let vc = LoadingTopicsScreen()
            vc.delegate = self
            self.tabBarController?.tabBar.isHidden = true
            present(vc, animated: true, completion: nil)
        case 2:
            let vc = fullSizePost()
            vc.hidesBottomBarWhenPushed = true
            self.tabBarController?.tabBar.isHidden = true
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
//            let vc = NewFriendView()
//            vc.delegate = self
//            vc.hidesBottomBarWhenPushed = true
//            vc.modalPresentationStyle = .overCurrentContext
//            tabBarController?.tabBar.isHidden = true
//            present(vc, animated: true, completion: nil)
            let vc = LoadingTopicsScreen()
            vc.delegate = self
            self.tabBarController?.tabBar.isHidden = true
            present(vc, animated: true, completion: nil)
        case 4:
            let vc = UserSettings()
            vc.hidesBottomBarWhenPushed = true
            self.tabBarController?.tabBar.isHidden = true
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
    func OpenTopic(title: String) {
        let vc = SearchResultCollection()
        vc.topicTitle = title
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func option(_ OptionNum: Int, image: UIImage) {
        if OptionNum == 0{
            
        }else{
            let vc = NewPostView()
            vc.articleImage.image = image
            present(vc, animated: true, completion: nil)
        }
    }
    
    func changeBlackView() {
        UIView.animate(withDuration: 0.3) {
            self.blackWindow.alpha = 0
            self.tabBarController?.tabBar.isHidden = false
        }


    }
    
    let blackWindow = UIView()


    func openView(url: String) {

        if realmObjc.objects(AutoReaderMode.self)[0].isOn{
            let safariVC = SFSafariViewController(url: URL(string: url)!, entersReaderIfAvailable: true)
            safariVC.preferredBarTintColor = .black
            safariVC.preferredControlTintColor = .white
            present(safariVC, animated: true, completion: nil)
        }else{
            let safariVC = SFSafariViewController(url: URL(string: url)!, entersReaderIfAvailable: false)
            safariVC.preferredBarTintColor = .black
            safariVC.preferredControlTintColor = .white
            present(safariVC, animated: true, completion: nil)
        }

    }
    
    func PostInteraction(btnItem: Int, image: UIImage?, url: String?, title: String?, description: String?, date: String?, sourceName: String?, imageURL: String?){
        if btnItem == 0{
//                    generator.impactOccurred()
//                            if let window = UIApplication.shared.keyWindow{
//                                blackWindow.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height)
//                                blackWindow.backgroundColor = UIColor(white: 0, alpha: 0.5)
//                                blackWindow.alpha = 0
//                                view.addSubview(blackWindow)
//                                UIView.animate(withDuration: 0.5) {
//                                    self.blackWindow.alpha = 1
//                                }
//                    }
//
//            let vc = NewPostView()
//            vc.articleImage.image = image
//            vc.url = url!
//            vc.titleText = title!
//            vc.desc = description!
//            vc.date = date!
//            vc.source_name = sourceName!
//            vc.image = imageURL!
//
//
//
//
//
//            vc.delegate = self
//            self.tabBarController?.tabBar.isHidden = true
//            navigationController?.present(vc, animated: true)
//

        }else if btnItem == 1{
//            generator.impactOccurred()
//                    if let window = UIApplication.shared.keyWindow{
//                        blackWindow.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height)
//                        blackWindow.backgroundColor = UIColor(white: 0, alpha: 0.5)
//                        blackWindow.alpha = 0
//                        view.addSubview(blackWindow)
//
//                        UIView.animate(withDuration: 0.5) {
//                            self.blackWindow.alpha = 1
//                        }
//            }
//            let vc = sendPost()
//            vc.PostImage = image
//            vc.delegate = self
//
//            vc.hidesBottomBarWhenPushed = true
//            vc.modalPresentationStyle = .overCurrentContext
//            self.tabBarController?.tabBar.isHidden = true
//
//            present(vc, animated: true, completion: nil)
            let vc = LoadingTopicsScreen()
            vc.delegate = self
            self.tabBarController?.tabBar.isHidden = true
            present(vc, animated: true, completion: nil)
        }else if btnItem == 2{
            
            let vc = UIActivityViewController(activityItems: [URL(string: url!)!], applicationActivities: [])
            vc.overrideUserInterfaceStyle = .dark
            present(vc, animated: true)
        }else{
            generator.impactOccurred()
                    if let window = UIApplication.shared.keyWindow{
                        blackWindow.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height)
                        blackWindow.backgroundColor = UIColor(white: 0, alpha: 0.5)
                        blackWindow.alpha = 0
                        view.addSubview(blackWindow)

                        UIView.animate(withDuration: 0.5) {
                            self.blackWindow.alpha = 1
                        }
            }
            let vc = InstagramStoryPostView()
            vc.PostImage = image
            vc.Date = date
            vc.TitleText = title
            vc.Publication = sourceName
            vc.DescriptionText = description
            vc.delegate = self

            vc.hidesBottomBarWhenPushed = true
            vc.modalPresentationStyle = .overCurrentContext
            self.tabBarController?.tabBar.isHidden = true
            
            present(vc, animated: true, completion: nil)
        }
    }
    

    
    

    
    
    
    
    func fetchTrendingTopics(item: Int){
        let realm = try! Realm()
        if realm.objects(trendingArtTop.self).first == nil{
            try! realm.write {
                realm.add(trendingArtTop())
            }
        }

        var str = String()
        if item == 6{
//            str = "trending"
            print("Trending")
            str = "https://news.google.com/rss?hl=en-US&gl=US&ceid=US:en"

        }else{
           str = "https://news.google.com/news/rss/headlines/section/topic/\(HeaderForTrending[item])"

//            str = "https://news.google.com/rss/search?q=\(header[item])&hl=en-US&gl=US&ceid=US:en"
            print(header[item], item)
        }
        
        guard let url = URL(string:str ) else{print("First"); return}
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {return}
        guard let str = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else{return}
        //one root element
            let xml = SWXMLHash.parse(str as String)
            
//            let count = xml["rss"]["channel"]["item"].all.count
            outerLoop: for i in 0...30 {
            guard let artURL = xml["rss"]["channel"]["item"][i]["link"].element?.text else{return}
            guard let artDate = xml["rss"]["channel"]["item"][i]["pubDate"].element?.text else{print("Nil date");return}
            let start = artDate.index(artDate.startIndex, offsetBy: 5)
            let end = artDate.index(artDate.endIndex, offsetBy: 0)
            let date = artDate[start..<end]
            guard let artProvider = xml["rss"]["channel"]["item"][i]["source"].element?.text else{print("Nil provider");return}
            guard let url = URL(string: artURL) else {print("URL is Broken!"); return}
            OpenGraph.fetch(url: url) { result in
                nestedLoop: switch result {
                case .success(let og):
                    guard let artTitle = og[.title] else{return}
                    guard let imageURL = og[.image] else{return}
                    guard let descText = og[.description] else{return}

                    let itemArt = ArticleItem(url: artURL, title: artTitle, desc: descText, date: String(date), source_name: artProvider, image: imageURL)
                    
                    switch item {
                    case 0:
                        guard ListObjectTechnology.count != 10 else{return}
                        ListObjectTechnology.append(itemArt)
                        return
                    case 1:
                        guard ListObjectEntertainment.count != 5 else{return}
                        ListObjectEntertainment.append(itemArt)
                        return
                    case 2:
                        guard ListObjectSports.count != 5 else{return}
                        ListObjectSports.append(itemArt)
                    case 3:
                        guard ListObjectBuisness.count != 5 else{return}
                        ListObjectBuisness.append(itemArt)
                    case 4:
                        guard ListObjectPolitics.count != 5 else{return}
                        ListObjectPolitics.append(itemArt)
                    case 5:
                        guard ListObjectScience.count != 5 else{return}
                        ListObjectScience.append(itemArt)
                        print( "CHECK", ListObjectScience.count)

                    default:
                        guard ListObjectTrending.count != 5 else{return}
                        ListObjectTrending.append(itemArt)
                    }


                    
                case .failure(let error):
                    print("Error")
                }
            }
            }
        }
        task.resume()


    }
 

    let realmObjc = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.scrollToStackIndex(index: 1)
        }
        ConstraintContainer()
        DispatchQueue.main.asyncAfter(deadline: .now()+20) {
            self.LoadView.removeFromSuperview()
        }

        view.backgroundColor = BlackBackgroundColor
//
        

        let tapGest = UITapGestureRecognizer(target: self, action: #selector(ProfileMenuTapped))
        profileImg.addGestureRecognizer(tapGest)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.navigationBar.barTintColor = BlackBackgroundColor
//        navigationController?.navigationBar.tintColor = subViewColor
//        navigationController?.navigationBar.isTranslucent = false
//        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.backButtonTitle = ""
        navigationController?.interactivePopGestureRecognizer?.delegate = self

        LoadView.play()
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = false
        if realmObjc.objects(DarkMode.self)[0].isDarkMode{
            UIApplication.shared.statusBarStyle = .lightContent
        }else{
            UIApplication.shared.statusBarStyle = .darkContent
        }
    }

    
    lazy var collectionViewController: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.register(SubscriptionFeed.self, forCellWithReuseIdentifier: "SubscriptionFeed")
        collectionView.register(ForYouFeed.self, forCellWithReuseIdentifier: "ForYouFeed")

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
        
    }()
    
    lazy var StackCollection: FeedStack = {
       let stack = FeedStack()
        stack.FeedViewControllerItem = self
        stack.backgroundColor = .clear
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    


    lazy var LoadView: AnimationView = {
       let animationView = AnimationView()
        animationView.animation = Animation.named("LoadingAnimation")
        animationView.animationSpeed = 1.5
        animationView.play()
        animationView.loopMode = .loop

        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    
    lazy var profileImg: UIImageView = {
       let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
//        imgView.layer.cornerRadius = 25
        if realmObjc.objects(DarkMode.self)[0].isDarkMode{
            imgView.image = UIImage(named: "MenuBarWhite")
        }else{
            imgView.image = UIImage(named: "MenuBarBlack")
        }
        imgView.isUserInteractionEnabled = true

        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    lazy var mainNavView: CustomView = {
       let view = CustomView()
        if realmObjc.objects(DarkMode.self)[0].isDarkMode == false{
            view.layer.masksToBounds = false
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOffset = CGSize(width: 0.0, height: 10)
            view.layer.shadowRadius = 5
            view.layer.shadowOpacity = 0.05
        }
        view.backgroundColor = BlackBackgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//
    func ConstraintContainer(){
        collectionViewController.delegate = self
        collectionViewController.dataSource = self

        view.addSubview(collectionViewController)
        view.addSubview(mainNavView)
        mainNavView.addSubview(LoadView)
        mainNavView.addSubview(StackCollection)
        mainNavView.addSubview(profileImg)
//        mainViewHeight = mainNavView.heightAnchor.constraint(equalToConstant: 55)
        NSLayoutConstraint.activate([
//            lineView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
//            lineView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            lineView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            lineView.heightAnchor.constraint(equalToConstant: 0.5),
            

            
            mainNavView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
//            mainViewHeight!,
            mainNavView.heightAnchor.constraint(equalToConstant: 45),
            mainNavView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainNavView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            StackCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            StackCollection.centerYAnchor.constraint(equalTo: mainNavView.centerYAnchor, constant: 0),
            StackCollection.trailingAnchor.constraint(equalTo: mainNavView.trailingAnchor, constant: 0),
            StackCollection.widthAnchor.constraint(equalToConstant: 234),
            StackCollection.heightAnchor.constraint(equalToConstant: 30),

            profileImg.heightAnchor.constraint(equalToConstant: 28),
            profileImg.widthAnchor.constraint(equalToConstant: 28),
            profileImg.centerYAnchor.constraint(equalTo: mainNavView.centerYAnchor, constant: 0),
            profileImg.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            LoadView.leadingAnchor.constraint(equalTo: profileImg.trailingAnchor, constant: 4),
            LoadView.centerYAnchor.constraint(equalTo: mainNavView.centerYAnchor, constant: 0),
            LoadView.widthAnchor.constraint(equalToConstant: 50),
            LoadView.heightAnchor.constraint(equalToConstant: 50),
            
            collectionViewController.topAnchor.constraint(equalTo: mainNavView.bottomAnchor),
            collectionViewController.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionViewController.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionViewController.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)


        ])
    }
    func InstagramStories(view: UIView){
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        let image = renderer.image { ctx in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        
        if let storiesUrl = URL(string: "instagram-stories://share"){
            if UIApplication.shared.canOpenURL(storiesUrl) {
                guard let pngImage = image.pngData() else {return}
                let pastboardItems: [String: Any] = [
                    "com.instagram.sharedSticker.stickerImage": pngImage,
//                    "com.instagram.sharedSticker.backgroundTopColor": "#000000",
//                    "com.instagram.sharedSticker.backgroundBottomColor": "#ff5a60"
                ]
                let pastboardOptions = [
                    UIPasteboard.OptionsKey.expirationDate: Date().advanced(by: 300)
                ]
                
                UIPasteboard.general.setItems([pastboardItems], options: pastboardOptions)
                UIApplication.shared.open(storiesUrl, options: [:], completionHandler: nil)
            }else{
                print("User doesn't have instagram")
            }
        }
    }
    @objc func AddFriendSelected(){
        
    }
    @objc func ProfileMenuTapped(){

        let vc = AccountViewController()
        vc.MenuItemDelegate = self
        let menu = SideMenuNavigationController(rootViewController: vc)
        menu.setNavigationBarHidden(true, animated: true)
        SideMenuManager.default.leftMenuNavigationController = menu
        menu.leftSide = true
        navigationController?.present(menu, animated: true)
    }
    func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappeared! (animated: \(animated))")
//        changeBlackView()
    }
    
    func scrollToStackIndex(index: Int){
        collectionViewController.scrollToItem(at: NSIndexPath(item: index, section: 0) as IndexPath, at: .init(), animated: false)
        collectionViewController.layoutIfNeeded() // **Without this effect wont be visible**
    }
    
    
}










extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let const = scrollView.contentOffset.x/(view.frame.width*0.0075)

        if scrollView.contentOffset.x == 0{
            StackCollection.widthHorizontalBar?.constant = 128
        }
        
        if (scrollView.contentOffset.y < 0){
            //reach top
            print("Done")
        }
        StackCollection.widthHorizontalBar?.constant = 128-scrollView.contentOffset.x/7
        StackCollection.leftHorizontalBar?.constant = const
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let item = targetContentOffset.pointee.x/view.frame.width
        StackCollection.stackOptionCollectionView.selectItem(at: NSIndexPath(item: Int(item), section: 0) as IndexPath, animated: true, scrollPosition: .init())
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        if indexPath.row == 0{
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "followingFeed", for: indexPath) as! FollowingFeed
//
//            return cell
//        }else
        if indexPath.row == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubscriptionFeed", for: indexPath) as! SubscriptionFeed
            cell.delegate = self
            cell.ScrollDelegate = self
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForYouFeed", for: indexPath) as! ForYouFeed
            cell.newPostDelegate = self
            cell.ScrollDelegate = self
            return cell
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        return size
    }

}




class SubscriptionFeed: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    let realmObjc = try! Realm()
    var ScrollDelegate: scrollViewPro?
    var delegate: SearchTopicCollectionProtocol?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return realmObjc.objects(SubscribedTopics.self).count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubscriptionCell", for: indexPath) as! SubscriptionCell
        cell.subTitle.text = realmObjc.objects(SubscribedTopics.self)[indexPath.row].title.uppercased()
        cell.topicTitle.text = realmObjc.objects(SubscribedTopics.self)[indexPath.row].topicTitle
        cell.sourceName.text = realmObjc.objects(SubscribedTopics.self)[indexPath.row].source_name
        cell.topicImg.sd_setImage(with: URL(string: realmObjc.objects(SubscribedTopics.self)[indexPath.row].topicImgURL), placeholderImage:UIImage(named:"BlankBackground"))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: frame.width, height: 160)
        return size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.OpenTopic(title:realmObjc.objects(SubscribedTopics.self)[indexPath.row].title)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y/2
        ScrollDelegate?.scroll(at: y)
    }
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.bounces = true
        collectionView.showsVerticalScrollIndicator = false

        collectionView.register(SubscriptionCell.self, forCellWithReuseIdentifier: "SubscriptionCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let img: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    let header: CustomLabel = {
        let lbl = CustomLabel()
        lbl.font = .systemFont(ofSize: 18, weight: .bold)
        lbl.textColor = subViewColor
        lbl.textAlignment = .center

        lbl.text = "No Current Subscriptions"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    let subHeader: CustomLabel = {
        let lbl = CustomLabel()
        lbl.text = "You currently have no subscriptions. To subscribe to specific topics, head to the trending tab and search for a topic."
        lbl.font = .systemFont(ofSize: 12, weight: .bold)
        lbl.textColor = .lightGray
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    override init(frame: CGRect){
        super.init(frame: frame)
        if realmObjc.objects(SubscribedTopics.self).isEmpty{
            addSubview(header)
            addSubview(subHeader)
            NSLayoutConstraint.activate([
                header.centerYAnchor.constraint(equalTo: centerYAnchor),
                header.centerXAnchor.constraint(equalTo: centerXAnchor),
                
                subHeader.topAnchor.constraint(equalTo: header.bottomAnchor),
                subHeader.centerXAnchor.constraint(equalTo: centerXAnchor),
                subHeader.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            ])
        }else{
            addSubview(collectionView)
            addConstraintsWithFormat(format:"H:|[v0]|", views: collectionView)
            addConstraintsWithFormat(format:"V:|[v0]|", views: collectionView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


class SubscriptionCell: UICollectionViewCell{
    let realmObjc = try! Realm()
    override init(frame: CGRect) {
        super.init(frame: frame)
        constraintContianer()
    }
    lazy var titleView: CustomView = {
       let view = CustomView()
        if realmObjc.objects(DarkMode.self)[0].isDarkMode{
            view.backgroundColor = .black
        }else{
            view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let hashtagImg: UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named:"PurpleHashtag")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let subTitle: CustomLabel = {
       let label = CustomLabel()
        label.textColor = subViewColor
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let topicImg: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.image = UIImage(named: "BlankBackground")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let topicTitle: CustomLabel = {
       let label = CustomLabel()
        label.textColor = subViewColor
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let moreText: CustomLabel = {
       let label = CustomLabel()
        label.text = "More..."
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let sourceName: CustomLabel = {
       let label = CustomLabel()
//        label.text = "More..."
        label.textColor = TealConstantColor
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    func constraintContianer(){
        addSubview(titleView)
        titleView.addSubview(hashtagImg)
        titleView.addSubview(subTitle)
        addSubview(topicImg)
        addSubview(topicTitle)
        addSubview(sourceName)
        addSubview(moreText)
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleView.heightAnchor.constraint(equalToConstant: 40),
            
            hashtagImg.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 12),
            hashtagImg.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            hashtagImg.heightAnchor.constraint(equalToConstant: 30),
            hashtagImg.widthAnchor.constraint(equalToConstant: 30),
            
            subTitle.leadingAnchor.constraint(equalTo: hashtagImg.trailingAnchor, constant: 8),
            subTitle.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -12),
            subTitle.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            
            
            topicImg.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 42),
            topicImg.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 4),
            topicImg.widthAnchor.constraint(equalTo: topicImg.heightAnchor),
            topicImg.bottomAnchor.constraint(equalTo: moreText.topAnchor, constant: -4),

            topicTitle.leadingAnchor.constraint(equalTo: topicImg.trailingAnchor, constant: 8),
            topicTitle.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 8),
            topicTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            sourceName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            sourceName.bottomAnchor.constraint(equalTo: topicImg.bottomAnchor),
            
            moreText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            moreText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 42),
            moreText.heightAnchor.constraint(equalToConstant: moreText.intrinsicContentSize.height)
            
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class ForYouFeed: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource,
                  UICollectionViewDelegateFlowLayout,PostCollectionViewDel {
    let realmObjc = try! Realm()
    var ScrollDelegate: scrollViewPro?
    
    var FYFeedArticles = [ArticleItem](){
        didSet{
//            DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
            if FYFeedArticles.count % 50 == 0{
            DispatchQueue.main.async {
                
                self.recentCollectionView.reloadSections(IndexSet(integer: 0))
            }
        }
        }
    }
    
    
    func fetchImage(_ q: String){
        var url: URL?
        let Topics = ["WORLD", "NATION", "BUSINESS", "TECHNOLOGY", "ENTERTAINMENT", "SPORTS", "SCIENCE", "HEALTH"]
        if Topics.contains(where: {$0 == q.uppercased()}){
            url = URL(string: "https://news.google.com/news/rss/headlines/section/topic/\(q.uppercased())")
        }else if q == "Trending"{
            url = URL(string:"https://news.google.com/rss?hl=en-US&gl=US&ceid=US:en")
        }else{
            url = URL(string: "https://news.google.com/rss/search?q=\(q.replacingOccurrences(of: " ", with: "%20"))&hl=en-US&gl=US&ceid=US:en")
        }
//        guard let url = URL(string: "https://news.google.com/rss/search?q=\(q.replacingOccurrences(of: " ", with: "%20"))&hl=en-US&gl=US&ceid=US:en") else{print("First"); return}
//        guard let url = URL(string: "https://news.google.com/news/rss/headlines/section/topic/\(q)") else{print("First"); return}
        
        var ItemNum = Int()
            let count = realmObjc.objects(userObject.self)[0].interests.count
            if count >= 18{
                ItemNum = 15
                print("peep")
            }else if count >= 12{
                ItemNum = 25
                print(count, "BOOOOM3")
            }else if count >= 6{
                ItemNum = 45
                print(count, "BOOOOM2")
            }else if count >= 3{
                ItemNum = 75
                print(count, "BOOOOM1")
            }
        print(ItemNum, "Carp")

        print(ItemNum)
        
        
        
            let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
                
            guard let data = data else{return}
            guard let str = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else{print("Second");return}

                let xml = SWXMLHash.parse(str as String)

                for i in 0...ItemNum {
                    print("THIS IS CELL # ",i )
                    guard let artURL = xml["rss"]["channel"]["item"][i]["link"].element?.text else{break}
                    guard let artDate = xml["rss"]["channel"]["item"][i]["pubDate"].element?.text else{print("Nil date");break}
                    guard let artProvider = xml["rss"]["channel"]["item"][i]["source"].element?.text else{print("Nil provider");break}
                    guard let url = URL(string: artURL) else {print("URL is Broken!"); break}
                    OpenGraph.fetch(url: url) { result in
                        switch result {
                        
                        case .success(let og):
                            guard let artTitle = og[.title] else{break}
                            guard let imageURL = og[.image] else{break}
                            guard let descText = og[.description] else{break}
                            
                            
                            
                            let dateFormatterGet = DateFormatter()
                            dateFormatterGet.dateFormat = "E, dd MMM yyyy HH:mm:ss zzz"
    
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy, EEEE MMM d h:mm a"

                            let date: NSDate? = dateFormatterGet.date(from: (artDate)) as NSDate?
                            let newDate = dateFormatter.string(from: date! as Date)
                            var desc: String?
                            if descText.count >= 280{
                                desc = descText.prefix(280) + "..."
                            }else{
                                desc = descText
                            }
                            let item = ArticleItem(url: artURL, title: artTitle.htmlDecoded(), desc: String(desc!).htmlDecoded(), date: newDate, source_name: artProvider, image: imageURL)
                            

//                            if self.FYFeedArticles.count > 10{
//                                let number = Int.random(in: 10..<self.FYFeedArticles.count)
//                                self.FYFeedArticles.insert(item, at: number)
//                            }else{
                            DispatchQueue.main.async {
                                self.FYFeedArticles.append(item)
                            }
//                            }

                        
                        case .failure(_):
                        print("Error:\n")
                    }
                }
                }
            }
        task.resume()
        
//        DispatchQueue.main.asyncAfter(deadline: .now()+4.5, execute: {
//            print(self.FYFeedArticles.count, "Done")
//            print("DoneWithTime")
//            self.FYFeedArticles = itemList
//        })


    }

    func openView(url: String) {
        newPostDelegate?.openView(url: url)
    }

    var newPostDelegate: PostCollectionViewDel?
    func PostInteraction(btnItem: Int,image: UIImage?, url: String?, title: String?, description: String?, date: String?, sourceName: String?, imageURL: String?) {
        newPostDelegate?.PostInteraction(btnItem: btnItem,image: image, url: url, title: title, description: description, date: date, sourceName: sourceName, imageURL: imageURL)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = BlackBackgroundColor
//        behavior = MSCollectionViewPeekingBehavior()
//        recentCollectionView.configureForPeekingBehavior(behavior: behavior)

        for i in realmObjc.objects(userObject.self).first!.interests{
            fetchImage(i)
        }
        fetchImage("Trending")
//        fetchImage("TECHNOLOGY")
//        DispatchQueue.main.asyncAfter(deadline: .now()+15) {
//            self.FYFeedArticles.sort { (($0.date).compare($1.date)) == .orderedDescending }
            self.addSubview(self.recentCollectionView)
            self.addConstraintsWithFormat(format:"H:|[v0]|", views: self.recentCollectionView)
            self.addConstraintsWithFormat(format:"V:|[v0]|", views: self.recentCollectionView)
//        }


    }
    
//    let spacing = (1/8)*UIScreen.main.bounds.height
//    let cellHeight = (3/4)*UIScreen.main.bounds.height
//    let cellSpacing = (1/16)*UIScreen.main.bounds.height
    

        lazy var recentCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            layout.scrollDirection = .vertical

            collectionView.delegate = self
            collectionView.dataSource = self
//            collectionView.ScrollDelegate = self
//            collectionView.decelerationRate = .fast
//            collectionView.isPagingEnabled = true
            collectionView.isScrollEnabled = true
            collectionView.backgroundColor = .clear
            collectionView.bounces = true
            collectionView.showsVerticalScrollIndicator = false
    
            collectionView.register(ForYouFeedCell.self, forCellWithReuseIdentifier: "ForYouFeedCell")
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            return collectionView
        }()

//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//            behavior.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
//    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y/2
        ScrollDelegate?.scroll(at: y)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return FYFeedArticles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy, EEEE MMM d h:mm a"
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForYouFeedCell", for: indexPath) as! ForYouFeedCell
            cell.tag = indexPath.row
            cell.newPostDelegate = self
//            let item = indexPath.row
        
        
//            guard URL(string:FYFeedArticles[item].image) != nil else {
//                    DispatchQueue.main.async {
//                        self.FYFeedArticles.remove(at: item)
//                        collectionView.deleteItems(at: [NSIndexPath(row: item, section: 0) as IndexPath])
//                    }
//
//                return cell}

//            if cell.tag == indexPath.row{

                
                DispatchQueue.main.async {
                    if self.FYFeedArticles[indexPath.row].source_name == "Engadget"{
                        cell.TopicImage.image = UIImage(named: "ENGADGETIMG")
                    }else if self.FYFeedArticles[indexPath.row].source_name == "Bleacher Report"{
                        cell.TopicImage.image = UIImage(named: "BLEACHERREPORTIMG")
                    }else{
                        cell.TopicImage.sd_setImage(with:URL(string: self.FYFeedArticles[indexPath.row].image), placeholderImage: UIImage(named: "BlankBackground"))
                    }
                }
                
                cell.TopicTitle.text = FYFeedArticles[indexPath.row].title
                cell.TopicDesc.text = FYFeedArticles[indexPath.row].desc
                cell.PublicationName.text = FYFeedArticles[indexPath.row].source_name
                

                

                if FYFeedArticles[indexPath.row].date == ""{
                        cell.DateOfTopic.text = "-"
                }else{
                    
                    let date = dateFormatter.date(from: FYFeedArticles[indexPath.row].date)?.timeAgoDisplay()
                    
                    cell.DateOfTopic.text = date
                    cell.urlItem = FYFeedArticles[indexPath.row].url
                    cell.dateItem = FYFeedArticles[indexPath.row].date
                    cell.backgroundColor = .clear
                }
//            }
                return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//        return UIEdgeInsets(top: 0, left: 0, bottom: 130, right: 0)
//    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        
        let sizeOfItem = CGSize(width: (UIScreen.main.bounds.width-48), height: 1000)
        let titleItem = NSString(string:FYFeedArticles[indexPath.row].title).boundingRect(with:sizeOfItem , options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .bold)], context: nil)
        let descItem = NSString(string:FYFeedArticles[indexPath.row].desc).boundingRect(with:sizeOfItem , options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)], context: nil)

        let size = CGSize(width: frame.width, height:titleItem.height+descItem.height+388)
            return size
//        let size = CGSize(width: frame.width, height:collectionView.frame.height)
//            return size

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == recentCollectionView{
            newPostDelegate?.openView(url: FYFeedArticles[indexPath.row].url)
        }
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



//  MARK: FOLLOWINGFEEDCELL

//
//class FollowingFeedCell: UICollectionViewCell {
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        let likePressed = UITapGestureRecognizer(target: self, action: #selector(likeButtonSelected))
//        LikeButton.addGestureRecognizer(likePressed)
//        instagramStoriesBtn.addTarget(self, action: #selector(instagramBtnSelected), for: .touchUpInside)
//        constraintContainer()
//
//    }
//
//
//    fileprivate let mainViewCard: CustomView = {
//        let view = CustomView()
//        view.layer.cornerRadius = 20
//        view.clipsToBounds = true
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    fileprivate let ProfileImage: UIImageView = {
//        let view = UIImageView()
//        view.layer.cornerRadius = 45/2
//        view.clipsToBounds = true
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    fileprivate let ProfileName: CustomLabel = {
//        let label = CustomLabel()
//        label.attributedText = NSAttributedString(string: "Elon Musk", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .semibold)])
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    fileprivate let userHandle: CustomLabel = {
//        let label = CustomLabel()
//        label.attributedText = NSAttributedString(string: "@elon4real", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .regular)])
////        label.textColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    fileprivate let PostTime: CustomLabel = {
//        let label = CustomLabel()
//        label.attributedText = NSAttributedString(string: "• 3:32 PM", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .regular)])
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    fileprivate let TopicCaption: CustomLabel = {
//        let label = CustomLabel()
//        label.numberOfLines = 0
//        label.attributedText = NSAttributedString(string: "I think there’s a lot of talent, talented designers and engineers, in Europe. And a lot of the best people, they want to work somewhere where they are doing original design work. They don’t want to just be doing the European version of something that was designed in California.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .regular)])
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//
//
//    fileprivate let TopicView: CustomView = {
//       let view = CustomView()
//        view.backgroundColor = .clear
//        view.clipsToBounds = true
//        view.layer.cornerRadius = 20
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//
//    fileprivate let TopicImage: CustomImageView2 = {
//        let view = CustomImageView2()
//        view.contentMode = .scaleAspectFill
//        view.backgroundColor = .clear
//        view.layer.cornerRadius = 20
//        view.image = UIImage(named: "BlankBackground")
//        view.clipsToBounds = true
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//
//    fileprivate let DimTopicLayer: UIImageView = {
//       let view = UIImageView()
//        view.alpha = 0.55
//        view.backgroundColor = .black
//        view.clipsToBounds = true
//        view.layer.cornerRadius = 20
////        view.image = UIImage(named: "TopGradientImage")
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//
//
//    fileprivate let TopicTitle: CustomLabel = {
//        let label = CustomLabel()
//        label.numberOfLines = 0
//        label.adjustsFontSizeToFitWidth = true
//        label.attributedText = NSAttributedString(string: "Elon Musk believes he has a mild version of COVID-19", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .semibold)])
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    fileprivate let TopicDesc: CustomLabel = {
//        let label = CustomLabel()
//        label.numberOfLines = 4
////        label.adjustsFontSizeToFitWidth = true
////        label.backgroundColor = .cyan
//        label.attributedText = NSAttributedString(string: "Facebook has gotten so big that it's impossible to understand how it all works. Congress' concerns over data privacy are valid, but many missed a larger, deeper issue. More lawmakers should be asking if Facebook is getting too big and if it should be", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .semibold)])
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    fileprivate let PublicationName: CustomLabel = {
//        let label = CustomLabel()
//        label.attributedText = NSAttributedString(string: "Wall Street Journal", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .semibold)])
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//
//    fileprivate let DoteSeperator: CustomLabel = {
//        let label = CustomLabel()
//        label.attributedText = NSAttributedString(string: "•", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .semibold)])
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    fileprivate let DateOfTopic: CustomLabel = {
//        let label = CustomLabel()
//        label.attributedText = NSAttributedString(string: "2 Hours ago", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .semibold)])
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//
////    INTERACTIVE BUTTONS
//
//    let LikeButton: AnimationView = {
//      let animationView = AnimationView()
//       animationView.animation = Animation.named("likeAnimation")
//       animationView.animationSpeed = 2
////        animationView.backgroundColor = .black
//       animationView.currentFrame = 0
//       animationView.translatesAutoresizingMaskIntoConstraints = false
//       return animationView
//   }()
//
//    fileprivate let PostOptionsButton: UIButton = {
//       let imageView = UIButton()
//        imageView.tintColor = .black
//        imageView.setImage(UIImage(named: "blackShareIcon"), for: .normal)
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//
//
//    fileprivate let instagramStoriesBtn: UIButton = {
//       let imageView = UIButton()
//        imageView.tintColor = .black
//        imageView.setImage(UIImage(named: "blackInstagramStories"), for: .normal)
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//
//    fileprivate let instagramStoriesLabel: CustomLabel  = {
//       let label = CustomLabel()
//        label.attributedText = NSAttributedString(string: "Add to Instagram Story", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .semibold)])
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//
//
//
//
//    fileprivate let lineView: CustomView = {
//       let view = CustomView()
//        view.backgroundColor = .black
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//
//
//
//    func constraintContainer(){
//
//        self.addSubview(mainViewCard)
//        mainViewCard.addSubview(TopicImage)
//        mainViewCard.addSubview(DimTopicLayer)
//        mainViewCard.addSubview(ProfileImage)
//        mainViewCard.addSubview(ProfileName)
//        mainViewCard.addSubview(userHandle)
//        mainViewCard.addSubview(PostTime)
//        mainViewCard.addSubview(TopicCaption)
//
//        mainViewCard.addSubview(TopicView)
//
//            TopicView.addSubview(TopicTitle)
//            TopicView.addSubview(TopicDesc)
//
//            TopicView.addSubview(PublicationName)
//            TopicView.addSubview(DoteSeperator)
//            TopicView.addSubview(DateOfTopic)
//
//
//        TopicView.addSubview(LikeButton)
//        TopicView.addSubview(PostOptionsButton)
//
//        TopicView.addSubview(instagramStoriesBtn)
//        TopicView.addSubview(instagramStoriesLabel)
//
//        NSLayoutConstraint.activate([
//
//            mainViewCard.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 4),
//            mainViewCard.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            mainViewCard.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            mainViewCard.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//
//            ProfileImage.centerYAnchor.constraint(equalTo: TopicCaption.topAnchor, constant: 4),
//            ProfileImage.heightAnchor.constraint(equalToConstant: 45),
//            ProfileImage.widthAnchor.constraint(equalToConstant: 45),
//            ProfileImage.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor, constant: 16),
//
//            ProfileName.leadingAnchor.constraint(equalTo: ProfileImage.trailingAnchor, constant: 8),
//            ProfileName.topAnchor.constraint(equalTo: ProfileImage.topAnchor),
//
//
//            userHandle.leadingAnchor.constraint(equalTo: ProfileName.trailingAnchor, constant: 2),
//            userHandle.topAnchor.constraint(equalTo: ProfileImage.topAnchor),
////            userHandle.widthAnchor.constraint(equalToConstant: PostTime.intrinsicContentSize.width),
//
//            PostTime.leadingAnchor.constraint(equalTo: userHandle.trailingAnchor, constant: 2),
//            PostTime.topAnchor.constraint(equalTo: ProfileImage.topAnchor),
//            PostTime.widthAnchor.constraint(equalToConstant: PostTime.intrinsicContentSize.width),
//
//            TopicCaption.bottomAnchor.constraint(equalTo: mainViewCard.bottomAnchor, constant: -60),
//            TopicCaption.leadingAnchor.constraint(equalTo: ProfileImage.trailingAnchor, constant: 8),
//            TopicCaption.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor, constant: -16),
//            TopicCaption.heightAnchor.constraint(equalToConstant: 100),
//
//
//
//
//            TopicView.topAnchor.constraint(equalTo: mainViewCard.topAnchor, constant: 8),
//            TopicView.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor),
//            TopicView.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor),
//            TopicView.bottomAnchor.constraint(equalTo: mainViewCard.bottomAnchor),
//
//            TopicImage.topAnchor.constraint(equalTo: mainViewCard.topAnchor),
//            TopicImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
//            TopicImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
//            TopicImage.bottomAnchor.constraint(equalTo: ProfileImage.topAnchor, constant: -12),
//
//            DimTopicLayer.topAnchor.constraint(equalTo: mainViewCard.topAnchor),
//            DimTopicLayer.leadingAnchor.constraint(equalTo: TopicView.leadingAnchor, constant: 12),
//            DimTopicLayer.trailingAnchor.constraint(equalTo: TopicView.trailingAnchor, constant: -12),
//            DimTopicLayer.bottomAnchor.constraint(equalTo: ProfileImage.topAnchor, constant: -12),
//
////            DimTopicLayerBottom.heightAnchor.constraint(equalToConstant: 175),
////            DimTopicLayerBottom.leadingAnchor.constraint(equalTo: TopicView.leadingAnchor),
////            DimTopicLayerBottom.trailingAnchor.constraint(equalTo: TopicView.trailingAnchor),
////            DimTopicLayerBottom.bottomAnchor.constraint(equalTo: mainViewCard.bottomAnchor),
//
//            TopicTitle.topAnchor.constraint(equalTo: mainViewCard.topAnchor, constant: 12),
//            TopicTitle.leadingAnchor.constraint(equalTo: TopicView.leadingAnchor, constant: 22),
//            TopicTitle.trailingAnchor.constraint(equalTo: TopicView.trailingAnchor, constant: -22),
//            TopicTitle.heightAnchor.constraint(equalToConstant: 80),
//
//            PublicationName.topAnchor.constraint(equalTo: TopicDesc.bottomAnchor, constant: 8),
//            PublicationName.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor, constant: 22),
//
//            DoteSeperator.centerYAnchor.constraint(equalTo: PublicationName.centerYAnchor),
//            DoteSeperator.leadingAnchor.constraint(equalTo: PublicationName.trailingAnchor, constant: 4),
//
//
//            DateOfTopic.centerYAnchor.constraint(equalTo: PublicationName.centerYAnchor),
//            DateOfTopic.leadingAnchor.constraint(equalTo: DoteSeperator.leadingAnchor, constant: 8),
//            DateOfTopic.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor, constant: -4),
//
//
//            TopicDesc.topAnchor.constraint(equalTo:TopicTitle.bottomAnchor ,constant: -8),
//            TopicDesc.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor, constant: 22),
//            TopicDesc.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor, constant: -22),
//            TopicDesc.heightAnchor.constraint(equalToConstant: 80),
//
////            LIKE COUNT
////            LikeCountText.leadingAnchor.constraint(equalTo: TopicView.leadingAnchor, constant: 16),
////            LikeCountText.bottomAnchor.constraint(equalTo: TopicView.bottomAnchor, constant: -16),
////            LikeCountLabel.leadingAnchor.constraint(equalTo: LikeCountText.trailingAnchor, constant: 4),
////            LikeCountLabel.centerYAnchor.constraint(equalTo: LikeCountText.centerYAnchor),
//
////            LIKE BUTTON
////            LikeButton.bottomAnchor.constraint(equalTo: TopicView.bottomAnchor, constant: -16),
//            LikeButton.centerYAnchor.constraint(equalTo: instagramStoriesBtn.centerYAnchor),
//            LikeButton.trailingAnchor.constraint(equalTo: PostOptionsButton.leadingAnchor, constant: -8),
//            LikeButton.heightAnchor.constraint(equalToConstant: 42),
//            LikeButton.widthAnchor.constraint(equalToConstant: 42),
//
////            OPTIONS BUTTON
//            PostOptionsButton.centerYAnchor.constraint(equalTo: instagramStoriesBtn.centerYAnchor, constant: 1.5),
////            PostOptionsButton.bottomAnchor.constraint(equalTo: TopicView.bottomAnchor, constant: -16),
//            PostOptionsButton.trailingAnchor.constraint(equalTo: TopicView.trailingAnchor, constant: -12),
//            PostOptionsButton.heightAnchor.constraint(equalToConstant: 28),
//            PostOptionsButton.widthAnchor.constraint(equalToConstant: 28),
//
//
//
////            lineView.heightAnchor.constraint(equalToConstant: 0.5),
////            lineView.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor),
////            lineView.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor),
////            lineView.topAnchor.constraint(equalTo: mainViewCard.topAnchor)
//
//            instagramStoriesBtn.bottomAnchor.constraint(equalTo: TopicView.bottomAnchor, constant: -16),
//            instagramStoriesBtn.leadingAnchor.constraint(equalTo: TopicView.leadingAnchor, constant: 16),
//            instagramStoriesBtn.heightAnchor.constraint(equalToConstant: 25),
//            instagramStoriesBtn.widthAnchor.constraint(equalToConstant: 25),
//
//            instagramStoriesLabel.leadingAnchor.constraint(equalTo: instagramStoriesBtn.trailingAnchor, constant: 8),
//            instagramStoriesLabel.centerYAnchor.constraint(equalTo: instagramStoriesBtn.centerYAnchor)
//
//
//        ])
//
//
//    }
//
//    @objc func likeButtonSelected(){
//        if LikeButton.currentFrame == 0{
//            for gesture in LikeButton.gestureRecognizers! {gesture.isEnabled = false}
//
//            LikeButton.play(fromFrame: 0, toFrame: 40, loopMode: .none, completion: nil)
//
////            ENABLE BUTTON
//            DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
//                for gesture in self.LikeButton.gestureRecognizers! {gesture.isEnabled = true}
//            }
//        }else{
//            for gesture in LikeButton.gestureRecognizers! {gesture.isEnabled = false}
//
//            LikeButton.play(fromFrame: 40, toFrame: 0, loopMode: .none, completion: nil)
//
//
////            ENABLE BUTTON
//            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
//                for gesture in self.LikeButton.gestureRecognizers! {gesture.isEnabled = true}
//            }
//        }
//    }
//
//    @objc func instagramBtnSelected(){
//        instagramStoriesBtn.removeFromSuperview()
//        instagramStoriesLabel.removeFromSuperview()
//        LikeButton.removeFromSuperview()
//        PostOptionsButton.removeFromSuperview()
//
//
//        let queLabel = UILabel()
//        queLabel.attributedText = NSAttributedString(string: "@Que", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold)])
//        queLabel.translatesAutoresizingMaskIntoConstraints = false
//        mainViewCard.addSubview(queLabel)
//        queLabel.bottomAnchor.constraint(equalTo: mainViewCard.bottomAnchor, constant: -12).isActive = true
//        queLabel.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor, constant: 12).isActive = true
//
//
//            let renderer = UIGraphicsImageRenderer(size: mainViewCard.bounds.size)
//            let image = renderer.image { ctx in
//                mainViewCard.drawHierarchy(in: mainViewCard.bounds, afterScreenUpdates: true)
//            }
//
//            if let storiesUrl = URL(string: "instagram-stories://share"){
//                if UIApplication.shared.canOpenURL(storiesUrl) {
//                    guard let pngImage = image.pngData() else {return}
//                    let pastboardItems: [String: Any] = [
//                        "com.instagram.sharedSticker.stickerImage": pngImage,
////                        "com.instagram.sharedSticker.backgroundTopColor": "#000000",
////                        "com.instagram.sharedSticker.backgroundBottomColor": "#000000"
////                        "com.instagram.sharedSticker.backgroundBottomColor": "#ff5a60"
//                    ]
//                    let pastboardOptions = [
//                        UIPasteboard.OptionsKey.expirationDate: Date().advanced(by: 300)
//                    ]
//
//                    UIPasteboard.general.setItems([pastboardItems], options: pastboardOptions)
//                    UIApplication.shared.open(storiesUrl, options: [:], completionHandler: nil)
//                }else{
//                    print("User doesn't have instagram")
//                }
//            }
//        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
//            queLabel.removeFromSuperview()
//            self.constraintContainer()
//        }
//
//    }
//
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//













//          MARK: FORYOUFEEDCELL
class InterestCells: UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        constraintContainer()
    }
    
    fileprivate let interestLabel: CustomLabel = {
        let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "Entertainment", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .semibold)])
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let topicBackgroundImage: UIImageView = {
      let imageView = UIImageView()
        imageView.image = UIImage(named: "PostExample")
//        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate let dimView: CustomView = {
       let view = CustomView()
        view.backgroundColor = .black

        view.alpha = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    fileprivate func constraintContainer(){
        self.addSubview(topicBackgroundImage)
        self.addSubview(dimView)
        self.addSubview(interestLabel)
        
        self.addConstraintsWithFormat(format: "H:|[v0]|", views: topicBackgroundImage)
        self.addConstraintsWithFormat(format: "V:|[v0]|", views: topicBackgroundImage)
        
        self.addConstraintsWithFormat(format: "H:|[v0]|", views: dimView)
        self.addConstraintsWithFormat(format: "V:|[v0]|", views: dimView)
        
        self.addConstraintsWithFormat(format: "H:|-[v0]-|", views: interestLabel)
        self.addConstraintsWithFormat(format: "V:[v0]-8-|", views: interestLabel)
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}






class ForYouFeedCell: UICollectionViewCell {

    let realmObjc = try! Realm()
    var newPostDelegate: PostCollectionViewDel?
    var ScrollDelegate: scrollViewPro?
    
    
    var urlItem: String?
    var dateItem: String?
    override init(frame: CGRect) {
        super.init(frame: frame)
        instagramStoriesBtn.addTarget(self, action: #selector(instagramBtnSelected), for: .touchUpInside)
        postBtn.addTarget(self, action: #selector(newPostBtnSelected), for: .touchUpInside)
        sendBtn.addTarget(self, action: #selector(SendPostSelected), for: .touchUpInside)
        PostOptionsButton.addTarget(self, action: #selector(SharePostSelected), for: .touchUpInside)

        constraintContainer()
    }
    
    
    fileprivate let mainViewCard: CustomView = {
        let view = CustomView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    
//    fileprivate let TopicView: CustomView = {
//       let view = CustomView()
//
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    fileprivate let TopicImage: CustomImageView2 = {
        let view = CustomImageView2()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .clear
        view.layer.cornerRadius = 20
        view.image = UIImage(named: "BlankBackground")
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let DimTopicLayer: UIImageView = {
       let view = UIImageView()
        view.alpha = 0.55
        view.backgroundColor = .black
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()


    fileprivate let TopicTitle: CustomLabel = {
        let label = CustomLabel()
        label.numberOfLines = 0
//        label.adjustsFontSizeToFitWidth = true
        label.attributedText = NSAttributedString(string: "-", attributes: [NSAttributedString.Key.foregroundColor: subViewColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .bold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let TopicDesc: CustomLabel = {
        let label = CustomLabel()
        label.numberOfLines = 0
        
//        UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        label.attributedText = NSAttributedString(string: "-", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    fileprivate let PublicationName: CustomLabel = {
        let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "-", attributes: [NSAttributedString.Key.foregroundColor: TealConstantColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    fileprivate let DoteSeperator: CustomLabel = {
        let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "•", attributes: [NSAttributedString.Key.foregroundColor: TealConstantColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    fileprivate let DateOfTopic: CustomLabel = {
        let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "-", attributes: [NSAttributedString.Key.foregroundColor: TealConstantColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
//    INTERACTIVE BUTTONS
    
    fileprivate lazy var instagramStoriesBtn: UIButton = {
       let imageView = UIButton()
        if realmObjc.objects(DarkMode.self)[0].isDarkMode{
            imageView.setImage(UIImage(named: "instagramStories"), for: .normal)
        }else{
            imageView.setImage(UIImage(named: "blackInstagramStories"), for: .normal)

        }
        imageView.addTarget(self, action: #selector(instagramBtnSelected), for: .touchUpInside)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate let instagramStoriesLabel: CustomLabel  = {
       let label = CustomLabel()
        label.numberOfLines = 2
        label.attributedText = NSAttributedString(string: "Add to Instagram Story", attributes: [NSAttributedString.Key.foregroundColor: subViewColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10, weight: .semibold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    fileprivate lazy var PostOptionsButton: UIButton = {
       let btn = UIButton()
        if realmObjc.objects(DarkMode.self)[0].isDarkMode{
            btn.setImage(UIImage(named: "Share"), for: .normal)
        }else{
            btn.setImage(UIImage(named: "blackShare"), for: .normal)
        }
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    fileprivate let PostOptionsButtonTitle: CustomLabel  = {
       let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "Share", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10, weight: .semibold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    fileprivate lazy var postBtn: UIButton = {
       let btn = UIButton()
        if realmObjc.objects(DarkMode.self)[0].isDarkMode{
            btn.setImage(UIImage(named: "newPost"), for: .normal)
        }else{
            btn.setImage(UIImage(named: "blackNewPost"), for: .normal)
        }
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    fileprivate let postBtnTitle: CustomLabel  = {
       let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "Post", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10, weight: .semibold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    fileprivate lazy var sendBtn: UIButton = {
       let btn = UIButton()
        if realmObjc.objects(DarkMode.self)[0].isDarkMode{
            btn.setImage(UIImage(named: "SendInApp"), for: .normal)
        }else{
            btn.setImage(UIImage(named: "blackSendInApp"), for: .normal)
        }
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    fileprivate let sendBtnTitle: CustomLabel  = {
       let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "Send", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10, weight: .semibold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    fileprivate let lineView: CustomView = {
       let view = CustomView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let savedLbl: CustomLabel = {
        let label = CustomLabel()
        label.alpha = 0
        label.attributedText = NSAttributedString(string: "Saved", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .semibold)])
        label.textAlignment = .right
        label.textColor = subViewColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var AccountViewControllerItem: FeedViewController?

    func constraintContainer(){
        
        self.addSubview(mainViewCard)
        mainViewCard.addSubview(TopicImage)
//        mainViewCard.addSubview(DimTopicLayer)

        
//        mainViewCard.addSubview(TopicView)

            mainViewCard.addSubview(TopicTitle)
            mainViewCard.addSubview(TopicDesc)
        
            mainViewCard.addSubview(PublicationName)
            mainViewCard.addSubview(DoteSeperator)
            mainViewCard.addSubview(DateOfTopic)
        

        
        mainViewCard.addSubview(PostOptionsButton)
        mainViewCard.addSubview(postBtn)
        mainViewCard.addSubview(sendBtn)
        mainViewCard.addSubview(instagramStoriesBtn)
        
//        TopicView.addSubview(PostOptionsButtonTitle)
//        TopicView.addSubview(postBtnTitle)
//        TopicView.addSubview(sendBtnTitle)
        mainViewCard.addSubview(instagramStoriesLabel)
        


        
        
        NSLayoutConstraint.activate([
//            IT STARTS HERE
            
            
            mainViewCard.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 4),
            mainViewCard.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            mainViewCard.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            mainViewCard.bottomAnchor.constraint(equalTo: self.bottomAnchor),




//            TopicView.topAnchor.constraint(equalTo: TopicImage.bottomAnchor, constant: -8),
//            TopicView.heightAnchor.constraint(equalToConstant: TopicView.intrinsicContentSize.height),
//            TopicView.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor),
//            TopicView.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor),
//            TopicView.bottomAnchor.constraint(equalTo: instagramStoriesBtn.topAnchor, constant: -16),

            TopicImage.topAnchor.constraint(equalTo: self.topAnchor, constant: -12),
            TopicImage.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor),
            TopicImage.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor),
            TopicImage.heightAnchor.constraint(equalToConstant: 300),
//            TopicImage.bottomAnchor.constraint(equalTo: TopicTitle.topAnchor, constant: -8),


            TopicTitle.topAnchor.constraint(equalTo: TopicImage.bottomAnchor, constant: 8),
            TopicTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            TopicTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),

            TopicDesc.topAnchor.constraint(equalTo:TopicTitle.bottomAnchor ,constant: 8),
            TopicDesc.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            TopicDesc.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
//            TopicDesc.heightAnchor.constraint(equalToConstant: TopicDesc.int)

            PublicationName.topAnchor.constraint(equalTo: TopicDesc.bottomAnchor, constant: 8),
            PublicationName.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor, constant: 16),
            PublicationName.heightAnchor.constraint(equalToConstant: PublicationName.intrinsicContentSize.height),

            DoteSeperator.topAnchor.constraint(equalTo: TopicDesc.bottomAnchor, constant: 8),
            DoteSeperator.leadingAnchor.constraint(equalTo: PublicationName.trailingAnchor, constant: 4),
            DoteSeperator.heightAnchor.constraint(equalToConstant: DoteSeperator.intrinsicContentSize.height),

            DateOfTopic.topAnchor.constraint(equalTo: TopicDesc.bottomAnchor, constant: 8),
            DateOfTopic.leadingAnchor.constraint(equalTo: DoteSeperator.leadingAnchor, constant: 8),
            DateOfTopic.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor, constant: -4),
            DateOfTopic.heightAnchor.constraint(equalToConstant: DateOfTopic.intrinsicContentSize.height),



//            LIKE BUTTON
            postBtn.trailingAnchor.constraint(equalTo: sendBtn.leadingAnchor, constant: -14),
            postBtn.centerYAnchor.constraint(equalTo: instagramStoriesBtn.centerYAnchor),
            postBtn.heightAnchor.constraint(equalToConstant: 28),
            postBtn.widthAnchor.constraint(equalToConstant: 28),
//            postBtnTitle.topAnchor.constraint(equalTo: postBtn.bottomAnchor, constant: 2),
//            postBtnTitle.centerXAnchor.constraint(equalTo: postBtn.centerXAnchor),

            sendBtn.trailingAnchor.constraint(equalTo: PostOptionsButton.leadingAnchor, constant: -14),
            sendBtn.bottomAnchor.constraint(equalTo: instagramStoriesBtn.bottomAnchor),
            sendBtn.heightAnchor.constraint(equalToConstant: 28),
            sendBtn.widthAnchor.constraint(equalToConstant: 28),
//            sendBtnTitle.topAnchor.constraint(equalTo: sendBtn.bottomAnchor, constant: 2),
//            sendBtnTitle.centerXAnchor.constraint(equalTo: sendBtn.centerXAnchor),


            PostOptionsButton.centerYAnchor.constraint(equalTo: instagramStoriesBtn.centerYAnchor),
            PostOptionsButton.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor, constant: -16),
            PostOptionsButton.heightAnchor.constraint(equalToConstant: 32),
            PostOptionsButton.widthAnchor.constraint(equalToConstant: 32),
//            PostOptionsButtonTitle.topAnchor.constraint(equalTo: PostOptionsButton.bottomAnchor, constant: 2),
//            PostOptionsButtonTitle.centerXAnchor.constraint(equalTo: PostOptionsButton.centerXAnchor),


            instagramStoriesBtn.bottomAnchor.constraint(equalTo: mainViewCard.bottomAnchor, constant: -16),
            instagramStoriesBtn.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor, constant: 16),
            instagramStoriesBtn.heightAnchor.constraint(equalToConstant: 30),
            instagramStoriesBtn.widthAnchor.constraint(equalToConstant: 30),

            instagramStoriesLabel.leadingAnchor.constraint(equalTo: instagramStoriesBtn.trailingAnchor, constant: 8),
            instagramStoriesLabel.centerYAnchor.constraint(equalTo: instagramStoriesBtn.centerYAnchor),
            instagramStoriesLabel.widthAnchor.constraint(equalToConstant: 85)
            
            
            
//              IT ENDS HERE
            
            
            
            
            
            
            
//            mainViewCard.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 4),
//            mainViewCard.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
//            mainViewCard.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
//            mainViewCard.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//
//
//
//
////            TopicView.topAnchor.constraint(equalTo: mainViewCard.topAnchor, constant: 8),
////            TopicView.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor),
////            TopicView.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor),
////            TopicView.bottomAnchor.constraint(equalTo: mainViewCard.bottomAnchor),
//
//            TopicImage.topAnchor.constraint(equalTo: self.topAnchor, constant: -12),
//            TopicImage.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor),
//            TopicImage.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor),
//            TopicImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 12),
//
//            DimTopicLayer.topAnchor.constraint(equalTo: mainViewCard.topAnchor),
//            DimTopicLayer.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor),
//            DimTopicLayer.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor),
//            DimTopicLayer.bottomAnchor.constraint(equalTo: mainViewCard.bottomAnchor),
//
//            TopicTitle.topAnchor.constraint(equalTo: mainViewCard.topAnchor, constant: 12),
//            TopicTitle.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor, constant: 16),
//            TopicTitle.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor, constant: -8),
//
//            TopicDesc.topAnchor.constraint(equalTo:TopicTitle.bottomAnchor ,constant: 8),
//            TopicDesc.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor, constant: 16),
//            TopicDesc.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor, constant: -16),
//
//            PublicationName.topAnchor.constraint(equalTo: TopicDesc.bottomAnchor, constant: 8),
//            PublicationName.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor, constant: 16),
//
//            DoteSeperator.topAnchor.constraint(equalTo: TopicDesc.bottomAnchor, constant: 8),
//            DoteSeperator.leadingAnchor.constraint(equalTo: PublicationName.trailingAnchor, constant: 4),
//
//
//            DateOfTopic.topAnchor.constraint(equalTo: TopicDesc.bottomAnchor, constant: 8),
//            DateOfTopic.leadingAnchor.constraint(equalTo: DoteSeperator.leadingAnchor, constant: 8),
//            DateOfTopic.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor, constant: -4),
//
//
//
//
////            LIKE BUTTON
//            postBtn.trailingAnchor.constraint(equalTo: sendBtn.leadingAnchor, constant: -14),
//            postBtn.centerYAnchor.constraint(equalTo: instagramStoriesBtn.centerYAnchor),
//            postBtn.heightAnchor.constraint(equalToConstant: 32),
//            postBtn.widthAnchor.constraint(equalToConstant: 32),
////            postBtnTitle.topAnchor.constraint(equalTo: postBtn.bottomAnchor, constant: 2),
////            postBtnTitle.centerXAnchor.constraint(equalTo: postBtn.centerXAnchor),
//
//            sendBtn.trailingAnchor.constraint(equalTo: PostOptionsButton.leadingAnchor, constant: -14),
//            sendBtn.bottomAnchor.constraint(equalTo: instagramStoriesBtn.bottomAnchor),
//            sendBtn.heightAnchor.constraint(equalToConstant: 30),
//            sendBtn.widthAnchor.constraint(equalToConstant: 30),
////            sendBtnTitle.topAnchor.constraint(equalTo: sendBtn.bottomAnchor, constant: 2),
////            sendBtnTitle.centerXAnchor.constraint(equalTo: sendBtn.centerXAnchor),
//
//
//            PostOptionsButton.centerYAnchor.constraint(equalTo: instagramStoriesBtn.centerYAnchor),
//            PostOptionsButton.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor, constant: -16),
//            PostOptionsButton.heightAnchor.constraint(equalToConstant: 32),
//            PostOptionsButton.widthAnchor.constraint(equalToConstant: 32),
////            PostOptionsButtonTitle.topAnchor.constraint(equalTo: PostOptionsButton.bottomAnchor, constant: 2),
////            PostOptionsButtonTitle.centerXAnchor.constraint(equalTo: PostOptionsButton.centerXAnchor),
//
//
//            instagramStoriesBtn.bottomAnchor.constraint(equalTo: mainViewCard.bottomAnchor, constant: -16),
//            instagramStoriesBtn.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor, constant: 16),
//            instagramStoriesBtn.heightAnchor.constraint(equalToConstant: 32),
//            instagramStoriesBtn.widthAnchor.constraint(equalToConstant: 32),
//
//            instagramStoriesLabel.leadingAnchor.constraint(equalTo: instagramStoriesBtn.trailingAnchor, constant: 8),
//            instagramStoriesLabel.centerYAnchor.constraint(equalTo: instagramStoriesBtn.centerYAnchor),
//            instagramStoriesLabel.widthAnchor.constraint(equalToConstant: 85)
////
            
        ])

        
    }
    
    @objc func newPostBtnSelected(){

        let postObjc = PostObject()
        
        postObjc.url = urlItem!
        postObjc.title = TopicTitle.text!
        postObjc.desc = TopicDesc.text!
        postObjc.date = dateItem!
        postObjc.source_name = PublicationName.text!
        postObjc.image =  TopicImage.sd_imageURL!.absoluteString
        
        let predicate = realmObjc.objects(PostObject.self).filter(NSPredicate(format:"image = %@",TopicImage.sd_imageURL!.absoluteString))

        print(predicate.count)
        if predicate.isEmpty{
            try! realmObjc.write{
                realmObjc.add(postObjc)
            }
            savedLbl.text = "Saved"
        }else{
            try! realmObjc.write{
                realmObjc.delete(predicate)
            }
            savedLbl.text = "Removed"
        }
        
        self.addSubview(savedLbl)
        savedLbl.isUserInteractionEnabled = false
        savedLbl.widthAnchor.constraint(equalToConstant: 55).isActive = true
        savedLbl.trailingAnchor.constraint(equalTo: postBtn.leadingAnchor, constant: -4).isActive = true
        savedLbl.centerYAnchor.constraint(equalTo: postBtn.centerYAnchor).isActive = true
        
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.savedLbl.alpha = 1
        } completion: { (_) in
        }

        DispatchQueue.main.asyncAfter(deadline: .now()+1.8) {
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut) {
                self.savedLbl.alpha = 0
            } completion: { (_) in
                self.savedLbl.isUserInteractionEnabled = true
                self.savedLbl.removeFromSuperview()
            }
        }



    }
    @objc func SendPostSelected(){
        newPostDelegate?.PostInteraction(btnItem: 1,image: nil, url: "Test", title: TopicTitle.text, description: TopicDesc.text!, date: dateItem, sourceName: PublicationName.text, imageURL: TopicImage.sd_imageURL?.absoluteString)
    }
    @objc func SharePostSelected(){
        print("Done")
        newPostDelegate?.PostInteraction(btnItem: 2 ,image: nil, url: urlItem, title: nil, description: "", date: "", sourceName: "", imageURL:"")
    }

//    func CleanImage() ->UIImage{
//
//        instagramStoriesBtn.removeFromSuperview()
//        instagramStoriesLabel.removeFromSuperview()
//        postBtn.removeFromSuperview()
//        sendBtn.removeFromSuperview()
//        PostOptionsButton.removeFromSuperview()
//
//        postBtnTitle.removeFromSuperview()
//        sendBtnTitle.removeFromSuperview()
//        PostOptionsButtonTitle.removeFromSuperview()
//
//        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
//            self.constraintContainer()
//        }
//        let renderer = UIGraphicsImageRenderer(size: mainViewCard.bounds.size)
//        let image = renderer.image { ctx in
//            mainViewCard.drawHierarchy(in: mainViewCard.bounds, afterScreenUpdates: true)
//        }
//        return image
//    }
    
    @objc func instagramBtnSelected(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy, EEEE MMM d h:mm a"
        let date = dateFormatter.date(from: dateItem!)!.timeAgoDisplay()
        newPostDelegate?.PostInteraction(btnItem: 3,image: TopicImage.image, url: "Test", title: TopicTitle.text, description: TopicDesc.text!, date: date, sourceName: PublicationName.text, imageURL: TopicImage.sd_imageURL?.absoluteString)

//        instagramStoriesBtn.removeFromSuperview()
//        instagramStoriesLabel.removeFromSuperview()
//        postBtn.removeFromSuperview()
//        sendBtn.removeFromSuperview()
//        PostOptionsButton.removeFromSuperview()
//
//        postBtnTitle.removeFromSuperview()
//        sendBtnTitle.removeFromSuperview()
//        PostOptionsButtonTitle.removeFromSuperview()
//
//        let queLabel = UILabel()
//        queLabel.attributedText = NSAttributedString(string: "@Que", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .semibold)])
//        queLabel.translatesAutoresizingMaskIntoConstraints = false
//        mainViewCard.addSubview(queLabel)
//        queLabel.bottomAnchor.constraint(equalTo: mainViewCard.bottomAnchor, constant: -12).isActive = true
//        queLabel.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor, constant: 12).isActive = true
//
//
//            let renderer = UIGraphicsImageRenderer(size: mainViewCard.bounds.size)
//            let image = renderer.image { ctx in
//                mainViewCard.drawHierarchy(in: mainViewCard.bounds, afterScreenUpdates: true)
//            }
//
//            if let storiesUrl = URL(string: "instagram-stories://share"){
//                if UIApplication.shared.canOpenURL(storiesUrl) {
//                    guard let pngImage = image.pngData() else {return}
//                    let pastboardItems: [String: Any] = [
//                        "com.instagram.sharedSticker.stickerImage": pngImage,
////                        "com.instagram.sharedSticker.backgroundTopColor": "#000000",
////                        "com.instagram.sharedSticker.backgroundBottomColor": "#000000"
////                        "com.instagram.sharedSticker.backgroundBottomColor": "#ff5a60"
//                    ]
//                    let pastboardOptions = [
//                        UIPasteboard.OptionsKey.expirationDate: Date().advanced(by: 300)
//                    ]
//
//                    UIPasteboard.general.setItems([pastboardItems], options: pastboardOptions)
//                    UIApplication.shared.open(storiesUrl, options: [:], completionHandler: nil)
//                }else{
//                    print("User doesn't have instagram")
//                }
//            }
//        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
//            queLabel.removeFromSuperview()
//            self.constraintContainer()
//        }
//
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}































class ViewController: UIViewController {


    var chatText = ["Something really cool", "Are you in the next room yet🤩", "This is pretty cool right? I mean this is the only person that can do something like this or is that just me", "This is just another test", "😈😈😈Do you think that there is enough text to try this?", "He has to be the coolest artist in the world at the moment", "🤩🤩🤩🤩🤩🤩🤩", "😋😋😋"]
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = .white

//        updateNews()
        

        constraintContainer()

        
//        let headers = [
//            "x-rapidapi-key": "46289005e3mshe96d5a666f9cdf5p1aa3c3jsn4df095e96835",
//            "x-rapidapi-host": "microsoft-azure-bing-news-search-v1.p.rapidapi.com"
//        ]
//
//
//        let request = NSMutableURLRequest(url: NSURL(string: "https://microsoft-azure-bing-news-search-v1.p.rapidapi.com/")! as URL,
//                                                cachePolicy: .useProtocolCachePolicy,
//                                            timeoutInterval: 10.0)
//        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = headers
//
//
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//            if (error != nil) {
//                print(error)
//            }
//
//        })
//
//        dataTask.resume()
//
//
//
        
        
        
        
        
        
        
    }
    
    func updateNews(){
        
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { (Timer) in
            if self.chatText.count == 200{
                self.chatText.removeFirst()
            }
            self.chatText.append(self.chatText.randomElement()!)
            self.chatCollectionView.reloadData()
            let item = self.chatCollectionView.numberOfItems(inSection: 0)-1
            let lastItemIndex = IndexPath(item: item, section: 0)
            self.chatCollectionView.scrollToItem(at: lastItemIndex, at: .bottom, animated: false)
        }
        
        Timer.scheduledTimer(withTimeInterval: 15, repeats: true) { (Timer) in
            
        }
    }
    
    
    fileprivate let NewsView: UIView = {
       let view = UIView()
        view.backgroundColor = .white

        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        view.layer.shadowRadius = 5.0
        view.layer.shadowOpacity = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    fileprivate let storyCollectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 08, bottom: 12, right: 0)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        

        
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(storyCell.self, forCellWithReuseIdentifier: "storyCellID")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    

    fileprivate let chatCollectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0)
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        

        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(chatCell.self, forCellWithReuseIdentifier: "chatCellID")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    

    
    
//    INSIDE NEWSITEM
    fileprivate let publicationImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "wpImage")
        imageView.layer.cornerRadius = 35/2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate let publicationName: CustomLabel = {
        let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "Washington Post", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .semibold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let PostImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "PostExample")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 35/2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate let TitleBlackFade: UIImageView = {
            let view = UIImageView()
            view.image = UIImage(named: "TopGradientImage")
            view.alpha = 0.5
            view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            view.clipsToBounds = true
            view.layer.cornerRadius = 16
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    
    fileprivate let DetailsBlackFade: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "GradientImage")

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    fileprivate let PostTitleLabel: CustomLabel = {
        let label = CustomLabel()
        label.numberOfLines = 0
        
        label.attributedText = NSAttributedString(string: "The Weeknd to headline Super Bowl halftime show", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .semibold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let DescriptionLabel: CustomLabel = {
        let label = CustomLabel()
        label.numberOfLines = 0
        label.attributedText = NSAttributedString(string: "The Weeknd, the Canadian pop star, has been chosen to play the halftime show at the Super Bowl in Tampa, Fla., in February, a performance that may face challenges because of pandemic restrictions. The Weeknd has had five No. 1 hits, including “Can’t Feel My Face,” produced in part by the Swedish pop mastermind Max Martin, and “Starboy,” created with Daft Punk, the French dance-rock duo.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let dateLabel: CustomLabel = {
        let label = CustomLabel()
        label.numberOfLines = 0
        label.attributedText = NSAttributedString(string: "2 Hours", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .regular)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    fileprivate let postNavigationView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let postTextViewContainer: UIView = {
        let view = UIView()
//        view.backgroundColor = LightBlackColor
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1.5
        view.isUserInteractionEnabled = true
        view.layer.cornerRadius = 35/2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let postTextView: CustomLabel = {
        let textView = CustomLabel()
        textView.backgroundColor = .clear
        textView.isUserInteractionEnabled = true
        
        textView.attributedText = NSAttributedString(string: "Say something...", attributes: [NSAttributedString.Key.foregroundColor:UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)])
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    fileprivate let postButton: CustomLabel = {
       let button = CustomLabel()
        button.layer.cornerRadius = 35/2
        button.isUserInteractionEnabled = true
        button.clipsToBounds = true
        button.backgroundColor = BlackBackgroundColor
        button.textAlignment = .center
        button.attributedText = NSAttributedString(string: "Send", attributes: [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .bold)])
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    

    
    fileprivate func constraintContainer(){
        storyCollectionView.delegate = self
        storyCollectionView.dataSource = self
        
        chatCollectionView.delegate = self
        chatCollectionView.dataSource = self
        
        
        view.addSubview(storyCollectionView)
        view.addSubview(DetailsBlackFade)



        view.addSubview(chatCollectionView)
        
        view.addSubview(postNavigationView)
            postNavigationView.addSubview(postTextViewContainer)
            postTextViewContainer.addSubview(postTextView)
            postNavigationView.addSubview(postButton)
        NSLayoutConstraint.activate([
            storyCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            storyCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            storyCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            storyCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.75),


            DetailsBlackFade.heightAnchor.constraint(equalTo: chatCollectionView.heightAnchor, constant: 80),
            DetailsBlackFade.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -8),
            DetailsBlackFade.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 8),
            DetailsBlackFade.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            
            chatCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.30),
            chatCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            chatCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            chatCollectionView.bottomAnchor.constraint(equalTo: postNavigationView.topAnchor, constant: -8),
            
            
            
            postNavigationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            postNavigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postNavigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            postNavigationView.heightAnchor.constraint(equalToConstant: 80),
            
            postTextViewContainer.trailingAnchor.constraint(equalTo: postButton.leadingAnchor, constant: -8),
            postTextViewContainer.leadingAnchor.constraint(equalTo: postNavigationView.leadingAnchor, constant: 8),
            postTextViewContainer.topAnchor.constraint(equalTo: postNavigationView.topAnchor, constant: 8),
            postTextViewContainer.heightAnchor.constraint(equalToConstant: 35),
            
            postButton.topAnchor.constraint(equalTo: postNavigationView.topAnchor, constant: 8),
            postButton.trailingAnchor.constraint(equalTo:postNavigationView.trailingAnchor, constant: -4),
            postButton.widthAnchor.constraint(equalToConstant: 70),
            postButton.heightAnchor.constraint(equalToConstant: 35),
            

            postTextView.centerYAnchor.constraint(equalTo: postTextViewContainer.centerYAnchor),
            postTextView.heightAnchor.constraint(equalToConstant: 35),
            postTextView.leadingAnchor.constraint(equalTo: postTextViewContainer.leadingAnchor, constant: 8),
            postTextView.trailingAnchor.constraint(equalTo: postTextViewContainer.trailingAnchor, constant: -8),
  
            
        ])
    }

}



extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == chatCollectionView{
            return chatText.count
        }else{
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == chatCollectionView{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chatCellID", for: indexPath) as! chatCell
        cell.userComment.text = chatText[indexPath.row]
        print(indexPath.row)
        
        if chatText.count == indexPath.row{
//                        let item = self.chatCollectionView.numberOfItems(inSection: 0)-1
//                        print(item)
//                        let lastItemIndex = IndexPath(item: item, section: 0)
//                        self.chatCollectionView.scrollToItem(at: lastItemIndex, at: .bottom, animated: false)
        }
            return cell
        }
        
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "storyCellID", for: indexPath) as! storyCell
            
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == chatCollectionView{
            let size = CGSize(width: collectionView.frame.width, height: 60)
            return size
        }
        else{
            let size = CGSize(width: view.frame.width, height: view.frame.height*0.70)
            return size
        }
    }
    
    
}







class storyCell: UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame:frame)

        constraintContainer()
    }
    
    fileprivate let mainView: CustomView = {
       let view = CustomView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let publicationImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "wpImage")
        imageView.layer.cornerRadius = 35/2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate let publicationName: CustomLabel = {
        let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "Washington Post", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .semibold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let PostImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "PostExample")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 35/2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate let TitleBlackFade: UIImageView = {
            let view = UIImageView()
            view.image = UIImage(named: "TopGradientImage")
            view.alpha = 0.5
            view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            view.clipsToBounds = true
            view.layer.cornerRadius = 16
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    
    fileprivate let DetailsBlackFade: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "GradientImage")

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    fileprivate let PostTitleLabel: CustomLabel = {
        let label = CustomLabel()
        label.numberOfLines = 0
        
        label.attributedText = NSAttributedString(string: "The Weeknd to headline Super Bowl halftime show", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .semibold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let DescriptionLabel: CustomLabel = {
        let label = CustomLabel()
        label.numberOfLines = 0
        label.attributedText = NSAttributedString(string: "The Weeknd, the Canadian pop star, has been chosen to play the halftime show at the Super Bowl in Tampa, Fla., in February, a performance that may face challenges because of pandemic restrictions. The Weeknd has had five No. 1 hits, including “Can’t Feel My Face,” produced in part by the Swedish pop mastermind Max Martin, and “Starboy,” created with Daft Punk, the French dance-rock duo.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let dateLabel: CustomLabel = {
        let label = CustomLabel()
        label.numberOfLines = 0
        label.attributedText = NSAttributedString(string: "2 Hours", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .regular)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    fileprivate func constraintContainer(){
        self.addSubview(mainView)
            mainView.addSubview(PostImageView)
            mainView.addSubview(TitleBlackFade)
                mainView.addSubview(publicationImage)
                mainView.addSubview(publicationName)
                mainView.addSubview(PostTitleLabel)
                mainView.addSubview(dateLabel)
                mainView.addSubview(PostTitleLabel)


    

    NSLayoutConstraint.activate([

        mainView.topAnchor.constraint(equalTo: self.topAnchor),
        mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
        mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
        mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        
        
        TitleBlackFade.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.30),
        TitleBlackFade.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
        TitleBlackFade.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
        TitleBlackFade.topAnchor.constraint(equalTo: mainView.topAnchor),
        
            PostImageView.topAnchor.constraint(equalTo: mainView.topAnchor),
            PostImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            PostImageView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            PostImageView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
        
            publicationImage.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 8),
            publicationImage.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8),
            publicationImage.widthAnchor.constraint(equalToConstant: 35),
            publicationImage.heightAnchor.constraint(equalToConstant: 35),
            
            publicationName.leadingAnchor.constraint(equalTo: publicationImage.trailingAnchor, constant: 4),
            publicationName.centerYAnchor.constraint(equalTo: publicationImage.centerYAnchor),
            publicationName.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -8),
            
            dateLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            dateLabel.centerYAnchor.constraint(equalTo: publicationName.centerYAnchor),
            dateLabel.widthAnchor.constraint(equalToConstant: dateLabel.intrinsicContentSize.width),
        
        
            PostTitleLabel.topAnchor.constraint(equalTo: publicationName.bottomAnchor, constant: 16),
            PostTitleLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8),
            PostTitleLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -0),
    ])
}
    
    
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}









class chatCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame:frame)
        constraintContainer()
    }
    
    fileprivate let userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ProfileImage1")
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate let userName: CustomLabel = {
        let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "Elon Musk", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .semibold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let userComment: CustomLabel = {
        let label = CustomLabel()
        label.numberOfLines = 0
        label.attributedText = NSAttributedString(string: "I can't wait till the new version of the tesla roadster is out for production!", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .regular)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate func constraintContainer(){
        self.addSubview(userImage)
        self.addSubview(userName)
        self.addSubview(userComment)
        
        NSLayoutConstraint.activate([
            userImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            userImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            userImage.widthAnchor.constraint(equalToConstant: 30),
            userImage.heightAnchor.constraint(equalToConstant: 30),
            
            userName.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 4),
            userName.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            userName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            userComment.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 4),
            userComment.topAnchor.constraint(equalTo: userName.bottomAnchor),
            userComment.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}






