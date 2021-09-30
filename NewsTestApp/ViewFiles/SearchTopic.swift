//
//  SearchTopic.swift
//  NewsTestApp
//
//  Created by Caleb Mesfien on 12/4/20.
//

import UIKit
import SWXMLHash
import OpenGraph
import RealmSwift
import SafariServices
import Lottie

class SearchResultCollection: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PostCollectionViewDel, blackViewProtocol {
    let realmObjc = try! Realm()
    func changeBlackView() {
        self.blackWindow.alpha = 0
    }
    
    var searchedTopic = [ArticleItem](){
        didSet{
            if searchedTopic.count % 5 == 0{
//                searchedTopic = searchedTopic.sorted(by: { $0.date .compare($1.date) == .orderedDescending })
            DispatchQueue.main.async {
                    self.topicCollectionView.reloadSections(IndexSet(integer: 0))
                
//                let indexPath = IndexPath(row: self.searchedTopic.count-1, section: 0)
//                self.topicCollectionView.performBatchUpdates({
//                    UIView.animate(withDuration: 0.3) {
//                        self.topicCollectionView.insertItems(at: [indexPath])
//                    }
//                }, completion: nil)
//                self.topicCollectionView.reloadData()
//                self.topicCollectionView.collectionViewLayout.invalidateLayout()
//                self.topicCollectionView.layoutSubviews()
            }
        }
        }
    }
    
    
    func openView(url: String) {
//        let vc = ArticleInView()
//        vc.url = URL(string: url)
//        vc.hidesBottomBarWhenPushed = true
//        navigationController?.pushViewController(vc, animated: true)
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
    
    
    let blackWindow = UIView()
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
    

    
    func fetchImage(_ q: String){
        var url: URL?
        let Topics = ["WORLD", "NATION", "BUSINESS", "TECHNOLOGY", "ENTERTAINMENT", "SPORTS", "SCIENCE", "HEALTH"]
        if Topics.contains(where: {$0 == q.uppercased()}){
            url = URL(string: "https://news.google.com/news/rss/headlines/section/topic/\(q.uppercased())")
        }else if q == "TRENDING"{
            url = URL(string: "https://news.google.com/rss?hl=en-US&gl=US&ceid=US:en")
        }else{
            url = URL(string: "https://news.google.com/rss/search?q=\(q.replacingOccurrences(of: " ", with: "%20"))&hl=en-US&gl=US&ceid=US:en")
        }
        
//        guard let url = URL(string: "https://news.google.com/rss/search?q=\(q)&hl=en-US&gl=US") else{print("First"); return}
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
          
        guard let str = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) else{print("Second");return}

          let xml = SWXMLHash.parse(str as String)
          
           let count = xml["rss"]["channel"]["item"].all.count
          print(count, "Articles")

        for i in 0...count-1 {
//          guard let artTitle = xml["rss"]["channel"]["item"][i]["title"].element?.text else{
//              print("Nil Title")
//              return}
            
          guard let artURL = xml["rss"]["channel"]["item"][i]["link"].element?.text else{
              print("Nil link")
              return}
            
          guard let artDate = xml["rss"]["channel"]["item"][i]["pubDate"].element?.text else{
              print("Nil date")
              return}
            
            guard let artProvider = xml["rss"]["channel"]["item"][i]["source"].element?.text else{
                print("Nil provider")
                return}
          
          guard let url = URL(string: artURL) else {print("URL is Broken!"); return}
          OpenGraph.fetch(url: url) { result in
              switch result {
              case .success(let og):
                guard let artTitle = og[.title] else{
                    return}
                  guard let imageURL = og[.image] else{
                    print("Image not Available")
                    return}
                  guard let descText = og[.description] else{
                    print("Description not Available")
                    return}
                  
                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "E, dd MMM yyyy HH:mm:ss zzz"

                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy, EEEE MMM d h:mm a"

                let date: NSDate? = dateFormatterGet.date(from: (artDate)) as NSDate?
                let newDate = dateFormatter.string(from: date! as Date)
                let item = ArticleItem(url: artURL.htmlDecoded(), title: artTitle.htmlDecoded(), desc: descText.htmlDecoded(), date: newDate, source_name: artProvider.htmlDecoded(), image: imageURL)
                self.searchedTopic.append(item)

                

              case .failure(let error):
                  print("Error: ",error)
              }
          }
          }


        }
    task.resume()
    }
    
    var topicTitle: String?{
        didSet{
            let item = topicTitle!.uppercased()
            title = item
            fetchImage(item.replacingOccurrences(of: " ", with: "%20"))
            showSpinner(onView: view.self)
        }
    }
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = BlackBackgroundColor
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: subViewColor]
//        navigationController?.navigationBar.tintColor = subViewColor
//        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: subViewColor]
        
        view.addSubview(LoadView)
        LoadView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        LoadView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        LoadView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        LoadView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
//        DispatchQueue.main.asyncAfter(deadline: .now()+1.8, execute: {
        let timer = Timer.scheduledTimer(withTimeInterval: 0.8, repeats: true) { (Timer) in
            if self.searchedTopic.count >= 10{
                self.LoadView.removeFromSuperview()
                self.ConstraintContainer()
                Timer.invalidate()
            }
        }
        timer.fire()
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = subViewColor
        navigationController?.navigationBar.barTintColor = BlackBackgroundColor
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: subViewColor]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: subViewColor]
        if subViewColor == .white{
            UIApplication.shared.statusBarStyle = .lightContent
        }else{
            UIApplication.shared.statusBarStyle = .darkContent
        }

    }
    lazy var LoadView: AnimationView = {
       let animationView = AnimationView()
        animationView.animation = Animation.named("LoadingAnimation")
        animationView.animationSpeed = 1.5
        animationView.play()
        animationView.loopMode = .loop

        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    
    lazy var topicCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = BlackBackgroundColor
        collectionView.bounces = true
        collectionView.showsVerticalScrollIndicator = false

        collectionView.register(SearchResultCollectionCell.self, forCellWithReuseIdentifier: "SearchResultCollectionCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var subBtn: UIButton = {
       let btn = UIButton()
        btn.backgroundColor = TealConstantColor
        let item = realmObjc.objects(SubscribedTopics.self).filter(NSPredicate(format: "title == %@", topicTitle!.uppercased()))
        if item.count == 0{
            btn.setAttributedTitle(NSAttributedString(string: "Subscribe", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold)]), for: .normal)
        }else{
            btn.setAttributedTitle(NSAttributedString(string: "Unsubscribe", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold)]), for: .normal)
        }
        btn.titleLabel?.textAlignment = .center
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 2
        btn.addTarget(self, action: #selector(subSelected), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
//    lazy var returnBtn: UIButton = {
//       let btn = UIButton()
//        if realmObjc.objects(DarkMode.self)[0].isDarkMode{
//            btn.setImage(UIImage(named: "whiteReturn"), for: .normal)
//        }else{
//            btn.setImage(UIImage(named: "ReturnArrow"), for: .normal)
//
//        }
//        btn.addTarget(self, action: #selector(ReturnButtonSelected), for: .touchUpInside)
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        return btn
//    }()
//
//    lazy var titleLabel: CustomLabel = {
//       let lbl = CustomLabel()
//        lbl.text = topicTitle?.uppercased()
//        lbl.font = .systemFont(ofSize: 16, weight: .semibold)
//        lbl.textColor = subViewColor
//        lbl.translatesAutoresizingMaskIntoConstraints = false
//        return lbl
//    }()
//
    func ConstraintContainer(){
//        view.addSubview(returnBtn)
//        view.addSubview(titleLabel)
        view.addSubview(topicCollectionView)
        view.addSubview(subBtn)
        NSLayoutConstraint.activate([
            subBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 6),
            subBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            subBtn.heightAnchor.constraint(equalToConstant: subBtn.intrinsicContentSize.height),
//            subBtn.widthAnchor.constraint(equalToConstant: subBtn.intrinsicContentSize.width+16),
            subBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            
            topicCollectionView.topAnchor.constraint(equalTo: subBtn.bottomAnchor, constant: 6),
            topicCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topicCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topicCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
//            returnBtn.centerYAnchor.constraint(equalTo: subBtn.centerYAnchor),
//            returnBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
//            returnBtn.heightAnchor.constraint(equalToConstant: 25),
//            returnBtn.widthAnchor.constraint(equalTo: returnBtn.heightAnchor),
//
//            titleLabel.centerYAnchor.constraint(equalTo: returnBtn.centerYAnchor),
//            titleLabel.leadingAnchor.constraint(equalTo: returnBtn.trailingAnchor, constant: 4),
//            titleLabel.trailingAnchor.constraint(equalTo: subBtn.trailingAnchor, constant: -8),
            

        ])
    }
    func addSub(_ Title: String){
        
    }
    @objc func ReturnButtonSelected(){
        navigationController?.popViewController(animated: true)
    }
    @objc func subSelected(){
//        let last = realmObjc.objects(SubscribedTopics.self)
//        try! realmObjc.write{
//            last.forEach { (SubscribedTopic) in
//                realmObjc.delete(SubscribedTopic)
//            }
//        }
//        let item = realmObjc.objects(SubscribedTopics.self).filter(NSPredicate(format: "title == %@", title!))
//        if item.count == 0{
        if subBtn.titleLabel?.text == "Subscribe"{
            print("Done")
//            db.collection("user").document(realmObjc.objects(userObject.self)[0].Id).collection("subscriptions").document().setData(["title":topicTitle!.uppercased()])
            let obj = SubscribedTopics()
            obj.title = topicTitle!.uppercased()
            obj.topicTitle = searchedTopic[0].title
            obj.topicImgURL = searchedTopic[0].image
            obj.source_name = searchedTopic[0].source_name

            try! realmObjc.write{
                realmObjc.add(obj)
            }
            subBtn.setAttributedTitle(NSAttributedString(string: "Unsubscribe", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold)]), for: .normal)
        }else{
            let item = realmObjc.objects(SubscribedTopics.self).filter(NSPredicate(format: "title == %@", topicTitle!.uppercased()))
            try! realmObjc.write{
                realmObjc.delete(item)
            }
//            db.collection("user").document(realmObjc.objects(userObject.self)[0].Id).collection("subscriptions").whereField("title", isEqualTo: topicTitle!.uppercased()).getDocuments { (QuerySnapshot, Error) in
//                if QuerySnapshot?.count != 0{
//                    db.collection("user").document(self.realmObjc.objects(userObject.self)[0].Id).collection("subscriptions").document((QuerySnapshot?.documents.first?.documentID)!).delete()
//                }
//                }
            

            print("Found")
            navigationController?.popViewController(animated: true)

        }

        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchedTopic.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchResultCollectionCell", for: indexPath) as! SearchResultCollectionCell
        cell.tag = indexPath.row
        cell.newPostDelegate = self
        
        let item = indexPath.row
        guard URL(string:searchedTopic[item].image) != nil else {
                DispatchQueue.main.async {
                    self.searchedTopic.remove(at: item)
                    collectionView.deleteItems(at: [NSIndexPath(row: item, section: 0) as IndexPath])
                    self.view.layoutSubviews()
                    self.view.layoutIfNeeded()
                }

            return cell
        }




        
//        if cell.tag == indexPath.row{
        if searchedTopic[indexPath.row].source_name == "Bleacher Report"{
            cell.TopicImage.image = UIImage(named: "BLEACHERREPORTIMG")
        }else{
            cell.TopicImage.sd_setImage(with:URL(string: searchedTopic[indexPath.row].image), placeholderImage: UIImage(named: "BlankBackground"))
        }
            cell.TopicTitle.text = searchedTopic[indexPath.row].title.htmlDecoded()
            cell.TopicDesc.text = searchedTopic[indexPath.row].desc.htmlDecoded()
            cell.PublicationName.text = searchedTopic[indexPath.row].source_name
            
            cell.urlItem = searchedTopic[indexPath.row].url
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy, EEEE MMM d h:mm a"
            

            if searchedTopic[indexPath.row].date == ""{
                    cell.DateOfTopic.text = "-"
            }else{
                let date = dateFormatter.date(from: searchedTopic[indexPath.row].date)?.timeAgoDisplay()
                cell.dateItem = searchedTopic[indexPath.row].date
                cell.DateOfTopic.text = date
            }
                
            cell.backgroundColor = BlackBackgroundColor

    
            return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        return size
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        openView(url: searchedTopic[indexPath.row].url)
    }
    
    
}

//          MARK: FORYOUFEEDCELL
class SearchResultCollectionCell: UICollectionViewCell {
    let realmObjc = try! Realm()
    var newPostDelegate:PostCollectionViewDel?
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
        label.numberOfLines = 3
//        label.adjustsFontSizeToFitWidth = true
        label.attributedText = NSAttributedString(string: "-", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .bold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let TopicDesc: CustomLabel = {
        let label = CustomLabel()
        label.numberOfLines = 4
        
//        UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        label.attributedText = NSAttributedString(string: "-", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    fileprivate let PublicationName: CustomLabel = {
        let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "-", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    fileprivate let DoteSeperator: CustomLabel = {
        let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "•", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    fileprivate let DateOfTopic: CustomLabel = {
        let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "-", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
//    INTERACTIVE BUTTONS
    
    fileprivate lazy var instagramStoriesBtn: UIButton = {
       let imageView = UIButton()
//        if realmObjc.objects(DarkMode.self)[0].isDarkMode{
            imageView.setImage(UIImage(named: "instagramStories"), for: .normal)
//        }else{
//            imageView.setImage(UIImage(named: "blackInstagramStories"), for: .normal)
//
//        }
        imageView.addTarget(self, action: #selector(instagramBtnSelected), for: .touchUpInside)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate let instagramStoriesLabel: CustomLabel  = {
       let label = CustomLabel()
        label.numberOfLines = 2
        label.attributedText = NSAttributedString(string: "Add to Instagram Story", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10, weight: .semibold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    fileprivate lazy var PostOptionsButton: UIButton = {
       let btn = UIButton()
//        if realmObjc.objects(DarkMode.self)[0].isDarkMode{
            btn.setImage(UIImage(named: "Share"), for: .normal)
//        }else{
//            btn.setImage(UIImage(named: "blackShare"), for: .normal)
//        }
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
//        if realmObjc.objects(DarkMode.self)[0].isDarkMode{
            btn.setImage(UIImage(named: "newPost"), for: .normal)
//        }else{
//            btn.setImage(UIImage(named: "blackNewPost"), for: .normal)
//        }
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
//        if realmObjc.objects(DarkMode.self)[0].isDarkMode{
            btn.setImage(UIImage(named: "SendInApp"), for: .normal)
//        }else{
//            btn.setImage(UIImage(named: "blackSendInApp"), for: .normal)
//        }
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    fileprivate let sendBtnTitle: CustomLabel  = {
       let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "Send", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10, weight: .semibold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let savedLbl: CustomLabel = {
        let label = CustomLabel()
        label.alpha = 0
        label.attributedText = NSAttributedString(string: "Saved", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .semibold)])
        label.textColor = .white
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let ActivityView: CustomView = {
       let view = CustomView()
//        view.clipsToBounds = true
//        view.layer.cornerRadius = 5
//        view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    var AccountViewControllerItem: FeedViewController?

    func constraintContainer(){
        
        self.addSubview(mainViewCard)
        mainViewCard.addSubview(TopicImage)
        mainViewCard.addSubview(DimTopicLayer)

            mainViewCard.addSubview(TopicTitle)
            mainViewCard.addSubview(TopicDesc)
        
            mainViewCard.addSubview(PublicationName)
            mainViewCard.addSubview(DoteSeperator)
            mainViewCard.addSubview(DateOfTopic)
        
        mainViewCard.addSubview(ActivityView)

        
        ActivityView.addSubview(PostOptionsButton)
        ActivityView.addSubview(postBtn)
        ActivityView.addSubview(sendBtn)
        ActivityView.addSubview(instagramStoriesBtn)
        ActivityView.addSubview(instagramStoriesLabel)
        
        

        
        
        NSLayoutConstraint.activate([
//            mainViewCard.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 4),
//            mainViewCard.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
//            mainViewCard.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
//            mainViewCard.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -32),
//
//
//
//
////            TopicView.topAnchor.constraint(equalTo: TopicImage.bottomAnchor, constant: -8),
////            TopicView.heightAnchor.constraint(equalToConstant: TopicView.intrinsicContentSize.height),
////            TopicView.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor),
////            TopicView.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor),
////            TopicView.bottomAnchor.constraint(equalTo: instagramStoriesBtn.topAnchor, constant: -16),
//
//            TopicImage.topAnchor.constraint(equalTo: self.topAnchor, constant: -12),
//            TopicImage.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor),
//            TopicImage.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor),
//            TopicImage.heightAnchor.constraint(equalTo: mainViewCard.heightAnchor, multiplier: 0.6),
////            TopicImage.bottomAnchor.constraint(equalTo: TopicTitle.topAnchor, constant: -8),
//
//
//            TopicTitle.topAnchor.constraint(equalTo: TopicImage.bottomAnchor, constant: 8),
//            TopicTitle.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor, constant: 16),
//            TopicTitle.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor, constant: -8),
//
//            TopicDesc.topAnchor.constraint(equalTo:TopicTitle.bottomAnchor ,constant: 8),
//            TopicDesc.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor, constant: 16),
//            TopicDesc.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor, constant: -16),
////            TopicDesc.heightAnchor.constraint(equalToConstant: TopicDesc.int)
//
//            PublicationName.topAnchor.constraint(equalTo: TopicDesc.bottomAnchor, constant: 8),
//            PublicationName.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor, constant: 16),
//            PublicationName.heightAnchor.constraint(equalToConstant: PublicationName.intrinsicContentSize.height),
//
//            DoteSeperator.topAnchor.constraint(equalTo: TopicDesc.bottomAnchor, constant: 8),
//            DoteSeperator.leadingAnchor.constraint(equalTo: PublicationName.trailingAnchor, constant: 4),
//            DoteSeperator.heightAnchor.constraint(equalToConstant: DoteSeperator.intrinsicContentSize.height),
//
//            DateOfTopic.topAnchor.constraint(equalTo: TopicDesc.bottomAnchor, constant: 8),
//            DateOfTopic.leadingAnchor.constraint(equalTo: DoteSeperator.leadingAnchor, constant: 8),
////            DateOfTopic.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor, constant: -4),
//            DateOfTopic.heightAnchor.constraint(equalToConstant: DateOfTopic.intrinsicContentSize.height),
//
//
//
////            LIKE BUTTON
//            postBtn.trailingAnchor.constraint(equalTo: sendBtn.leadingAnchor, constant: -14),
//            postBtn.centerYAnchor.constraint(equalTo: instagramStoriesBtn.centerYAnchor),
//            postBtn.heightAnchor.constraint(equalToConstant: 30),
//            postBtn.widthAnchor.constraint(equalToConstant: 30),
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
//            PostOptionsButton.heightAnchor.constraint(equalToConstant: 34),
//            PostOptionsButton.widthAnchor.constraint(equalToConstant: 34),
////            PostOptionsButtonTitle.topAnchor.constraint(equalTo: PostOptionsButton.bottomAnchor, constant: 2),
////            PostOptionsButtonTitle.centerXAnchor.constraint(equalTo: PostOptionsButton.centerXAnchor),
//
//
////            instagramStoriesBtn.bottomAnchor.constraint(equalTo: mainViewCard.bottomAnchor, constant: -16),
//            instagramStoriesBtn.centerYAnchor.constraint(equalTo: ActivityView.centerYAnchor),
//            instagramStoriesBtn.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor, constant: 16),
//            instagramStoriesBtn.heightAnchor.constraint(equalToConstant: 30),
//            instagramStoriesBtn.widthAnchor.constraint(equalToConstant: 30),
//
//            instagramStoriesLabel.leadingAnchor.constraint(equalTo: instagramStoriesBtn.trailingAnchor, constant: 8),
//            instagramStoriesLabel.centerYAnchor.constraint(equalTo: instagramStoriesBtn.centerYAnchor),
//            instagramStoriesLabel.widthAnchor.constraint(equalToConstant: 85),
//
//            ActivityView.bottomAnchor.constraint(equalTo: mainViewCard.bottomAnchor, constant: -14),
//            ActivityView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            ActivityView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            ActivityView.heightAnchor.constraint(equalToConstant: 50)
            
            
            
            
            
            
            
            
            
            
            
            
            mainViewCard.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 4),
            mainViewCard.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            mainViewCard.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            mainViewCard.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24),




//            TopicView.topAnchor.constraint(equalTo: mainViewCard.topAnchor, constant: 8),
//            TopicView.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor),
//            TopicView.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor),
//            TopicView.bottomAnchor.constraint(equalTo: mainViewCard.bottomAnchor),

            TopicImage.topAnchor.constraint(equalTo: self.topAnchor, constant: -12),
            TopicImage.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor),
            TopicImage.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor),
            TopicImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 12),

            DimTopicLayer.topAnchor.constraint(equalTo: mainViewCard.topAnchor),
            DimTopicLayer.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor),
            DimTopicLayer.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor),
            DimTopicLayer.bottomAnchor.constraint(equalTo: mainViewCard.bottomAnchor),

            TopicTitle.topAnchor.constraint(equalTo: mainViewCard.topAnchor, constant: 12),
            TopicTitle.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor, constant: 16),
            TopicTitle.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor, constant: -8),

            TopicDesc.topAnchor.constraint(equalTo:TopicTitle.bottomAnchor ,constant: 8),
            TopicDesc.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor, constant: 16),
            TopicDesc.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor, constant: -16),

            PublicationName.topAnchor.constraint(equalTo: TopicDesc.bottomAnchor, constant: 8),
            PublicationName.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor, constant: 16),

            DoteSeperator.topAnchor.constraint(equalTo: TopicDesc.bottomAnchor, constant: 8),
            DoteSeperator.leadingAnchor.constraint(equalTo: PublicationName.trailingAnchor, constant: 4),


            DateOfTopic.topAnchor.constraint(equalTo: TopicDesc.bottomAnchor, constant: 8),
            DateOfTopic.leadingAnchor.constraint(equalTo: DoteSeperator.leadingAnchor, constant: 8),
//            DateOfTopic.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor, constant: -4),




            postBtn.trailingAnchor.constraint(equalTo: sendBtn.leadingAnchor, constant: -14),
            postBtn.centerYAnchor.constraint(equalTo: instagramStoriesBtn.centerYAnchor),
            postBtn.heightAnchor.constraint(equalToConstant: 30),
            postBtn.widthAnchor.constraint(equalToConstant: 30),
//            postBtnTitle.topAnchor.constraint(equalTo: postBtn.bottomAnchor, constant: 2),
//            postBtnTitle.centerXAnchor.constraint(equalTo: postBtn.centerXAnchor),

            sendBtn.trailingAnchor.constraint(equalTo: PostOptionsButton.leadingAnchor, constant: -14),
            sendBtn.bottomAnchor.constraint(equalTo: instagramStoriesBtn.bottomAnchor),
            sendBtn.heightAnchor.constraint(equalToConstant: 30),
            sendBtn.widthAnchor.constraint(equalToConstant: 30),
//            sendBtnTitle.topAnchor.constraint(equalTo: sendBtn.bottomAnchor, constant: 2),
//            sendBtnTitle.centerXAnchor.constraint(equalTo: sendBtn.centerXAnchor),


            PostOptionsButton.centerYAnchor.constraint(equalTo: instagramStoriesBtn.centerYAnchor),
            PostOptionsButton.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor, constant: -16),
            PostOptionsButton.heightAnchor.constraint(equalToConstant: 34),
            PostOptionsButton.widthAnchor.constraint(equalToConstant: 34),
//            PostOptionsButtonTitle.topAnchor.constraint(equalTo: PostOptionsButton.bottomAnchor, constant: 2),
//            PostOptionsButtonTitle.centerXAnchor.constraint(equalTo: PostOptionsButton.centerXAnchor),


//            instagramStoriesBtn.bottomAnchor.constraint(equalTo: mainViewCard.bottomAnchor, constant: -16),
            instagramStoriesBtn.centerYAnchor.constraint(equalTo: ActivityView.centerYAnchor),
            instagramStoriesBtn.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor, constant: 16),
            instagramStoriesBtn.heightAnchor.constraint(equalToConstant: 30),
            instagramStoriesBtn.widthAnchor.constraint(equalToConstant: 30),

            instagramStoriesLabel.leadingAnchor.constraint(equalTo: instagramStoriesBtn.trailingAnchor, constant: 8),
            instagramStoriesLabel.centerYAnchor.constraint(equalTo: instagramStoriesBtn.centerYAnchor),
            instagramStoriesLabel.widthAnchor.constraint(equalToConstant: 85),

            ActivityView.bottomAnchor.constraint(equalTo: mainViewCard.bottomAnchor, constant: -14),
            ActivityView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            ActivityView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            ActivityView.heightAnchor.constraint(equalToConstant: 50)
//
            
        ])

        
    }
    
//    @objc func newPostBtnSelected(){
//        print("Done")
//        let renderer = UIGraphicsImageRenderer(size: mainViewCard.bounds.size)
//        let image = renderer.image { ctx in
//            mainViewCard.drawHierarchy(in: mainViewCard.bounds, afterScreenUpdates: true)
//        }
//        newPostDelegate?.PostInteraction(btnItem: 0,image: image, url: "Test", title: "This is a test", description: "", date: "", sourceName: "", imageURL: "")
//    }
//    @objc func SendPostSelected(){
//        print("Done")
//        let renderer = UIGraphicsImageRenderer(size: mainViewCard.bounds.size)
//        let image = renderer.image { ctx in
//            mainViewCard.drawHierarchy(in: mainViewCard.bounds, afterScreenUpdates: true)
//        }
//        newPostDelegate?.PostInteraction(btnItem: 1,image: image, url: "Test", title: "This is a test", description: "", date: "", sourceName: "", imageURL: "")
//    }
//    @objc func SharePostSelected(){
//        print("Done")
//        let renderer = UIGraphicsImageRenderer(size: mainViewCard.bounds.size)
//        let image = renderer.image { ctx in
//            mainViewCard.drawHierarchy(in: mainViewCard.bounds, afterScreenUpdates: true)
//        }
//        newPostDelegate?.PostInteraction(btnItem: 2,image: image, url: "Test", title: "This is a test", description: "", date: "", sourceName: "", imageURL: "")
//
//    }
    
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
