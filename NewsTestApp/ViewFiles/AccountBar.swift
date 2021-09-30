//
//  AccountBar.swift
//  NewsTestApp
//
//  Created by Caleb Mesfien on 11/26/20.
//

import UIKit
import Lottie
import RealmSwift
import SDWebImage
import SafariServices

protocol exapndAccountPosts {
    func expandPost(title: String, url: String, desc: String, provider: String, date: String)
}


class AccountStackPrefrence: UIView,  UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate{

    var AccountViewControllerItem: AccountViewController?
    var leftHorizontalBar: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        
        constraintContainer()
        setUpHorizontalBar()
        stackOptionCollectionView.selectItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, animated: false, scrollPosition: .init())
    }
    
    let stackOptionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white

        collectionView.register(stackOptionCollectionViewCell.self, forCellWithReuseIdentifier: "stackOptionCollectionView")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    func setUpHorizontalBar(){
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = .black
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBarView)
        
        let reduced = ((UIScreen.main.bounds.width/3)-30)/3
        
        leftHorizontalBar = horizontalBarView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: reduced)
        leftHorizontalBar?.isActive = true
        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    func constraintContainer(){
        stackOptionCollectionView.delegate = self
        stackOptionCollectionView.dataSource = self
        addSubview(stackOptionCollectionView)
        
        self.addConstraintsWithFormat(format: "V:|[v0]|", views: stackOptionCollectionView)
        self.addConstraintsWithFormat(format: "H:|[v0]|", views: stackOptionCollectionView)
    }
    
    
    

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 3
    }
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let stackImages = ["StackItemView","OneItemView", "InterestItemView"]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "stackOptionCollectionView", for: indexPath) as! stackOptionCollectionViewCell
            cell.ItemImage.image = UIImage(named: stackImages[indexPath.row])!.withRenderingMode(.alwaysTemplate)
            
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let size = CGSize(width: (self.frame.width/3), height: self.frame.height)
//            AccountViewControllerItem?.mainScrollView.layoutIfNeeded()
            return size
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let reduced = frame.width/3
        let x = CGFloat(indexPath.item) * reduced
        let num = (reduced - 30)/3
        leftHorizontalBar?.constant = x + num

        
//        MainCollectionViewCell?.scrollToStackIndex(index: indexPath.row)

    }


    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




//          MARK:FIRST COLLECTION



class collectionStackViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, exapndAccountPosts {
    let realmObjc = try! Realm()
    var scrollDelegate: scrollViewPro?
    func expandPost(title: String, url: String, desc: String, provider: String, date: String) {
        expandPostDelegate?.expandPost(title: title, url: url, desc: desc, provider: provider, date: date)
    }
    var expandPostDelegate: exapndAccountPosts?
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(recentCollectionView)

        addConstraintsWithFormat(format:"H:|[v0]|", views: recentCollectionView)
        addConstraintsWithFormat(format:"V:|[v0]|", views: recentCollectionView)
        
    }
        
        lazy var recentCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//            layout.sectionInset = UIEdgeInsets(top: 180, left: 0, bottom: 0, right: 0)
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 1
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.isScrollEnabled = true
            collectionView.backgroundColor = .clear
//            collectionView.bounces = false
            collectionView.showsVerticalScrollIndicator = false
    
            collectionView.register(recentCollectionViewCell.self, forCellWithReuseIdentifier: "recentCollectionView")
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            return collectionView
        }()
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y/2
        scrollDelegate?.scroll(at: y)
        recentCollectionView.reloadData()
        print(y)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if realmObjc.objects(PostObject.self).count != 0{
            return realmObjc.objects(PostObject.self).count
        }else{
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recentCollectionView", for: indexPath) as! recentCollectionViewCell
//        cell.TopicImage.sd_setImage(with: URL(string:realmObjc.objects(PostObject.self)[indexPath.row].image), placeholderImage: UIImage(named: "BlankBackground"))
        cell.TopicImage.sd_setImage(with: URL(string:realmObjc.objects(PostObject.self)[indexPath.row].image), placeholderImage: UIImage(named:"BlankBackground"))
        cell.TopicTitle.text = realmObjc.objects(PostObject.self)[indexPath.row].title
            cell.backgroundColor = .white
            return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: (frame.width/2)-1, height: 180)
        return size
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 0, bottom: 14, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        expandPostDelegate?.expandPost(title: String, url: String, desc: String, provider: String, date: String)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



//         MARK: RECENTCOLLECITONVIEWCELL

class recentCollectionViewCell: UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame: frame)

        constraintContainer()
    }
    
    fileprivate let mainViewCard: CustomView = {
        let view = CustomView()
//        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    fileprivate let TopicTitle: CustomLabel = {
        let label = CustomLabel()
        label.numberOfLines = 4
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let PostTime: CustomLabel = {
        let label = CustomLabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    fileprivate let TopicImage: CustomImageView2 = {
        let view = CustomImageView2()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .clear
//        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let DimTopicLayer: CustomView = {
       let view = CustomView()
        view.alpha = 0.6
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()




    
    fileprivate let lineView: CustomView = {
       let view = CustomView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    func constraintContainer(){
        
        self.addSubview(mainViewCard)
        mainViewCard.addSubview(TopicImage)
        mainViewCard.addSubview(DimTopicLayer)
        mainViewCard.addSubview(PostTime)
        mainViewCard.addSubview(TopicTitle)
        

        
        NSLayoutConstraint.activate([
            
            mainViewCard.topAnchor.constraint(equalTo: self.topAnchor),
            mainViewCard.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainViewCard.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainViewCard.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            PostTime.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            PostTime.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            PostTime.widthAnchor.constraint(equalToConstant: PostTime.intrinsicContentSize.width),
            
            TopicImage.topAnchor.constraint(equalTo: self.topAnchor),
            TopicImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            TopicImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            TopicImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            DimTopicLayer.topAnchor.constraint(equalTo: mainViewCard.topAnchor),
            DimTopicLayer.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor),
            DimTopicLayer.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor),
            DimTopicLayer.bottomAnchor.constraint(equalTo: mainViewCard.bottomAnchor),
            
            TopicTitle.topAnchor.constraint(equalTo: mainViewCard.topAnchor, constant: 8),
            TopicTitle.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor, constant: 16),
            TopicTitle.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor, constant: -8),
//            TopicTitle.heightAnchor.constraint(equalToConstant: 80),

            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}






class fullSizePost: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, exapndAccountPosts, PostCollectionViewDel, blackViewProtocol {
    let realmObjc = try! Realm()
    var scrollDelegate: scrollViewPro?
    let blackWindow = UIView()
    func changeBlackView() {
        UIView.animate(withDuration: 0.3) {
            self.blackWindow.alpha = 0
        }
    }
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
    

    
    
    
    
    func expandPost(title: String, url: String, desc: String, provider: String, date: String) {
        expandPostDelegate?.expandPost(title: title, url: url, desc: desc, provider: provider, date: date)
    }
    var expandPostDelegate: exapndAccountPosts?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites"
        view.backgroundColor = BlackBackgroundColor
        
        if realmObjc.objects(PostObject.self).isEmpty{
            view.addSubview(header)
            view.addSubview(subHeader)
            NSLayoutConstraint.activate([
                header.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                header.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                subHeader.topAnchor.constraint(equalTo: header.bottomAnchor),
                subHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                subHeader.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            ])
        }else{
            view.addSubview(recentCollectionView)
            view.addConstraintsWithFormat(format:"H:|[v0]|", views: recentCollectionView)
            recentCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            recentCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        
    }
    
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
    }
        
    
    let header: CustomLabel = {
        let lbl = CustomLabel()
        lbl.font = .systemFont(ofSize: 18, weight: .bold)
        lbl.textColor = subViewColor
        lbl.textAlignment = .center

        lbl.text = "No Saved Articles"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    let subHeader: CustomLabel = {
        let lbl = CustomLabel()
        lbl.text = "There are no saved articles. You can save an article to read for later. To save an article, it's as easy as tapping the banner icon."
        lbl.font = .systemFont(ofSize: 12, weight: .bold)
        lbl.textColor = .lightGray
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
        lazy var recentCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 1
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.isScrollEnabled = true
            collectionView.backgroundColor = .clear
            collectionView.showsVerticalScrollIndicator = false
    
            collectionView.register(fullSizePostCell.self, forCellWithReuseIdentifier: "fullSizePostCell")
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            return collectionView
        }()
    
    

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        recentCollectionView.reloadData()
        recentCollectionView.collectionViewLayout.invalidateLayout()
        recentCollectionView.layoutSubviews()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if realmObjc.objects(PostObject.self).count != 0{
            return realmObjc.objects(PostObject.self).count
        }else{
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy, EEEE MMM d h:mm a"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fullSizePostCell", for: indexPath) as! fullSizePostCell

        cell.tag = indexPath.row
        
        
        
        if cell.tag == indexPath.row{
            cell.urlItem = realmObjc.objects(PostObject.self).reversed()[indexPath.row].url
            cell.dateItem = realmObjc.objects(PostObject.self).reversed()[indexPath.row].date
            
            DispatchQueue.main.async {
                if self.realmObjc.objects(PostObject.self).reversed()[indexPath.row].source_name == "Engadget"{
                    cell.TopicImage.image = UIImage(named: "ENGADGETIMG")
                }else if self.realmObjc.objects(PostObject.self).reversed()[indexPath.row].source_name == "Bleacher Report"{
                    cell.TopicImage.image = UIImage(named: "BLEACHERREPORTIMG")
                }else{
                    cell.TopicImage.sd_setImage(with:URL(string: self.realmObjc.objects(PostObject.self).reversed()[indexPath.row].image), placeholderImage: UIImage(named: "BlankBackground"))
                }
            }
//        cell.TopicImage.sd_setImage(with: URL(string:realmObjc.objects(PostObject.self)[indexPath.row].image), placeholderImage: UIImage(named: "BlankBackground"))
//        cell.TopicImage.sd_setImage(with: URL(string:realmObjc.objects(PostObject.self).reversed()[indexPath.row].image), placeholderImage: UIImage(named:"BlankBackground"))
        cell.TopicTitle.text = realmObjc.objects(PostObject.self).reversed()[indexPath.row].title
        cell.TopicDesc.text = realmObjc.objects(PostObject.self).reversed()[indexPath.row].desc
        cell.PublicationName.text = realmObjc.objects(PostObject.self).reversed()[indexPath.row].source_name
        
        if realmObjc.objects(PostObject.self).reversed()[indexPath.row].date == ""{
                cell.DateOfTopic.text = "-"
        }else{
            let date = dateFormatter.date(from: realmObjc.objects(PostObject.self).reversed()[indexPath.row].date)?.timeAgoDisplay()
            cell.DateOfTopic.text = date
        }
        }
        cell.backgroundColor = .clear
        cell.newPostDelegate = self
//        cell.del
            return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let size = CGSize(width: (frame.width/2)-1, height: 180)
//        return size
        let sizeOfItem = CGSize(width: (UIScreen.main.bounds.width-48), height: 1000)
        let titleItem = NSString(string:realmObjc.objects(PostObject.self).reversed()[indexPath.row].title).boundingRect(with:sizeOfItem , options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .bold)], context: nil)
        let descItem = NSString(string:realmObjc.objects(PostObject.self).reversed()[indexPath.row].desc).boundingRect(with:sizeOfItem , options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)], context: nil)
        
        let size = CGSize(width: view.frame.width, height:titleItem.height+descItem.height+388)
            return size
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 1, left: 0, bottom: 14, right: 0)
//    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        openView(url: realmObjc.objects(PostObject.self).reversed()[indexPath.row].url)
//        expandPostDelegate?.expandPost(title: String, url: String, desc: String, provider: String, date: String)
    }
}











class fullSizePostCell: UICollectionViewCell {
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

//        newPostDelegate?.PostInteraction(btnItem: 0,image: CleanImage(), url: "Test", title: TopicTitle.text, description: TopicDesc.text!, date: dateItem, sourceName: PublicationName.text, imageURL: TopicImage.sd_imageURL?.absoluteString)

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














//          MARK: INTEREST COLLECTIONVIEW
//
//class collectionStackViewCellInterest: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    var scrollDelegate: scrollViewPro?
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        backgroundColor = .clear
//        addSubview(interestCollectionView)
//
//        addConstraintsWithFormat(format:"H:|[v0]|", views: interestCollectionView)
//        addConstraintsWithFormat(format:"V:|[v0]|", views: interestCollectionView)
//
//    }
//
//        lazy var interestCollectionView: UICollectionView = {
//            let layout = UICollectionViewFlowLayout()
//            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
////            layout.sectionInset = UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 0)
//            
//            layout.minimumLineSpacing = 1
//            collectionView.dataSource = self
//            collectionView.delegate = self
////            collectionView.bounces = true
//            collectionView.isScrollEnabled = true
//
//            collectionView.backgroundColor = .clear
//            collectionView.showsVerticalScrollIndicator = false
//
//            collectionView.register(interestCollectionViewCell.self, forCellWithReuseIdentifier: "interestCollectionView")
//            collectionView.translatesAutoresizingMaskIntoConstraints = false
//            return collectionView
//        }()
//
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let y = scrollView.contentOffset.y/2
//        scrollDelegate?.scroll(at: y)
//    }
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return cataList.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "interestCollectionView", for: indexPath) as! interestCollectionViewCell
////        cell.layer.cornerRadius = 5
//        cell.interestLabel.text = cataList[indexPath.row]
//        cell.topicBackgroundImage.image = UIImage(named: cataList[indexPath.row])
//        return cell
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let size = CGSize(width: (frame.width/2)-1, height: 140)
//            return size
//
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 1, left: 0, bottom: 14, right: 0)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}

//  MARK: INTERESTCOLLECTIONVIEWCELL

class interestCollectionViewCell: UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        constraintContainer()
    }
    
     let interestLabel: CustomLabel = {
        let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "Entertainment", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .semibold)])
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let topicBackgroundImage: UIImageView = {
      let imageView = UIImageView()
        imageView.image = UIImage(named: "PostExample")
//        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
     let dimView: UIImageView = {
       let view = UIImageView()
        view.backgroundColor = .clear
        view.image = UIImage(named: "GradientImage")
        view.alpha = 0.6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
     func constraintContainer(){
        self.addSubview(topicBackgroundImage)
        self.addSubview(dimView)
        self.addSubview(interestLabel)
        
        self.addConstraintsWithFormat(format: "H:|[v0]|", views: topicBackgroundImage)
        self.addConstraintsWithFormat(format: "V:|[v0]|", views: topicBackgroundImage)
        
        self.addConstraintsWithFormat(format: "H:|[v0]|", views: dimView)
        self.addConstraintsWithFormat(format: "V:[v0(100)]|", views: dimView)
        
        self.addConstraintsWithFormat(format: "H:|-[v0]-|", views: interestLabel)
        self.addConstraintsWithFormat(format: "V:[v0]-8-|", views: interestLabel)
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


















//      MARK: STACKOPTIONCOLLECTIONVIEWCELL

class stackOptionCollectionViewCell: UICollectionViewCell{
    override init(frame: CGRect){
        super.init(frame: frame)
    
        self.addSubview(ItemImage)
        NSLayoutConstraint.activate([
            ItemImage.heightAnchor.constraint(equalToConstant: 26),
            ItemImage.widthAnchor.constraint(equalToConstant: 26),
            ItemImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            ItemImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    override var isHighlighted: Bool{
        didSet{
            ItemImage.tintColor = isHighlighted ? UIColor.black : UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        }
    }
    
    override var isSelected: Bool{
        didSet{
            ItemImage.tintColor = isSelected ? UIColor.black : UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        }
    }
    let ItemImage: UIImageView = {
       let imageView = UIImageView()
        imageView.tintColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
