//
//  TrendingViewControllers.swift
//  NewsTestApp
//
//  Created by Caleb Mesfien on 11/22/20.
//

import UIKit
import RealmSwift
import SWXMLHash
import OpenGraph
import SafariServices
import Lottie
//let listOfMostSearched = [
//
//]


struct SearchResults: Decodable{
    var results: [String]?
}

struct SearchmainObject: Decodable{
    var data: SearchResults
}

//var TrendingArticles = [ArticleObjects]()
//var TechnologyArticles = [ArticleObjects]()
//var PoliticsArticles = [ArticleObjects]()
//var SportArticles = [ArticleObjects]()
//var EntertainmentArticles = [ArticleObjects]()
//var ScienceArticles = [ArticleObjects]()
//var BusinessArticles = [ArticleObjects]()




var searchResultArts = [ArticleItem]()
//      MARK: SEARCH VIEW
class TrendingSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{

    var delegate: SearchTopicCollectionProtocol?
    var listSearch = [String]()
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return listSearch.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"TrendingSearchCell" , for: indexPath) as! TrendingSearchCell
        cell.selectionStyle = .none
        cell.tag = indexPath.row
        
        if cell.tag == indexPath.row{
            if indexPath.section == 0{
                cell.title.text = textField.text?.uppercased()
            }else{
        
                cell.title.text = listSearch[indexPath.row].uppercased()
            }
        }
            return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }


    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1{
            return 30
        }else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()

        header.backgroundColor = .clear
        let title: CustomLabel = {
            let label = CustomLabel()
            label.textColor = .lightGray
            label.font = .systemFont(ofSize: 16, weight: .semibold)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
    }()


        if section == 1{
            header.addSubview(title)
            
            title.bottomAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
            title.leadingAnchor.constraint(equalTo: header.leadingAnchor,constant: 8).isActive = true
            title.text = "Suggestions"
        }
        return header
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard self.textField.text != "" else{return}

        dismiss(animated: true) {
            if indexPath.section == 0{
                self.delegate?.OpenTopic(title:self.textField.text!)
            }else{
                guard self.listSearch.isEmpty != true else{return}
                self.delegate?.OpenTopic(title:self.listSearch[indexPath.row])
            }
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BlackBackgroundColor
        textField.delegate = self
        textField.becomeFirstResponder()
        


        constraintContainer()
        
    }
    
    fileprivate let textFieldView: CustomView = {
       let view = CustomView()
        view.layer.cornerRadius = 8
//       view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.backgroundColor = .white
        if subViewColor == .black{
            view.layer.shadowColor = UIColor.lightGray.cgColor
            view.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            view.layer.shadowRadius = 6.0
            view.layer.shadowOpacity = 0.1
        }
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()

    fileprivate let searchIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "searchIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate let textField: UITextField = {
       let field = UITextField()
        field.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        field.placeholder = "Search \"NBA\""
        field.tintColor = .lightGray
        if subViewColor == .white{
            field.keyboardAppearance = .dark
        }else{
            field.keyboardAppearance = .light
        }
        field.returnKeyType = .search

        field.translatesAutoresizingMaskIntoConstraints = false
       return field
    }()
    fileprivate let returnBtn: UIButton = {
       let btn = UIButton()
        btn.setAttributedTitle(NSAttributedString(string: "Cancel", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.lightGray]), for: .normal)
        btn.addTarget(self, action: #selector(returnBtnSelected), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    fileprivate lazy var userTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = true
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(TrendingSearchCell.self, forCellReuseIdentifier: "TrendingSearchCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    
    
    
    
    

    func FetchAutoSearch(q:String){
        let headers = [
            "x-rapidapi-key": "46289005e3mshe96d5a666f9cdf5p1aa3c3jsn4df095e96835",
            "x-rapidapi-host": "webit-keyword-search.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://webit-keyword-search.p.rapidapi.com/autosuggest?q=\(q)&language=en")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                do{
//                    let unsorteddictionary  = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed) as? [String:Any]
                    let dictionary = try JSONDecoder().decode(SearchmainObject.self, from: data!)
                    let dic = dictionary.data.results! as [String]
                    self.listSearch = dic
                    
                    DispatchQueue.main.async {
                        self.userTableView.reloadData()
                    }
                }catch{
                    print("Error", error)
                }
            }
        })

        dataTask.resume()
    }
    
    func constraintContainer(){
        view.addSubview(textFieldView)
        textFieldView.addSubview(searchIcon)
        textFieldView.addSubview(textField)
        view.addSubview(returnBtn)
        view.addSubview(userTableView)
        
        NSLayoutConstraint.activate([
            textFieldView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            textFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            textFieldView.trailingAnchor.constraint(equalTo: returnBtn.leadingAnchor, constant: -8),
            textFieldView.heightAnchor.constraint(equalToConstant:36),
            
            searchIcon.centerYAnchor.constraint(equalTo: textFieldView.centerYAnchor),
            searchIcon.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor, constant: 4),
            searchIcon.widthAnchor.constraint(equalTo: textFieldView.heightAnchor, constant: -16),
            searchIcon.heightAnchor.constraint(equalTo: textFieldView.heightAnchor, constant: -16),
            
            
            textField.topAnchor.constraint(equalTo: textFieldView.topAnchor, constant: 3),
            textField.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor, constant: 4),
            textField.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -8),
            textField.bottomAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: -3),
            
            returnBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            returnBtn.centerYAnchor.constraint(equalTo: textFieldView.centerYAnchor),
            
            
            userTableView.topAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: 8),
            userTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            userTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    @objc func returnBtnSelected(){
        dismiss(animated: true, completion: nil)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard self.textField.text != "" else{return false}
        userTableView.reloadData()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        textField.text = textField.text!.uppercased()
        for letter in string{
            for i in "/:;()$&@\",?!'[]{}#%^*+=\\|~<>€£¥•,?!'"{
                if letter == i{
                    return false
                }
            }
        }

        if textField.text! != ""{
            let qString = textField.text
            FetchAutoSearch(q: (qString?.replacingOccurrences(of: " ", with: "%20"))!)
        }

        guard let textFieldText = textField.text, let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count

        if count >= 28{return false}
//        userTableView.reloadData()
        let firstLowercaseCharRange = string.rangeOfCharacter(from: NSCharacterSet.lowercaseLetters)
        if let _ = firstLowercaseCharRange {
            if let text = textField.text, text.isEmpty {
                textField.text = string.uppercased()
            }
            else {
                let beginning = textField.beginningOfDocument
                if let start = textField.position(from: beginning, offset: range.location),
                    let end = textField.position(from: start, offset: range.length),
                    let replaceRange = textField.textRange(from: start, to: end) {
                    textField.replace(replaceRange, withText: string.uppercased())
                }
            }
            return false
        }

        return true
    }
}

class TrendingSearchCell: UITableViewCell{
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = BlackBackgroundColor
        self.addSubview(prefaceTitle)
        self.addSubview(title)
        self.addSubview(arrowImage)
        NSLayoutConstraint.activate([
            prefaceTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            prefaceTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            prefaceTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            title.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            title.trailingAnchor.constraint(equalTo: arrowImage.leadingAnchor, constant: -12),
            
            arrowImage.widthAnchor.constraint(equalToConstant: 25),
            arrowImage.heightAnchor.constraint(equalToConstant: 25),
            arrowImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            arrowImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12)
        ])
    }
    
    let prefaceTitle: CustomLabel = {
        let textLabel = CustomLabel()
        textLabel.textColor = subViewColor
        textLabel.text = "#"
        textLabel.font = .systemFont(ofSize: 18, weight: .bold)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    let title: CustomLabel = {
        let textLabel = CustomLabel()
        textLabel.textColor = .lightGray
        textLabel.text = ""
        textLabel.font = .systemFont(ofSize: 16, weight: .bold)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    let arrowImage: UIImageView = {
       let img = UIImageView()
        img.contentMode = .scaleAspectFill
//        img.image = UIImage(named: "RightArrow2")
        if subViewColor == .black{
            img.image = UIImage(named: "BlackRightArrow")
        }else{
            img.image = UIImage(named: "WhiteRightArrow")
        }
        img.translatesAutoresizingMaskIntoConstraints = false
       return img
    }()
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


















protocol SearchTopicCollectionProtocol {
    func OpenTopic(title:String)
}
let header = ["Technology","Entertainment","Sports","Business","U.S.","Science"]
let HeaderForTrending = ["TECHNOLOGY","ENTERTAINMENT","SPORTS","BUSINESS","NATION","SCIENCE"]




class TrendingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, SearchTopicCollectionProtocol, UIGestureRecognizerDelegate, PostCollectionViewDel, blackViewProtocol{
    
    var blackWindow = UIView()

    func OpenTopic(title: String) {
        let vc = SearchResultCollection()
        vc.topicTitle = title
        print("DOne")
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    func changeBlackView() {
            self.tabBarController?.tabBar.isHidden = false
    }
    
    func openView(url: String) {}
    
    func PostInteraction(btnItem: Int, image: UIImage?, url: String?, title: String?, description: String?, date: String?, sourceName: String?, imageURL: String?){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy, EEEE MMM d h:mm a"
        let date2 = dateFormatter.date(from: date!)!.timeAgoDisplay()
        
        let vc = ExpandedPost()
        vc.url = url
        vc.TopicTitle.text = title
        vc.TopicDesc.text = description
        vc.DateOfTopic.text = date2
        vc.dateItem = date
        vc.title = sourceName
        vc.PublicationName.text = sourceName
        if sourceName == "Bleacher Report"{
            vc.TopicImage.image = UIImage(named: "BLEACHERREPORTIMG")
        }else{
            vc.TopicImage.sd_setImage(with: URL(string: imageURL!), placeholderImage: UIImage(named:"BlankBackground"))
        }
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
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
            print("Trending")
            str = "https://news.google.com/rss?hl=en-US&gl=US&ceid=US:en"
//            str = "https://news.google.com/news/rss/headlines/section/topic/\(HeaderForTrending[1])"


        }else{
           str = "https://news.google.com/news/rss/headlines/section/topic/\(HeaderForTrending[item])"
            print(header[item], item)
        }

        guard let url = URL(string:str ) else{print("First"); return}
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
        guard let str = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) else{print("Second");return}
        //one root element
            let xml = SWXMLHash.parse(str as String)

//            let count = xml["rss"]["channel"]["item"].all.count
            outerLoop: for i in 0...8 {
            guard let artURL = xml["rss"]["channel"]["item"][i]["link"].element?.text else{return}
            guard let artDate = xml["rss"]["channel"]["item"][i]["pubDate"].element?.text else{print("Nil date");return}
            guard let artProvider = xml["rss"]["channel"]["item"][i]["source"].element?.text else{print("Nil provider");return}
            guard let url = URL(string: artURL) else {print("URL is Broken!"); return}
            OpenGraph.fetch(url: url) { result in
                nestedLoop: switch result {
                case .success(let og):
                    guard let artTitle = og[.title] else{return}
                    guard let imageURL = og[.image] else{return}
                    guard let descText = og[.description] else{return}

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

//                    let itemArt = ArticleItem(url: artURL, title: artTitle, desc: descText, date: newDate, source_name: artProvider, image: imageURL)
                    let itemArt = ArticleItem(url: artURL, title: artTitle.htmlDecoded(), desc: desc!.htmlDecoded(), date: newDate, source_name: artProvider, image: imageURL)

                    switch item {
                    case 0:
                        guard ListObjectTechnology.count != 3 else{return}
                        ListObjectTechnology.append(itemArt)
                        return
                    case 1:
                        guard ListObjectEntertainment.count != 3 else{return}
                        ListObjectEntertainment.append(itemArt)
                        return
                    case 2:
                        guard ListObjectSports.count != 3 else{return}
                        ListObjectSports.append(itemArt)
                    case 3:
                        guard ListObjectBuisness.count != 3 else{return}
                        ListObjectBuisness.append(itemArt)
                    case 4:
                        guard ListObjectPolitics.count != 3 else{return}
                        ListObjectPolitics.append(itemArt)
                    case 5:
                        guard ListObjectScience.count != 3 else{return}
                        ListObjectScience.append(itemArt)
                        print( "CHECK", ListObjectScience.count)

                    default:
                        guard ListObjectTrending.count != 3 else{return}
                        ListObjectTrending.append(itemArt)
                    }



                case .failure(let error):
                    print("Error: ",error)
                }
            }
            }
        }
        task.resume()


    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Trending"
        view.backgroundColor = BlackBackgroundColor
        
        let favoritesBtn = UIBarButtonItem(image: UIImage(named: "slideTabFavorites24"), style: .plain, target: self, action: #selector(SavedItemsSelected))
        navigationItem.rightBarButtonItem = favoritesBtn
//        navigationController?.interactivePopGestureRecognizer?.delegate = self

//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy, EEEE MMM d h:mm a"
//        print(dateFormatter.string(from: Date()))
//        let date = Date().addingTimeInterval(10800)
//        print(dateFormatter.string(from: date))
        let realmObjc = try! Realm()


        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (Timer) in
            let realmLists = [realmObjc.objects(trendingArtTop.self).first?.Technology,realmObjc.objects(trendingArtTop.self).first?.Entertainment,realmObjc.objects(trendingArtTop.self).first?.Sports,realmObjc.objects(trendingArtTop.self).first?.Buisness,realmObjc.objects(trendingArtTop.self).first?.Politics,realmObjc.objects(trendingArtTop.self).first?.Science]

            if realmLists[0]?.count == 3 && realmLists[1]?.count == 3 && realmLists[2]?.count == 3 && realmLists[3]?.count == 3 && realmLists[4]?.count == 3 && realmLists[5]?.count == 3{
                self.LoadView.removeFromSuperview()
                self.constraintContainer()
                Timer.invalidate()
            }

        }

        
        if realmObjc.objects(currentTrendingTime.self).count == 0{
            let trendingRefreshTime = currentTrendingTime()
            trendingRefreshTime.date = Date()
            try! realmObjc.write{
                realmObjc.add(trendingRefreshTime)
            }
            
            for i in 0...6{
                fetchTrendingTopics(item: i)
            }


            timer.fire()
            view.addSubview(LoadView)
            LoadView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 4).isActive = true
            LoadView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
            LoadView.widthAnchor.constraint(equalToConstant: 50).isActive = true
            LoadView.heightAnchor.constraint(equalToConstant: 50).isActive = true


        }else{
            let past = realmObjc.objects(currentTrendingTime.self)[0].date
            if Date() > past.addingTimeInterval(7200) {
                view.addSubview(LoadView)
                LoadView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 4).isActive = true
                LoadView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
                LoadView.widthAnchor.constraint(equalToConstant: 50).isActive = true
                LoadView.heightAnchor.constraint(equalToConstant: 50).isActive = true
                for i in 0...6{
                    fetchTrendingTopics(item: i)
                }
                try! realmObjc.write{
                    realmObjc.objects(currentTrendingTime.self)[0].date = Date()
                    realmObjc.objects(trendingArtTop.self)[0].Technology.removeAll()
                }

                timer.fire()
            }else{
                constraintContainer()
            }
        }


        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        LoadView.play()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = subViewColor
        navigationController?.navigationBar.barTintColor = BlackBackgroundColor
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: subViewColor]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: subViewColor]
//        if subViewColor == .white{
//            UIApplication.shared.statusBarStyle = .lightContent
//        }else{
//            UIApplication.shared.statusBarStyle = .darkContent
//        }

    }

//
    lazy var LoadView: AnimationView = {
       let animationView = AnimationView()
        animationView.animation = Animation.named("LoadingAnimation")
        animationView.animationSpeed = 1.5
        animationView.play()
        animationView.loopMode = .loop

        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    
    lazy var TrendingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 4
        
        layout.sectionInset = UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(FirstTrendingCollectionView.self, forCellWithReuseIdentifier: "FirstTrendingCollectionView")
//        collectionView.register(SecondTrendingCollectionView.self, forCellWithReuseIdentifier: "SecondTrendingCollectionView")
        collectionView.register(SecondTrendingCollectionView.self, forCellWithReuseIdentifier: "TrendingCellID")
        collectionView.register(SecondTrendingCollectionView.self, forCellWithReuseIdentifier: "TechnologyCellID")
        collectionView.register(SecondTrendingCollectionView.self, forCellWithReuseIdentifier: "EntertainmentCellID")
        collectionView.register(SecondTrendingCollectionView.self, forCellWithReuseIdentifier: "SportsCellID")
        collectionView.register(SecondTrendingCollectionView.self, forCellWithReuseIdentifier: "BusinessCellID")
        collectionView.register(SecondTrendingCollectionView.self, forCellWithReuseIdentifier: "PoliticsCellID")
        collectionView.register(SecondTrendingCollectionView.self, forCellWithReuseIdentifier: "ScienceCellID")
        

        collectionView.backgroundColor = BlackBackgroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshGroupList(_:)), for: .valueChanged)
        refresh.layoutIfNeeded()
        refresh.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)

        return refresh
    }()
    func constraintContainer(){

        view.addSubview(TrendingCollectionView)
        TrendingCollectionView.refreshControl = refreshControl
//        TrendingCollectionView.backgroundView = refreshControl
        
        NSLayoutConstraint.activate([
            TrendingCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            TrendingCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            TrendingCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            TrendingCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    
//    func fetchTrendingTopics(){
////        showSpinner(onView: view.self)
//        let headers = [
//            "x-rapidapi-key": "46289005e3mshe96d5a666f9cdf5p1aa3c3jsn4df095e96835",
//            "x-rapidapi-host": "webit-news-search.p.rapidapi.com"
//        ]
//
//        let request = NSMutableURLRequest(url: NSURL(string: "https://webit-news-search.p.rapidapi.com/trending?language=en&has_image=true&number=20")! as URL,
//                                                cachePolicy: .useProtocolCachePolicy,
//                                            timeoutInterval: 10.0)
//        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = headers
//
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//            if (error != nil) {
//                print(error)
//            } else {
//                do{
//                    let dictionary = try JSONDecoder().decode(mainObject.self, from: data!)
//                    let dic = dictionary.data.results as [ArticleObjects]
//
//                    ListObjectTrending = dic.filter {$0.date != "" && $0.date != "0000-00-00 00:00:00" && $0.source_name != "BuzzFeed"}
//
//                    print(TrendingArticles.count)
//
//                    DispatchQueue.main.async {
//                        self.removeSpinner()
////                        self.TrendingCollectionView.reloadData()
////                        print(TrendingArticles)
//
//                        }
//
//
//                }catch{
//                    print("Error", error)
//                }
//            }
//        })
//
//        dataTask.resume()
//    }
    
    

    
    
    
    
    
    @objc func SavedItemsSelected(){
        let vc = fullSizePost()
        vc.hidesBottomBarWhenPushed = true
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    @objc private func refreshGroupList(_ sender: UIRefreshControl) {
//        for i in 0...6{
//            fetchTrendingTopics(item: i)
//        }
        
//        view.isUserInteractionEnabled = false
//        DispatchQueue.main.asyncAfter(deadline: .now()+5, execute: {
////            self.TrendingCollectionView.reloadData()
////            self.view.layoutIfNeeded()
////            self.view.layoutSubviews()
////            DispatchQueue.main.async {
//                self.TrendingCollectionView.reloadData()
//                self.TrendingCollectionView.collectionViewLayout.invalidateLayout()
//                self.TrendingCollectionView.layoutSubviews()
////            }
//            self.view.isUserInteractionEnabled = true
            sender.endRefreshing()

//        })
    }
    
    @objc func UserSettingsSelected(){
        print("Done")
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationItem.searchController = nil

    }
    @objc func SearchBtnSelected(){
        let vc = TrendingSearchViewController()
        vc.modalPresentationStyle = .currentContext
        vc.delegate = self
        vc.hidesBottomBarWhenPushed = true
        navigationController?.present(vc, animated: true)
    }
    
    @objc func headerBtnSelected(){
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let pos = scrollView.contentOffset.y
//        if scrollView.contentOffset.y < 0{
////            textFieldView.alpha = 1 - pos/20
//        textFieldHeight?.constant = pos+8
//    }
//        print(pos)
//        }
//        if pos

    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 1
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            switch indexPath.section{
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstTrendingCollectionView", for: indexPath) as! FirstTrendingCollectionView
                cell.PostDelegate = self
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TechnologyCellID", for: indexPath) as! SecondTrendingCollectionView
                cell.Item = indexPath.section-1
                cell.TopicLabel.text = header[indexPath.section-1]
                cell.PostDelegate = self
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EntertainmentCellID", for: indexPath) as! SecondTrendingCollectionView
                cell.Item = indexPath.section-1
                cell.TopicLabel.text = header[indexPath.section-1]
                cell.PostDelegate = self
                return cell
                
            case 3:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportsCellID", for: indexPath) as! SecondTrendingCollectionView
                cell.Item = indexPath.section-1
                cell.TopicLabel.text = header[indexPath.section-1]
                cell.PostDelegate = self
                return cell
            case 4:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BusinessCellID", for: indexPath) as! SecondTrendingCollectionView
                cell.Item = indexPath.section-1
                cell.TopicLabel.text = header[indexPath.section-1]
                cell.PostDelegate = self
                return cell
            case 5:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PoliticsCellID", for: indexPath) as! SecondTrendingCollectionView
                cell.Item = indexPath.section-1
                cell.TopicLabel.text = header[indexPath.section-1]
                cell.PostDelegate = self
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScienceCellID", for: indexPath) as! SecondTrendingCollectionView
                cell.Item = indexPath.section-1
                cell.TopicLabel.text = header[indexPath.section-1]
                cell.PostDelegate = self
                return cell
            }

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            let size = CGSize(width: collectionView.frame.width, height: 364)
            return size
            
        }else{
            let size = CGSize(width: collectionView.frame.width, height: 500)
            return size
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0{
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }else{
            return UIEdgeInsets(top: 2, left: 4, bottom: 4, right: 4)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if indexPath.section > 0{
            let vc = SearchResultCollection()
            vc.topicTitle = HeaderForTrending[indexPath.section-1]
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = SearchResultCollection()
            vc.topicTitle = "Trending"
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }

    }
    
    
}

//      MARK:FIRST TRENDINGCOLLECTIONVIEW

class FirstTrendingCollectionView: UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, PostCollectionViewDel{
//    let realm = try! Realm()
    var PostDelegate: PostCollectionViewDel?
    func PostInteraction(btnItem: Int, image: UIImage?, url: String?, title: String?, description: String?, date: String?, sourceName: String?, imageURL: String?) {
        PostDelegate?.PostInteraction(btnItem: 0, image: image, url: url, title: title, description: description, date: date, sourceName: sourceName, imageURL: imageURL)
    }
    
    func openView(url: String) {}
    
    let item = try! Realm().objects(trendingArtTop.self)[0].Trending
    var timer =  Timer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = BlackBackgroundColor
        constraintContainer()
    }
    
    func fireTimer(_ int: Int){
        var itemInt = int
        var scroll = false
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { (Timer) in

            if scroll{
                self.TrendingCollection.scrollToItem(at: NSIndexPath(row: itemInt, section: 0) as IndexPath, at: .init(), animated: true)
                if itemInt != self.item.count {
                    itemInt += 1
                }else{
                    itemInt = 0
                }
            }else{
                scroll = true
            }
        }
        timer.fire()
    }
    let cardView: UIView = {
       let view = UIView()
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 10
        if subViewColor == .black{
            view.backgroundColor = .white
            view.layer.shadowColor = UIColor.lightGray.cgColor
            view.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
            view.layer.shadowRadius = 6.0
            view.layer.shadowOpacity = 0.5
        }else{
            view.backgroundColor = UIColor(red: 50/255, green: 50/255, blue:50/255, alpha: 1)
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let textFieldView: UIButton = {
       let view = UIButton()
        view.layer.cornerRadius = 8
//       view.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        view.backgroundColor = .white
        if subViewColor == .black{
            view.layer.shadowColor = UIColor.lightGray.cgColor.copy(alpha: 0.4)
            view.layer.shadowOpacity = 1
            view.layer.shadowOffset = CGSize(width: 0, height: 3)
            view.layer.shadowRadius = 4
        }
////         = true
        view.addTarget(self, action: #selector(SearchBtnSelected), for: .touchUpInside)
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()

    fileprivate let searchIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "searchIcon")
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate let textField: CustomLabel = {
       let field = CustomLabel()
        field.attributedText = NSAttributedString(string: "Search Topics", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        field.backgroundColor = .clear
        field.translatesAutoresizingMaskIntoConstraints = false
       return field
    }()
    
    
    
    let title: CustomLabel = {
        let label = CustomLabel()
        label.textColor = .lightGray
        label.text = "Top Articles in"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let TopicLabel: CustomLabel = {
        let label = CustomLabel()
        label.textColor = subViewColor
        label.text = "Trending"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let moreText: CustomLabel = {
        let label = CustomLabel()
        label.textColor = .lightGray
        label.text = "More"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    fileprivate let imgArrow: UIImageView = {
        let imageView = UIImageView()
        if subViewColor == .black{
            imageView.image = UIImage(named: "BlackRightArrow")
        }else{
            imageView.image = UIImage(named: "WhiteRightArrow")
        }
        imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
    }()
    
        lazy var TrendingCollection: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.isPagingEnabled = true
            collectionView.isScrollEnabled = true
            collectionView.backgroundColor = BlackBackgroundColor
            collectionView.bounces = true
    
            collectionView.register(TrendingCollectionItem.self, forCellWithReuseIdentifier: "TrendingCollection")
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            return collectionView
        }()
    
    
    func constraintContainer(){
        addSubview(TrendingCollection)
        addSubview(cardView)
        addSubview(textFieldView)
        textFieldView.addSubview(searchIcon)
        textFieldView.addSubview(textField)
        cardView.addSubview(title)
        cardView.addSubview(TopicLabel)
        cardView.addSubview(moreText)
        cardView.addSubview(imgArrow)
        
        NSLayoutConstraint.activate([
            
            textFieldView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            textFieldView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            textFieldView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            textFieldView.heightAnchor.constraint(equalToConstant:36),
            
            
            
            searchIcon.centerYAnchor.constraint(equalTo: textFieldView.centerYAnchor),
            searchIcon.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor, constant: 4),
            searchIcon.widthAnchor.constraint(equalTo: textFieldView.heightAnchor, constant: -16),
            searchIcon.heightAnchor.constraint(equalTo: textFieldView.heightAnchor, constant: -16),
            
            
            textField.topAnchor.constraint(equalTo: textFieldView.topAnchor, constant: 3),
            textField.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor, constant: 4),
            textField.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -8),
            textField.bottomAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: -3),
            
            
            
            TrendingCollection.topAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: 8),
            TrendingCollection.bottomAnchor.constraint(equalTo: cardView.topAnchor, constant: -8),
            TrendingCollection.leadingAnchor.constraint(equalTo: leadingAnchor),
            TrendingCollection.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            cardView.heightAnchor.constraint(equalToConstant: 66),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            title.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12),
            title.leadingAnchor.constraint(equalTo: cardView.leadingAnchor,constant: 8),
                        
            TopicLabel.topAnchor.constraint(equalTo: title.bottomAnchor),
            TopicLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor,constant: 16),

            moreText.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            moreText.trailingAnchor.constraint(equalTo: imgArrow.leadingAnchor),


            imgArrow.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            imgArrow.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            imgArrow.heightAnchor.constraint(equalToConstant: 22),
            imgArrow.widthAnchor.constraint(equalToConstant: 22),
        ])
    }
    
    
    @objc func SearchBtnSelected(){
        let vc = TrendingSearchViewController()
//        vc.modalPresentationStyle = .currentContext
//        vc.delegate = self
//        vc.hidesBottomBarWhenPushed = true
//        navigationController?.present(vc, animated: true)
        print("Done")
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy, EEEE MMM d h:mm a"
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingCollection", for: indexPath) as! TrendingCollectionItem

        cell.tag = indexPath.row
        if cell.tag == indexPath.row{

//            itemInt = indexPath.row
            timer.invalidate()
            fireTimer(indexPath.row)
            cell.TopicTitle.text = item[indexPath.row].title?.htmlDecoded()
            cell.PublicationName.text = item[indexPath.row].source_name
            
            if item[indexPath.row].date == "" || item[indexPath.row].date == nil{
                    cell.DateOfTopic.text = "-"
            }else{
//                    let dateFormatterGet = DateFormatter()
//                    dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
//
//                    let dateFormatterTime = DateFormatter()
//                    dateFormatterTime.dateFormat = "hh:mm a"
//
//                    let dateFormatterDate = DateFormatter()
//                    dateFormatterDate.dateFormat = "MM/dd/yy"
//
//                    let date: NSDate? = dateFormatterGet.date(from: (item[indexPath.row].date)!) as NSDate?
//                if dateFormatterDate.string(from: Date()) == dateFormatterDate.string(from: date as! Date){
//                        cell.DateOfTopic.text = dateFormatterTime.string(from: date! as Date)
//                    }else{
//                        cell.DateOfTopic.text = dateFormatterDate.string(from: date! as Date)
//                }
                let date = dateFormatter.date(from:item[indexPath.row].date!)?.timeAgoDisplay()
                cell.DateOfTopic.text = date
            }
                guard let image = item[indexPath.row].image else{return cell}
            DispatchQueue.main.async {
                if self.item[indexPath.row].source_name == "Engadget"{
                    cell.TopicImage.image = UIImage(named: "ENGADGETIMG")
                }else if self.item[indexPath.row].source_name == "Bleacher Report"{
                    cell.TopicImage.image = UIImage(named: "BLEACHERREPORTIMG")
                }else{
                    cell.TopicImage.sd_setImage(with:URL(string: self.item[indexPath.row].image!), placeholderImage: UIImage(named: "BlankBackground"))
                }
            }
            cell.backgroundColor = .clear
        }
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
        
        PostDelegate?.PostInteraction(btnItem: 0, image: nil, url: item[indexPath.row].url, title: item[indexPath.row].title?.htmlDecoded(), description: item[indexPath.row].desc, date: item[indexPath.row].date, sourceName: item[indexPath.row].source_name, imageURL: item[indexPath.row].image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TrendingCollectionItem: UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame: frame)
        constraintContainer()
    }
    
    
//     TOPIC VIEW VIEWS
    fileprivate let TopicView: CustomView = {
       let view = CustomView()

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let TopicImage: CustomImageView2 = {
        let view = CustomImageView2()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .white

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let DimTopicLayer: UIImageView = {
       let view = UIImageView()
        view.alpha = 0.7
        view.backgroundColor = .clear
        view.image = UIImage(named: "GradientImage")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()


    fileprivate let TopicTitle: CustomLabel = {
        let label = CustomLabel()
        label.numberOfLines = 3
        label.adjustsFontSizeToFitWidth = true
        label.attributedText = NSAttributedString(string: "-", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .semibold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    fileprivate let PublicationName: CustomLabel = {
        let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "-", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .semibold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    fileprivate let DoteSeperator: CustomLabel = {
        let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "•", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .semibold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let DateOfTopic: CustomLabel = {
        let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "2 Hours ago", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .semibold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    
    func constraintContainer(){
        
        self.addSubview(TopicImage)
        self.addSubview(DimTopicLayer)

        
        self.addSubview(TopicView)

            TopicView.addSubview(TopicTitle)
        
            TopicView.addSubview(PublicationName)
            TopicView.addSubview(DoteSeperator)
            TopicView.addSubview(DateOfTopic)
        

        
        NSLayoutConstraint.activate([
            
            TopicView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            TopicView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            TopicView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            TopicView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            
            TopicImage.topAnchor.constraint(equalTo: TopicView.topAnchor),
            TopicImage.leadingAnchor.constraint(equalTo: TopicView.leadingAnchor),
            TopicImage.trailingAnchor.constraint(equalTo: TopicView.trailingAnchor),
            TopicImage.bottomAnchor.constraint(equalTo: TopicView.bottomAnchor),
            
            DimTopicLayer.topAnchor.constraint(equalTo: TopicView.topAnchor),
            DimTopicLayer.leadingAnchor.constraint(equalTo: TopicView.leadingAnchor),
            DimTopicLayer.trailingAnchor.constraint(equalTo: TopicView.trailingAnchor),
            DimTopicLayer.bottomAnchor.constraint(equalTo: TopicView.bottomAnchor),
            
            
            TopicTitle.bottomAnchor.constraint(equalTo: PublicationName.topAnchor, constant: -8),
            TopicTitle.leadingAnchor.constraint(equalTo: TopicView.leadingAnchor, constant: 16),
            TopicTitle.trailingAnchor.constraint(equalTo: TopicView.trailingAnchor, constant: -8),
//            TopicTitle.heightAnchor.constraint(equalToConstant: 80),
            

            
            PublicationName.bottomAnchor.constraint(equalTo: TopicView.bottomAnchor, constant: -8),
            PublicationName.trailingAnchor.constraint(equalTo: DoteSeperator.leadingAnchor, constant: -4),
            
            DoteSeperator.bottomAnchor.constraint(equalTo: TopicView.bottomAnchor, constant: -8),
            DoteSeperator.trailingAnchor.constraint(equalTo: DateOfTopic.leadingAnchor, constant: -4),

            
            DateOfTopic.bottomAnchor.constraint(equalTo: TopicView.bottomAnchor, constant: -8),
            DateOfTopic.trailingAnchor.constraint(equalTo: TopicView.trailingAnchor, constant: -8),
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}







//      MARK:Second TRENDINGCOLLECTIONVIEW

class SecondTrendingCollectionView: UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, PostCollectionViewDel{
    var PostDelegate: PostCollectionViewDel?
    func PostInteraction(btnItem: Int, image: UIImage?, url: String?, title: String?, description: String?, date: String?, sourceName: String?, imageURL: String?) {
        PostDelegate?.PostInteraction(btnItem: 0, image: image, url: url, title: title, description: description, date: date, sourceName: sourceName, imageURL: imageURL)
    }
    
    func openView(url: String) {}
    
//    var lists = [TrendingArticles,TechnologyArticles,PoliticsArticles,SportArticles,EntertainmentArticles,ScienceArticles,BusinessArticles]
    let realm = try! Realm()
    var realmLists = [List<TrendingArticleObject>]()
    
//
    var listOfItem = List<TrendingArticleObject>()
    var Item = Int(){
        didSet{
         listOfItem = realmLists[Item]
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = BlackBackgroundColor
        constraintContainer()
        
        realmLists = [realm.objects(trendingArtTop.self)[0].Technology,realm.objects(trendingArtTop.self)[0].Entertainment,realm.objects(trendingArtTop.self)[0].Sports,realm.objects(trendingArtTop.self)[0].Buisness,realm.objects(trendingArtTop.self)[0].Politics,realm.objects(trendingArtTop.self)[0].Science]
    }

    var expandPostProt: exapndAccountPosts?

        let title: CustomLabel = {
            let label = CustomLabel()
            label.textColor = .lightGray
            label.text = "Top Articles in"
            label.font = .systemFont(ofSize: 16, weight: .semibold)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
    }()
        let TopicLabel: CustomLabel = {
            let label = CustomLabel()
            label.textColor = subViewColor
            label.font = .systemFont(ofSize: 20, weight: .semibold)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
    }()
        let moreText: CustomLabel = {
            let label = CustomLabel()
            label.textColor = .lightGray
            label.text = "More"
            label.font = .systemFont(ofSize: 16, weight: .semibold)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
    }()
    fileprivate let imgArrow: UIImageView = {
        let imageView = UIImageView()
        if subViewColor == .black{
            imageView.image = UIImage(named: "BlackRightArrow")
        }else{
            imageView.image = UIImage(named: "WhiteRightArrow")
        }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    
    let cardView: UIView = {
       let view = UIView()
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 10
        if subViewColor == .black{
            view.backgroundColor = .white
            view.layer.shadowColor = UIColor.lightGray.cgColor
            view.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
            view.layer.shadowRadius = 6.0
            view.layer.shadowOpacity = 0.5
        }else{
            view.backgroundColor = UIColor(red: 50/255, green: 50/255, blue:50/255, alpha: 1)
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
        lazy var TrendingCollection: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.isScrollEnabled = true
            collectionView.backgroundColor = .clear
//            collectionView.bounces = false
//            collectionView.isPagingEnabled = true
    
            collectionView.register(SecondTrendingCollectionItem.self, forCellWithReuseIdentifier: "SecondTrendingCollectionItem")
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            return collectionView
        }()
    

    
    
    func constraintContainer(){
        
        addSubview(cardView)
        cardView.addSubview(title)
        cardView.addSubview(TopicLabel)
        cardView.addSubview(moreText)
        cardView.addSubview(imgArrow)
        cardView.addSubview(TrendingCollection)

        addConstraintsWithFormat(format:"H:|-12-[v0]-12-|", views: cardView)
        addConstraintsWithFormat(format:"V:|-[v0]-|", views: cardView)
        cardView.addConstraintsWithFormat(format:"H:|-4-[v0]-4-|", views: TrendingCollection)
        NSLayoutConstraint.activate([
            TrendingCollection.topAnchor.constraint(equalTo: TopicLabel.bottomAnchor, constant: 12),
            TrendingCollection.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -12),
                                        
            title.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12),
            title.leadingAnchor.constraint(equalTo: cardView.leadingAnchor,constant: 8),
                                        
            TopicLabel.topAnchor.constraint(equalTo: title.bottomAnchor),
            TopicLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor,constant: 16),
            
            moreText.centerYAnchor.constraint(equalTo: imgArrow.centerYAnchor),
            moreText.trailingAnchor.constraint(equalTo: imgArrow.leadingAnchor),
            
            
            imgArrow.topAnchor.constraint(equalTo: title.bottomAnchor, constant: -2),
            imgArrow.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            imgArrow.heightAnchor.constraint(equalToConstant: 22),
            imgArrow.widthAnchor.constraint(equalToConstant: 22),
        ])
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(3, listOfItem.count)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondTrendingCollectionItem", for: indexPath) as! SecondTrendingCollectionItem

//        cell.TopicImage.sd_setImage(with:URL(string: listOfItem[indexPath.row].image!), placeholderImage: UIImage(named: "BlankBackground"))
        DispatchQueue.main.async {
            if self.listOfItem[indexPath.row].source_name == "Engadget"{
                cell.TopicImage.image = UIImage(named: "ENGADGETIMG")
            }else if self.listOfItem[indexPath.row].source_name == "Bleacher Report"{
                cell.TopicImage.image = UIImage(named: "BLEACHERREPORTIMG")
            }else{
                cell.TopicImage.sd_setImage(with:URL(string: self.listOfItem[indexPath.row].image!), placeholderImage: UIImage(named: "BlankBackground"))
            }
        }
        cell.TopicTitle.text = listOfItem[indexPath.row].title?.htmlDecoded()
        cell.Provider.text = listOfItem[indexPath.row].source_name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy, EEEE MMM d h:mm a"
        
        if listOfItem[indexPath.row].date == ""{
                cell.dateLabel.text = "-"
        }else{
            let date = dateFormatter.date(from: listOfItem[indexPath.row].date!)?.timeAgoDisplay()
            print(date, "DONE IS DONE")
            cell.dateLabel.text = date
        }
            cell.backgroundColor = .clear
            return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width, height: (collectionView.frame.height/3)-8)
        return size
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        PostDelegate?.PostInteraction(btnItem: 0, image: nil, url: listOfItem[indexPath.row].url, title: listOfItem[indexPath.row].title?.htmlDecoded(), description: listOfItem[indexPath.row].desc, date: listOfItem[indexPath.row].date, sourceName: listOfItem[indexPath.row].source_name, imageURL: listOfItem[indexPath.row].image)
    }
    func expandCell(){
//        expandPostProt?.expandPost(title: String, url: String, desc: String, provider: String, date: String)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SecondTrendingCollectionItem: UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame: frame)
        constraintContainer()
    }
    
    
//     TOPIC VIEW VIEWS
//    fileprivate let TopicView: CustomView = {
//       let view = CustomView()
//
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    fileprivate let TopicImage: CustomImageView2 = {
        let view = CustomImageView2()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let DimTopicLayer: UIImageView = {
       let view = UIImageView()
        view.alpha = 0.65
        view.backgroundColor = .black

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()


    fileprivate let TopicTitle: CustomLabel = {
        let label = CustomLabel()
        label.numberOfLines = 3
        label.textColor = subViewColor
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let Provider: CustomLabel = {
        let label = CustomLabel()
        label.numberOfLines = 1
//        label.text = "-"
        label.textAlignment = .right
        label.textColor = TealConstantColor
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    fileprivate let DoteLabel: CustomLabel = {
//        let label = CustomLabel()
//        label.numberOfLines = 1
//        label.textColor = TealConstantColor
//        label.text = " • "
//        label.font = .systemFont(ofSize: 13, weight: .semibold)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
    let dateLabel: CustomLabel = {
        let label = CustomLabel()
        label.numberOfLines = 1
        label.textColor = TealConstantColor
//        label.text = "12 Hours ago"
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    func constraintContainer(){
        self.addSubview(dateLabel)
//        self.addSubview(DoteLabel)
        self.addSubview(Provider)

//        self.addSubview(DimTopicLayer)
//        self.addSubview(TopicView)
        self.addSubview(TopicImage)
        self.addSubview(TopicTitle)
        

        
        NSLayoutConstraint.activate([
            TopicImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            TopicImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            TopicImage.widthAnchor.constraint(equalTo: TopicImage.heightAnchor, multiplier: 1.4),
            TopicImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            
            TopicTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            TopicTitle.leadingAnchor.constraint(equalTo: TopicImage.trailingAnchor, constant: 24),
            TopicTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
//            TopicTitle.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -8),
            
            dateLabel.leadingAnchor.constraint(equalTo: TopicImage.trailingAnchor, constant: 12),
            dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),

            
            Provider.leadingAnchor.constraint(equalTo: TopicImage.trailingAnchor, constant: 12),
            Provider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            Provider.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -4),

//            DoteLabel.widthAnchor.constraint(equalToConstant: DoteLabel.intrinsicContentSize.width),
//            DoteLabel.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -4),
//            DoteLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
//

            
            
            
//            TopicView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
//            TopicView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            TopicView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            TopicView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
//
//            TopicImage.topAnchor.constraint(equalTo: TopicView.topAnchor),
//            TopicImage.leadingAnchor.constraint(equalTo: TopicView.leadingAnchor),
//            TopicImage.trailingAnchor.constraint(equalTo: TopicView.trailingAnchor),
//            TopicImage.bottomAnchor.constraint(equalTo: TopicView.bottomAnchor),
//
//            DimTopicLayer.topAnchor.constraint(equalTo: TopicView.topAnchor),
//            DimTopicLayer.leadingAnchor.constraint(equalTo: TopicView.leadingAnchor),
//            DimTopicLayer.trailingAnchor.constraint(equalTo: TopicView.trailingAnchor),
//            DimTopicLayer.bottomAnchor.constraint(equalTo: TopicView.bottomAnchor),
//
//
//            TopicTitle.topAnchor.constraint(equalTo: TopicView.topAnchor, constant: 8),
//            TopicTitle.leadingAnchor.constraint(equalTo: TopicView.leadingAnchor, constant: 16),
//            TopicTitle.trailingAnchor.constraint(equalTo: TopicView.trailingAnchor, constant: -8),
//
//            dateLabel.trailingAnchor.constraint(equalTo: TopicView.trailingAnchor, constant: -8),
//            dateLabel.bottomAnchor.constraint(equalTo: TopicView.bottomAnchor, constant: -8),
            
        ])

        
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//      MARK:Third TRENDINGCOLLECTIONVIEW

class ThirdTrendingCollectionView: UICollectionViewCell{
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
