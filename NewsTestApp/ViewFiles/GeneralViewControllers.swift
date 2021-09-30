//
//  GeneralViewControllers.swift
//  NewsTestApp
//
//  Created by Caleb Mesfien on 11/22/20.
//

import UIKit
import WebKit
import Lottie
import RealmSwift
import SafariServices

//class NotificationsClass: UICollectionView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
//    
//}
var BlackBackgroundColor = UIColor()
var subViewColor = UIColor()

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate, blackViewProtocol{
    func changeBlackView() {
        UIView.animate(withDuration: 0.5) {
//            self.blackWindow.alpha = 0
        }
        self.tabBarController?.tabBar.isHidden = false
    }
    let realmObjc = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        let objc = AutoReaderMode()
        objc.isOn = true
        try! realmObjc.write{
            realmObjc.add(objc)
//            realmObjc.objects(DarkMode.self)[0].isDarkMode = false
        }
        if realmObjc.objects(DarkMode.self)[0].isDarkMode{
            BlackBackgroundColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
            subViewColor = UIColor.white
        }else{
//            BlackBackgroundColor = UIColor.white
//            BlackBackgroundColor = UIColor(red: 250/255, green: 252/255, blue: 254/255, alpha: 1)
            BlackBackgroundColor = UIColor(red: 249/255, green: 248/255, blue: 253/255, alpha: 1)
            subViewColor = UIColor.black
        }
        UITabBar.appearance().barTintColor = BlackBackgroundColor // your color

        view.backgroundColor = BlackBackgroundColor
        view.tintColor = TealConstantColor
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0,y: 0,width: 1000,height: 0.5)
        if realmObjc.objects(DarkMode.self)[0].isDarkMode == false{
            topBorder.backgroundColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1).cgColor
//            topBorder.backgroundColor = UIColor.white.cgColor
        }else{
            topBorder.backgroundColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1).cgColor
//            topBorder.backgroundColor = UIColor.white.cgColor

        }

        tabBar.layer.addSublayer(topBorder)

        tabBar.clipsToBounds = true
        tabBar.isTranslucent = false
        


        let firstVC = FeedViewController()
        let secondVC = TrendingViewController()
//        let thirdVC = TopicViewController()
        let fourthVC = NotificationViewController()
//        let fifthVC = AccountViewController()
//        let userSettings = UIBarButtonItem(image: UIImage(named: "SettingsIcon"), style: .plain, target: self, action: nil)
//        fourthVC.navigationItem.rightBarButtonItem = userSettings
        
        let nav = generateNavController(vc: firstVC, title: "Feed")
        
        let nav2 = generateNavController(vc: secondVC, title: "Explore")
//        let nav3 = generateNavController(vc: thirdVC, title: "Topic")
        let nav4 = generateNavController(vc: fourthVC, title: "Activity")
//        let nav5 = generateNavController(vc: fifthVC, title:"Account")
        
        viewControllers = [nav, nav2, nav4]
        
    }
//    let blackWindow = UIView()
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if tabBar.selectedItem?.title == "Activity" {

//            generator.impactOccurred()
//                    if let window = UIApplication.shared.keyWindow{
//                        blackWindow.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height)
//                        blackWindow.backgroundColor = UIColor(white: 0, alpha: 0.5)
//                        blackWindow.alpha = 0
//                        view.addSubview(blackWindow)
//                        UIView.animate(withDuration: 0.2) {
//                            self.blackWindow.alpha = 1
//                        }
//            }
//            let transition = CATransition()
//            let vc = AccountViewController()
//
//
////            transition.type = CATransitionType.push
//            transition.subtype = CATransitionSubtype.fromLeft
//            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
//            vc.view.window?.layer.add(transition, forKey: kCATransition)
//
//            vc.delegate = self
//            vc.modalPresentationStyle = .overCurrentContext
//            self.present(vc, animated: false, completion: nil)
            let vc = LoadingTopicsScreen()
            vc.delegate = self
            self.tabBarController?.tabBar.isHidden = true
            present(vc, animated: true, completion: nil)

            return false
        } else {
            return true
        }
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("View: ", viewController)
//        if viewController == FeedViewController(){
//            let Controller = viewController as! FeedViewController
//            print("DOne", viewController, Controller)
//            showSpinner(onView: viewController.view)
//            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
//                self.removeSpinner()
//                Controller.collectionViewController.reloadData()
//            }
//        }
//        print(viewController)
//        if viewController == AccountViewController(){
//            print("BOOM")
//            present(AccountViewController(), animated: true)
//        }
        }

    
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//
//        }
    fileprivate func generateNavController(vc: UIViewController, title: String) -> UINavigationController {
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem.image = UIImage(named: title)
        navController.title = title

        
        
        return navController     }
}








class ProfileMenu: UIViewController{
   
    var delegate: blackViewProtocol?
    let realm2 = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(PanGestureFunc)))
        view.backgroundColor = .clear
        constraintContainer()
    }
    var viewTranslation = CGPoint(x: 0, y: 0)
    @objc func PanGestureFunc(sender: UIPanGestureRecognizer){
        switch sender.state {
        case .changed:
            viewTranslation = sender.translation(in: view)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut) {
                self.view.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
            } completion: { (_) in

            }
        case .ended:
            if viewTranslation.y < 200{
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut) {
                    self.view.transform = .identity
                } completion: { (_) in
                }
                
                if viewTranslation.y >= sender.translation(in: view).y{
                    print("HEHE")
                    break
                }

            }else {
                delegate?.changeBlackView()
                dismiss(animated: true, completion: nil)
            }
        default:
            break
        }
    }
    let MainWhiteView: CustomView = {
       let view = CustomView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        
//        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    fileprivate let viewBar: CustomView = {
        let view = CustomView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 3
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

//      INSIDE WHITE VIEW
//    fileprivate let textFieldView: CustomView = {
//       let view = CustomView()
//       view.backgroundColor = .white
//        view.layer.shadowColor = UIColor.lightGray.cgColor
//        view.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
//        view.layer.shadowRadius = 6.0
//        view.layer.shadowOpacity = 0.2
//       view.translatesAutoresizingMaskIntoConstraints = false
//       return view
//    }()

    fileprivate lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFill
        if realm2.objects(userObject.self)[0].image != nil{
            imageView.image = UIImage(data: realm2.objects(userObject.self)[0].image! as Data)
        }else{
            imageView.image = UIImage(named: "ProfileImage2")
//                UIImage(named: "placeholderProfileImage")
        }
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 100/2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    fileprivate lazy var username: CustomLabel = {
       let label = CustomLabel()
        label.attributedText = NSAttributedString(string: realm2.objects(userObject.self)[0].name, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 21, weight: .semibold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    fileprivate lazy var userHandle: CustomLabel = {
       let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "@"+realm2.objects(userObject.self)[0].username, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .semibold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


//

    
    fileprivate let addFriendBtn: UIButton = {
       let btn = UIButton()
        btn.backgroundColor = UIColor.white
        btn.setAttributedTitle(NSAttributedString(string: "New Friend", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)]), for: .normal)
        btn.addTarget(self, action: #selector(SendBtnSelected), for: .touchUpInside)
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        btn.layer.masksToBounds = false
        btn.layer.shadowColor = UIColor.darkGray.cgColor
        btn.layer.shadowOffset = CGSize(width: 0.0, height: 2)
        btn.layer.shadowRadius = 2
        btn.layer.shadowOpacity = 0.3
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    fileprivate let friendsBtn: UIButton = {
       let btn = UIButton()
        btn.backgroundColor = UIColor.white
        btn.setAttributedTitle(NSAttributedString(string: "Friends", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)]), for: .normal)
        btn.addTarget(self, action: #selector(SendBtnSelected), for: .touchUpInside)
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        btn.layer.masksToBounds = false
        btn.layer.shadowColor = UIColor.darkGray.cgColor
        btn.layer.shadowOffset = CGSize(width: 0.0, height: 2)
        btn.layer.shadowRadius = 2
        btn.layer.shadowOpacity = 0.3
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    fileprivate let requestBtn: UIButton = {
       let btn = UIButton()
        btn.backgroundColor = UIColor.white
        btn.setAttributedTitle(NSAttributedString(string: "Requests", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)]), for: .normal)
        btn.addTarget(self, action: #selector(SendBtnSelected), for: .touchUpInside)
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        btn.layer.masksToBounds = false
        btn.layer.shadowColor = UIColor.darkGray.cgColor
        btn.layer.shadowOffset = CGSize(width: 0.0, height: 2)
        btn.layer.shadowRadius = 2
        btn.layer.shadowOpacity = 0.3
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    fileprivate let editProfileBtn : UIButton = {
       let btn = UIButton()
        btn.backgroundColor = .white
        btn.setAttributedTitle(NSAttributedString(string: "Edit Profile", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)]), for: .normal)
        btn.addTarget(self, action: #selector(SendBtnSelected), for: .touchUpInside)
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        btn.layer.masksToBounds = false
        btn.layer.shadowColor = UIColor.darkGray.cgColor
        btn.layer.shadowOffset = CGSize(width: 0.0, height: 2)
        btn.layer.shadowRadius = 2
        btn.layer.shadowOpacity = 0.3
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    func constraintContainer(){
        view.addSubview(MainWhiteView)
        MainWhiteView.addSubview(profileImage)
        MainWhiteView.addSubview(username)
        MainWhiteView.addSubview(userHandle)

        MainWhiteView.addSubview(addFriendBtn)
        MainWhiteView.addSubview(friendsBtn)
        MainWhiteView.addSubview(requestBtn)
        MainWhiteView.addSubview(editProfileBtn)
        MainWhiteView.addSubview(viewBar)
        NSLayoutConstraint.activate([
            viewBar.topAnchor.constraint(equalTo: MainWhiteView.topAnchor, constant: 12),
            viewBar.widthAnchor.constraint(equalToConstant: 40),
            viewBar.heightAnchor.constraint(equalToConstant: 6),
            viewBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            MainWhiteView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            MainWhiteView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            MainWhiteView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            MainWhiteView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            profileImage.topAnchor.constraint(equalTo: viewBar.bottomAnchor, constant: 8),
            profileImage.leadingAnchor.constraint(equalTo: MainWhiteView.leadingAnchor, constant: 8),
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            profileImage.widthAnchor.constraint(equalToConstant: 100),
            
            
            username.topAnchor.constraint(equalTo: viewBar.bottomAnchor, constant: 8),
            username.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 8),
            username.trailingAnchor.constraint(equalTo: MainWhiteView.trailingAnchor, constant: -8),
            username.heightAnchor.constraint(equalToConstant: username.intrinsicContentSize.height),
            
//                userHandle.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 8),
            userHandle.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 8),
            userHandle.topAnchor.constraint(equalTo: username.bottomAnchor, constant: 2),
            userHandle.heightAnchor.constraint(equalToConstant: userHandle.intrinsicContentSize.height),
            

            //      INSIDE WHITE VIEW

            
            addFriendBtn.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 8),
            addFriendBtn.heightAnchor.constraint(equalToConstant: 40),
            addFriendBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            addFriendBtn.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -8),

            friendsBtn.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 8),
            friendsBtn.heightAnchor.constraint(equalToConstant: 40),
            friendsBtn.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 8),
            friendsBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            
            
            requestBtn.topAnchor.constraint(equalTo: friendsBtn.bottomAnchor, constant: 8),
            requestBtn.heightAnchor.constraint(equalToConstant: 40),
            requestBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            requestBtn.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -8),

            editProfileBtn.topAnchor.constraint(equalTo: friendsBtn.bottomAnchor, constant: 8),
            editProfileBtn.heightAnchor.constraint(equalToConstant: 40),
            editProfileBtn.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 8),
            editProfileBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
        ])
    }

    @objc func backgroundTapped(gesture: UIGestureRecognizer) {
        self.dismiss(animated: true)

    }
    
    
    @objc func SendBtnSelected(){
        
    }
    
    
    
    
}

















//          MARK: SEND POST
class sendPost: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var PostImage: UIImage?
    var listOfPosts = ["Done", "Done", "wow" , "does it matter", "what","listOfFriends", "check", "what", "opos", "da", "df"]
    var filteredData: [String]?
    var PostIDList: [String]?
    var selectedUsers = [String]()
    var delegate: blackViewProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        filteredData = listOfPosts
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(PanGestureFunc)))
        view.backgroundColor = .clear
//        PostImageView.image = PostImage
        constraintContainer()
//                userTableView.scrollToRow(at: NSIndexPath(row: 10, section: 0) as IndexPath, at: .bottom, animated: true)
    }
    var viewTranslation = CGPoint(x: 0, y: 0)
    @objc func PanGestureFunc(sender: UIPanGestureRecognizer){
        if sender.translation(in: view).y >= 0{
            switch sender.state {
            case .changed:
                viewTranslation = sender.translation(in: view)
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut) {
                    self.view.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
                } completion: { (_) in

                }
            case .ended:
                if viewTranslation.y < 200{
                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut) {
                        self.view.transform = .identity
                    } completion: { (_) in
                    }
                    
                    if viewTranslation.y >= sender.translation(in: view).y{
                        print("HEHE")
                        break
                    }

                }else {
                    delegate?.changeBlackView()
                    dismiss(animated: true, completion: nil)
                }
            default:
                break
            }
        }
    }
    let MainWhiteView: CustomView = {
       let view = CustomView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    fileprivate let viewBar: CustomView = {
        let view = CustomView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 3
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

//      INSIDE WHITE VIEW
//    fileprivate let textFieldView: CustomView = {
//       let view = CustomView()
//       view.backgroundColor = .white
//        view.layer.shadowColor = UIColor.lightGray.cgColor
//        view.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
//        view.layer.shadowRadius = 6.0
//        view.layer.shadowOpacity = 0.2
//       view.translatesAutoresizingMaskIntoConstraints = false
//       return view
//    }()
    fileprivate let textFieldView: CustomView = {
       let view = CustomView()
        view.layer.cornerRadius = 6
//       view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.lightGray.cgColor.copy(alpha: 0.3)
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 4
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()

//
    fileprivate let searchIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "searchIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    

    fileprivate let textField: UITextField = {
       let field = UITextField()
        field.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        field.placeholder = "Search"
        field.tintColor = .lightGray
        field.autocorrectionType = .no

        field.translatesAutoresizingMaskIntoConstraints = false
       return field
    }()
    
    fileprivate lazy var userTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.isScrollEnabled = true
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(SendPostCell.self, forCellReuseIdentifier: "SendPostCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    fileprivate let sendBtn: UIButton = {
       let btn = UIButton()
        btn.backgroundColor = TealConstantColor
        btn.setAttributedTitle(NSAttributedString(string: "Send", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .semibold)]), for: .normal)
        btn.addTarget(self, action: #selector(SendBtnSelected), for: .touchUpInside)
        
        btn.layer.shadowColor = UIColor.lightGray.cgColor
        btn.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        btn.layer.shadowRadius = 5.0
        btn.layer.shadowOpacity = 0.4
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    fileprivate let viewDesc: CustomLabel = {
       let label = CustomLabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedText = NSAttributedString(string: "Select the friends you would like to send this story to.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10, weight: .semibold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    func constraintContainer(){
        view.addSubview(MainWhiteView)
        MainWhiteView.addSubview(viewBar)
        MainWhiteView.addSubview(textFieldView)
        textFieldView.addSubview(searchIcon)
        textFieldView.addSubview(textField)
        MainWhiteView.addSubview(userTableView)
        MainWhiteView.addSubview(sendBtn)
        MainWhiteView.addSubview(viewDesc)
        NSLayoutConstraint.activate([
            
            MainWhiteView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            MainWhiteView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            MainWhiteView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            MainWhiteView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            viewBar.topAnchor.constraint(equalTo: MainWhiteView.topAnchor, constant: 12),
            viewBar.widthAnchor.constraint(equalToConstant: 40),
            viewBar.heightAnchor.constraint(equalToConstant: 6),
            viewBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //      INSIDE WHITE VIEW
            textFieldView.topAnchor.constraint(equalTo: viewBar.bottomAnchor, constant: 12),
            textFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            textFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            textFieldView.heightAnchor.constraint(equalToConstant:40),
            
            searchIcon.centerYAnchor.constraint(equalTo: textFieldView.centerYAnchor),
            searchIcon.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor, constant: 4),
            searchIcon.widthAnchor.constraint(equalTo: textFieldView.heightAnchor, constant: -16),
            searchIcon.heightAnchor.constraint(equalTo: textFieldView.heightAnchor, constant: -16),
            
            
            textField.topAnchor.constraint(equalTo: textFieldView.topAnchor, constant: 3),
            textField.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor, constant: 4),
            textField.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -8),
            textField.bottomAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: -3),
            
            userTableView.topAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: 8),
            userTableView.bottomAnchor.constraint(equalTo: sendBtn.topAnchor, constant: -8),
            userTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            sendBtn.bottomAnchor.constraint(equalTo: viewDesc.topAnchor, constant: -8),
            sendBtn.heightAnchor.constraint(equalToConstant: 40),
            sendBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            sendBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            viewDesc.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 8),
            viewDesc.widthAnchor.constraint(equalToConstant: 175),
            viewDesc.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
        ])
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
            let text = textField.text!
            filteredData = []
            PostIDList = []

        if listOfPosts.isEmpty == true{return}
            if text == ""{
                filteredData = listOfPosts
            }else{
                for i in 0...listOfPosts.count-1  {
                
                    if listOfPosts[i].contains((text.lowercased())) {
                        filteredData!.append(listOfPosts[i])
                }
            }
        }
        self.userTableView.reloadData()
    }
    @objc func backgroundTapped(gesture: UIGestureRecognizer) {
        self.dismiss(animated: true)

    }
    
    
    @objc func SendBtnSelected(){
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SendPostCell", for: indexPath) as! SendPostCell
        cell.selectionStyle = .none
        cell.tag = indexPath.row
        let item = filteredData![indexPath.row]
        
        
        if cell.tag == indexPath.row{
            if selectedUsers.contains(listOfPosts[indexPath.row]){
                cell.tintView.alpha = 1
            }else{
                cell.tintView.alpha = 0
                
            }
            
            cell.username.text = "Kevin hart"
            cell.activityLabel.text = "send to @kevinhart4real"


        }
            return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedUsers.contains(listOfPosts[indexPath.row]){
            selectedUsers.removeAll{ $0 == listOfPosts[indexPath.row] }
        }else{
            selectedUsers.append(listOfPosts[indexPath.row])
        }

        if selectedUsers.isEmpty == false{
            sendBtn.backgroundColor = TealConstantColor
        }else{
            sendBtn.backgroundColor = UIColor(red: 255/255, green: 173/255, blue: 173/255, alpha: 1)
        }
        print(selectedUsers)
        tableView.reloadData()
        }

    
}
class SendPostCell: UITableViewCell{

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        constraintContainer()
    }
    fileprivate let tintView: CustomView = {
       let view = CustomView()
        view.backgroundColor = TealConstantColor
        view.alpha = 0
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ProfileImage1")
        imageView.layer.cornerRadius = 45/2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
     let username: CustomLabel = {
        let label = CustomLabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let activityLabel: CustomLabel = {
        let label = CustomLabel()
        label.textColor = .lightGray
        label.text = "Send to"
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    fileprivate func constraintContainer(){
        
        
        self.addSubview(profileImage)
        self.addSubview(username)
        self.addSubview(activityLabel)
        self.addSubview(tintView)
        
        NSLayoutConstraint.activate([
            tintView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            tintView.widthAnchor.constraint(equalToConstant: 10),
            tintView.heightAnchor.constraint(equalToConstant: 10),
            tintView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),

            profileImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            profileImage.heightAnchor.constraint(equalToConstant: 45),
            profileImage.widthAnchor.constraint(equalToConstant: 45),
            
            username.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            username.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 12),
            username.trailingAnchor.constraint(equalTo: tintView.leadingAnchor,constant: -8),
            username.bottomAnchor.constraint(equalTo: profileImage.centerYAnchor),
            
            activityLabel.topAnchor.constraint(equalTo: profileImage.centerYAnchor),
            activityLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor,constant: 12),
            activityLabel.trailingAnchor.constraint(equalTo: tintView.leadingAnchor, constant: -8)
            
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}















//  MARK: NEWPOST VIEWCONTROLLER
class ExpandedPost: UIViewController, UIGestureRecognizerDelegate, blackViewProtocol{
    var url: String?
    var dateItem: String?
    let realmObjc = try! Realm()
    let blackWindow = UIView()
    func changeBlackView() {
        UIView.animate(withDuration: 0.3) {
            self.blackWindow.alpha = 0
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        title = "Post"
        view.backgroundColor = BlackBackgroundColor
        constraintContainer()

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
    
    fileprivate let mainViewCard: CustomView = {
        let view = CustomView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.layer.shadowColor = UIColor.lightGray.cgColor

        view.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        view.layer.shadowRadius = 5.0
        view.layer.shadowOpacity = 0.4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    fileprivate let TopicView: CustomView = {
       let view = CustomView()

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let TopicImage: CustomImageView2 = {
        let view = CustomImageView2()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .clear

        view.image = UIImage(named: "Music")
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
//        view.image = UIImage(named: "TopGradientImage")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()


     let TopicTitle: CustomLabel = {
        let label = CustomLabel()
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.attributedText = NSAttributedString(string: "-", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .semibold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let TopicDesc: CustomLabel = {
        let label = CustomLabel()
        label.numberOfLines = 4
//        label.adjustsFontSizeToFitWidth = true
//        label.backgroundColor = .cyan
        label.attributedText = NSAttributedString(string: "-", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .semibold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let PublicationName: CustomLabel = {
        let label = CustomLabel()
        label.attributedText = NSAttributedString(string:"-" , attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .semibold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    fileprivate let DoteSeperator: CustomLabel = {
        let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "•", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .semibold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let DateOfTopic: CustomLabel = {
        let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "-", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .semibold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
//    INTERACTIVE BUTTONS
    
//    let LikeButton: AnimationView = {
//      let animationView = AnimationView()
//       animationView.animation = Animation.named("6744-heart")
//       animationView.animationSpeed = 6
//
//       animationView.currentFrame = 4
//       animationView.translatesAutoresizingMaskIntoConstraints = false
//       return animationView
//   }()
    
    fileprivate let PostOptionsButton: UIButton = {
       let btn = UIButton()
        btn.setImage(UIImage(named: "MenuVerticalIcon"), for: .normal)
        btn.addTarget(self, action: #selector(SharePostSelected), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    fileprivate let instagramStoriesBtn: UIButton = {
       let btn = UIButton()
        btn.setImage(UIImage(named: "instagramStories"), for: .normal)
        btn.addTarget(self, action: #selector(instagramBtnSelected), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    fileprivate let instagramStoriesLabel: CustomLabel  = {
       let label = CustomLabel()
        label.numberOfLines = 2
        label.attributedText = NSAttributedString(string: "Add to Instagram Story", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10, weight: .semibold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

//
//    fileprivate let ShareButton: UIImageView = {
//       let imageView = UIImageView()
//        imageView.image = UIImage(named: "HeartIcon")
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()


    lazy var readButton: UIButton = {
       let btn = UIButton()
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 20
        btn.setAttributedTitle(NSAttributedString(string: "Read Article", attributes: [NSAttributedString.Key.foregroundColor: TealConstantColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .semibold)]), for: .normal)
        btn.addTarget(self, action: #selector(ReadArticleSelected), for: .touchUpInside)
        
        if realmObjc.objects(DarkMode.self)[0].isDarkMode != true{
            btn.layer.shadowColor = UIColor.lightGray.cgColor
            btn.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            btn.layer.shadowRadius = 5.0
            btn.layer.shadowOpacity = 0.4
        }
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    fileprivate lazy var postBtn: UIButton = {
       let btn = UIButton()
//        if realmObjc.objects(DarkMode.self)[0].isDarkMode{
            btn.setImage(UIImage(named: "newPost"), for: .normal)
//        }else{
//            btn.setImage(UIImage(named: "blackNewPost"), for: .normal)
//        }
        btn.addTarget(self, action: #selector(newPostBtnSelected), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    
    
    fileprivate lazy var sendBtn: UIButton = {
       let btn = UIButton()
//        if realmObjc.objects(DarkMode.self)[0].isDarkMode{
            btn.setImage(UIImage(named: "SendInApp"), for: .normal)
//        }else{
//            btn.setImage(UIImage(named: "blackSendInApp"), for: .normal)
//        }
        btn.addTarget(self, action: #selector(SendPostSelected), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
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
    
    
    func constraintContainer(){
        
        view.addSubview(mainViewCard)
        mainViewCard.addSubview(TopicImage)
        mainViewCard.addSubview(DimTopicLayer)
        
        mainViewCard.addSubview(TopicView)

            TopicView.addSubview(TopicTitle)
            TopicView.addSubview(TopicDesc)
        
            TopicView.addSubview(PublicationName)
            TopicView.addSubview(DoteSeperator)
            TopicView.addSubview(DateOfTopic)

        
//        TopicView.addSubview(LikeButton)
//        TopicView.addSubview(PostOptionsButton)
//
//        TopicView.addSubview(instagramStoriesBtn)
//        TopicView.addSubview(instagramStoriesLabel)
//
        mainViewCard.addSubview(PostOptionsButton)
        mainViewCard.addSubview(postBtn)
        mainViewCard.addSubview(sendBtn)
        mainViewCard.addSubview(instagramStoriesBtn)
        mainViewCard.addSubview(instagramStoriesLabel)
        view.addSubview(readButton)
        
        NSLayoutConstraint.activate([
            
            mainViewCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            mainViewCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainViewCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainViewCard.bottomAnchor.constraint(equalTo: readButton.topAnchor, constant: -8),
            
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

        
            
            
            
            TopicView.topAnchor.constraint(equalTo: mainViewCard.topAnchor, constant: 8),
            TopicView.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor),
            TopicView.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor),
            TopicView.bottomAnchor.constraint(equalTo: mainViewCard.bottomAnchor),
            
            TopicImage.topAnchor.constraint(equalTo: view.topAnchor, constant: -12),
            TopicImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            TopicImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            TopicImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 12),
            
            DimTopicLayer.topAnchor.constraint(equalTo: mainViewCard.topAnchor),
            DimTopicLayer.leadingAnchor.constraint(equalTo: TopicView.leadingAnchor),
            DimTopicLayer.trailingAnchor.constraint(equalTo: TopicView.trailingAnchor),
            DimTopicLayer.bottomAnchor.constraint(equalTo: mainViewCard.bottomAnchor),
            
            TopicTitle.topAnchor.constraint(equalTo: mainViewCard.topAnchor, constant: 12),
            TopicTitle.leadingAnchor.constraint(equalTo: TopicView.leadingAnchor, constant: 16),
            TopicTitle.trailingAnchor.constraint(equalTo: TopicView.trailingAnchor, constant: -8),

            TopicDesc.topAnchor.constraint(equalTo:TopicTitle.bottomAnchor ,constant: 8),
            TopicDesc.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor, constant: 16),
            TopicDesc.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor, constant: -16),
            
            PublicationName.topAnchor.constraint(equalTo: TopicDesc.bottomAnchor, constant: 8),
            PublicationName.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor, constant: 16),
            PublicationName.heightAnchor.constraint(equalToConstant: PublicationName.intrinsicContentSize.height),

            DoteSeperator.topAnchor.constraint(equalTo: TopicDesc.bottomAnchor, constant: 8),
            DoteSeperator.leadingAnchor.constraint(equalTo: PublicationName.trailingAnchor, constant: 4),
            DoteSeperator.heightAnchor.constraint(equalToConstant: DoteSeperator.intrinsicContentSize.height),

            
            DateOfTopic.topAnchor.constraint(equalTo: TopicDesc.bottomAnchor, constant: 8),
            DateOfTopic.leadingAnchor.constraint(equalTo: DoteSeperator.leadingAnchor, constant: 8),
            DateOfTopic.heightAnchor.constraint(equalToConstant: DateOfTopic.intrinsicContentSize.height),

            
            TopicDesc.topAnchor.constraint(equalTo:TopicTitle.bottomAnchor ,constant: -8),
            TopicDesc.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor, constant: 16),
            TopicDesc.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor, constant: -16),
            TopicDesc.heightAnchor.constraint(equalToConstant: 80),

            
//           BUTTON
                        postBtn.trailingAnchor.constraint(equalTo: sendBtn.leadingAnchor, constant: -14),
                        postBtn.centerYAnchor.constraint(equalTo: instagramStoriesBtn.centerYAnchor),
                        postBtn.heightAnchor.constraint(equalToConstant: 28),
                        postBtn.widthAnchor.constraint(equalToConstant: 28),

                        sendBtn.trailingAnchor.constraint(equalTo: PostOptionsButton.leadingAnchor, constant: -14),
                        sendBtn.bottomAnchor.constraint(equalTo: instagramStoriesBtn.bottomAnchor),
                        sendBtn.heightAnchor.constraint(equalToConstant: 28),
                        sendBtn.widthAnchor.constraint(equalToConstant: 28),

                        PostOptionsButton.centerYAnchor.constraint(equalTo: instagramStoriesBtn.centerYAnchor),
                        PostOptionsButton.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor, constant: -16),
                        PostOptionsButton.heightAnchor.constraint(equalToConstant: 32),
                        PostOptionsButton.widthAnchor.constraint(equalToConstant: 32),


                        instagramStoriesBtn.bottomAnchor.constraint(equalTo: mainViewCard.bottomAnchor, constant: -16),
                        instagramStoriesBtn.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor, constant: 16),
                        instagramStoriesBtn.heightAnchor.constraint(equalToConstant: 30),
                        instagramStoriesBtn.widthAnchor.constraint(equalToConstant: 30),

                        instagramStoriesLabel.leadingAnchor.constraint(equalTo: instagramStoriesBtn.trailingAnchor, constant: 8),
                        instagramStoriesLabel.centerYAnchor.constraint(equalTo: instagramStoriesBtn.centerYAnchor),
                        instagramStoriesLabel.widthAnchor.constraint(equalToConstant: 85),
            
            readButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            readButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            readButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            readButton.heightAnchor.constraint(equalToConstant: 40)
        ])

        
    }
    
//    @objc func likeButtonSelected(){
//        if LikeButton.currentFrame == 4{
//            for gesture in LikeButton.gestureRecognizers! {gesture.isEnabled = false}
//
//            LikeButton.play(fromFrame: 4, toFrame: 100, loopMode: .none, completion: nil)
//
////            ENABLE BUTTON
//            DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
//                for gesture in self.LikeButton.gestureRecognizers! {gesture.isEnabled = true}
//            }
//        }else{
//            for gesture in LikeButton.gestureRecognizers! {gesture.isEnabled = false}
//
//            LikeButton.play(fromFrame: 100, toFrame: 4, loopMode: .none, completion: nil)
//
//
////            ENABLE BUTTON
//            DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
//                for gesture in self.LikeButton.gestureRecognizers! {gesture.isEnabled = true}
//            }
//        }
//    }
    
    @objc func ReadArticleSelected(){
        if realmObjc.objects(AutoReaderMode.self)[0].isOn{
            let safariVC = SFSafariViewController(url: URL(string: url!)!, entersReaderIfAvailable: true)
            safariVC.preferredBarTintColor = .black
            safariVC.preferredControlTintColor = .white
            present(safariVC, animated: true, completion: nil)
        }else{
            let safariVC = SFSafariViewController(url: URL(string: url!)!, entersReaderIfAvailable: false)
            safariVC.preferredBarTintColor = .black
            safariVC.preferredControlTintColor = .white
            present(safariVC, animated: true, completion: nil)
        }
    }

    @objc func newPostBtnSelected(){
        let postObjc = PostObject()
        print(dateItem)
        postObjc.url = url!
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
        
        view.addSubview(savedLbl)
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
        let vc = LoadingTopicsScreen()
        vc.delegate = self
        self.tabBarController?.tabBar.isHidden = true
        present(vc, animated: true, completion: nil)
    }
    @objc func SharePostSelected(){
        let vc = UIActivityViewController(activityItems: [URL(string: url!)!], applicationActivities: [])
        vc.overrideUserInterfaceStyle = .dark
        present(vc, animated: true)
    }


    @objc func instagramBtnSelected(){
//        newPostDelegate?.PostInteraction(btnItem: 3,image: TopicImage.image, url: "Test", title: TopicTitle.text, description: TopicDesc.text!, date: dateItem, sourceName: PublicationName.text, imageURL: TopicImage.sd_imageURL?.absoluteString)
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
        vc.PostImage = TopicImage.image
        vc.Date = DateOfTopic.text
        vc.TitleText = TopicTitle.text
        vc.Publication = PublicationName.text
        vc.DescriptionText = TopicDesc.text
        vc.delegate = self

        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .overCurrentContext
        self.tabBarController?.tabBar.isHidden = true
        
        present(vc, animated: true, completion: nil)
    }
    
}





//  MARK: EditPorfileView VIEWCONTROLLER
class EditProfileView: UIViewController{
    let realm2 = try! Realm()
    var isProfileImageChanged = false
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Edit Profile"
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        let saveBtn = UIBarButtonItem(title:"Done", style: .done, target: self, action: #selector(SaveBtnSelected))
        saveBtn.tintColor = .lightGray
        navigationItem.rightBarButtonItem = saveBtn
        view.backgroundColor = .white
        constraintContainer()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = BlackBackgroundColor
        navigationController?.navigationBar.tintColor = subViewColor
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.setNavigationBarHidden(false, animated: animated)
//        navigationItem.backButtonTitle = ""
//        navigationController?.navigationBar.isHidden = false
    }
    
    fileprivate lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        if realm2.objects(userObject.self)[0].image != nil{
            imageView.image = UIImage(data: realm2.objects(userObject.self)[0].image! as Data)
        }else{
            imageView.image = UIImage(named: "placeholderProfileImage")
        }
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 55
        imageView.translatesAutoresizingMaskIntoConstraints = false
       return imageView
    }()
    
    fileprivate let changeProfileImage: UIButton = {
       let btn = UIButton()
        btn.setAttributedTitle(NSAttributedString(string: "Change Profile Image", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.systemBlue]), for: .normal)
        btn.titleLabel?.tintColor = .systemBlue
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel!.font = .systemFont(ofSize: 10, weight: .semibold)
        btn.addTarget(self, action: #selector(ChangeImageSelected), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    fileprivate let nameTitle:CustomLabel = {
        let label = CustomLabel()
        label.textColor = .lightGray
        label.text = "Name"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    fileprivate let textFieldView: CustomView = {
       let view = CustomView()
       view.backgroundColor = .white
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.layer.cornerRadius = 6
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()

    fileprivate lazy var textField: UITextField = {
       let field = UITextField()
        field.attributedText = NSAttributedString(string: realm2.objects(userObject.self)[0].name, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        
        field.tintColor = .lightGray
        field.autocorrectionType = .no

        field.translatesAutoresizingMaskIntoConstraints = false
       return field
    }()
    
//    USERNAME
    fileprivate let usernameTitle:CustomLabel = {
        let label = CustomLabel()
        label.textColor = .lightGray
        label.text = "Username"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    fileprivate let usernameTextFieldView: CustomView = {
       let view = CustomView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.layer.cornerRadius = 6
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()

    fileprivate lazy var usernameTextField: UITextField = {
       let field = UITextField()
        field.attributedText = NSAttributedString(string: realm2.objects(userObject.self)[0].username, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        field.tintColor = .lightGray
        field.autocorrectionType = .no

        field.translatesAutoresizingMaskIntoConstraints = false
       return field
    }()
    
    
    //    instagram user
    fileprivate let attachedAccounts: CustomLabel = {
        let label = CustomLabel()
        label.textColor = .lightGray
        label.text = "Attached Accounts"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
        fileprivate let instaTitle:CustomLabel = {
            let label = CustomLabel()
            label.textColor = .lightGray
            label.text = "Instagram Handler"
            label.font = .systemFont(ofSize: 14, weight: .semibold)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
    
    fileprivate let instaTextFieldView: CustomView = {
       let view = CustomView()
       view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.layer.cornerRadius = 6

//        view.layer.shadowColor = UIColor.lightGray.cgColor
//        view.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
//        view.layer.shadowRadius = 6.0
//        view.layer.shadowOpacity = 0.2
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()
        
        fileprivate let instaImageiew: UIImageView = {
           let view = UIImageView()
            view.image = UIImage(named: "instagramIcon")
           view.backgroundColor = .white
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
        }()

        fileprivate let instaTextField: UITextField = {
           let field = UITextField()
            field.attributedText = NSAttributedString(string: "kevin4real", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
            
            field.tintColor = .lightGray
            field.autocorrectionType = .no

            field.translatesAutoresizingMaskIntoConstraints = false
           return field
        }()
        
    
    
    func constraintContainer(){
        view.addSubview(profileImage)
        view.addSubview(changeProfileImage)
        view.addSubview(nameTitle)
        view.addSubview(textFieldView)
        textFieldView.addSubview(textField)
        
        view.addSubview(usernameTitle)
        view.addSubview(usernameTextFieldView)
        usernameTextFieldView.addSubview(usernameTextField)
        
        view.addSubview(attachedAccounts)
        view.addSubview(instaTitle)
        view.addSubview(instaImageiew)
        view.addSubview(instaTextFieldView)
        instaTextFieldView.addSubview(instaTextField)
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.heightAnchor.constraint(equalToConstant: 110),
            profileImage.widthAnchor.constraint(equalToConstant: 110),
            

            changeProfileImage.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 8),
            changeProfileImage.centerXAnchor.constraint(equalTo: profileImage.centerXAnchor),
            
            nameTitle.topAnchor.constraint(equalTo: changeProfileImage.bottomAnchor, constant: 8),
            nameTitle.bottomAnchor.constraint(equalTo: textFieldView.topAnchor, constant: -8),
            nameTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 12),
            
            textFieldView.topAnchor.constraint(equalTo: nameTitle.bottomAnchor, constant: 8),
            textFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            textFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            textFieldView.heightAnchor.constraint(equalToConstant:38),
            
            textField.topAnchor.constraint(equalTo: textFieldView.topAnchor, constant: 3),
            textField.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -8),
            textField.bottomAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: -3),
            
            
//            USERNAME
            usernameTitle.topAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: 16),
            usernameTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            
            usernameTextFieldView.topAnchor.constraint(equalTo: usernameTitle.bottomAnchor, constant: 4),
            usernameTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            usernameTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            usernameTextFieldView.heightAnchor.constraint(equalToConstant:38),

            
            usernameTextField.topAnchor.constraint(equalTo: usernameTextFieldView.topAnchor, constant: 3),
            usernameTextField.leadingAnchor.constraint(equalTo: usernameTextFieldView.leadingAnchor, constant: 8),
            usernameTextField.trailingAnchor.constraint(equalTo: usernameTextFieldView.trailingAnchor, constant: -8),
            usernameTextField.bottomAnchor.constraint(equalTo: usernameTextFieldView.bottomAnchor, constant: -3),
            
//            instagram user
            
            attachedAccounts.topAnchor.constraint(equalTo: usernameTextFieldView.bottomAnchor, constant: 24),
            attachedAccounts.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            

//            instaImageiew.topAnchor.constraint(equalTo: attachedAccounts.bottomAnchor, constant: 16),
            instaImageiew.centerYAnchor.constraint(equalTo: instaTextFieldView.centerYAnchor),
            instaImageiew.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            instaImageiew.heightAnchor.constraint(equalToConstant: 32),
            instaImageiew.widthAnchor.constraint(equalToConstant: 32),
            
            instaTitle.topAnchor.constraint(equalTo: attachedAccounts.bottomAnchor, constant: 14),
            instaTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),

            instaTextFieldView.topAnchor.constraint(equalTo: instaTitle.bottomAnchor, constant: 4),
            instaTextFieldView.leadingAnchor.constraint(equalTo: instaImageiew.trailingAnchor, constant: 12),
            instaTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            instaTextFieldView.heightAnchor.constraint(equalToConstant:38),

            
            instaTextField.topAnchor.constraint(equalTo: instaTextFieldView.topAnchor, constant: 3),
            instaTextField.leadingAnchor.constraint(equalTo: instaTextFieldView.leadingAnchor, constant: 8),
            instaTextField.trailingAnchor.constraint(equalTo: instaTextFieldView.trailingAnchor, constant: -8),
            instaTextField.bottomAnchor.constraint(equalTo: instaTextFieldView.bottomAnchor, constant: -3),
            

        ])

    }
    
    @objc func ChangeImageSelected(){
        let pickerController = UIImagePickerController()
        pickerController.allowsEditing = true
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        self.present(pickerController, animated: true, completion: nil)
    }
    
    @objc func SaveBtnSelected(){
        guard let url = URL(string: "https://instagram.com/caleb.mesfien")  else { return }
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        for letter in string{
            for i in "/:;()$&@\",?!'[]{}#%^*+=\\|~<>€£¥•,?!'"{
                if letter == i{
                    return false
                }
            }
        }
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count

        return count <= 28
    }
}
extension EditProfileView: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            self.profileImage.image = image
            self.isProfileImageChanged = true
            dismiss(animated: true, completion: nil)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}








//  MARK: WEBVIEW VIEWCONTROLLER


//      MARK: NEWPOST VIEWCONTROLLER
class PostTypeSelection: UIViewController {
    var delegate: blackViewProtocol?
    var selectedOptions: PostOption?
    var attachedImage: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        constraintContainer()
    }


    
    fileprivate let whiteView: CustomView = {
        let view = CustomView()
        view.backgroundColor = .white
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let viewBar: CustomView = {
        let view = CustomView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 3
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let viewTitle: CustomLabel = {
        let label = CustomLabel()
        label.textAlignment = .center
        label.attributedText = NSAttributedString(string: "Post", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22)])
        
        label.translatesAutoresizingMaskIntoConstraints  = false
        return label
    }()
    
    
    fileprivate let viewDescription: CustomLabel = {
        let label = CustomLabel()
        label.numberOfLines = 2
        label.attributedText = NSAttributedString(string: "Would you like to post as is, or add a caption?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)])
        
        label.translatesAutoresizingMaskIntoConstraints  = false
        return label
    }()
    

    
    fileprivate let repostBtn: UIButton = {
        let button  = UIButton()
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.setAttributedTitle(NSAttributedString(string: "Repost", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]), for: .normal)
        button.addTarget(self, action: #selector(repostBtnSelected), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    fileprivate let appleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "RepostIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
       return imageView
    }()

    
    fileprivate let newPostBtn: UIButton = {
        let button  = UIButton()
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.setAttributedTitle(NSAttributedString(string: "New Post", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]), for: .normal)

        button.addTarget(self, action: #selector(newPostBtnSelected), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    fileprivate let emailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "NewPostIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
       return imageView
    }()

    private func constraintContainer(){
        
        view.addSubview(whiteView)
            whiteView.addSubview(viewBar)
            whiteView.addSubview(viewTitle)
            whiteView.addSubview(viewDescription)
        
        whiteView.addSubview(repostBtn)
            repostBtn.addSubview(appleImageView)
        whiteView.addSubview(newPostBtn)
            newPostBtn.addSubview(emailImageView)
        
        
        NSLayoutConstraint.activate([
            viewBar.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 8),
            viewBar.widthAnchor.constraint(equalToConstant: 40),
            viewBar.heightAnchor.constraint(equalToConstant: 6),
            viewBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            whiteView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            whiteView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            whiteView.heightAnchor.constraint(equalToConstant: 220),
            whiteView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            viewTitle.topAnchor.constraint(equalTo: viewBar.topAnchor, constant: 8),
            viewTitle.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 16),
            viewTitle.heightAnchor.constraint(equalToConstant: viewTitle.intrinsicContentSize.height),
            
            viewDescription.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 8),
            viewDescription.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 16),
            viewDescription.widthAnchor.constraint(equalTo: whiteView.widthAnchor),
            
            repostBtn.topAnchor.constraint(equalTo: viewDescription.bottomAnchor, constant: 16),
            repostBtn.leadingAnchor.constraint(equalTo:whiteView.leadingAnchor, constant: 16),
            repostBtn.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -16),
            repostBtn.heightAnchor.constraint(equalToConstant: 30),

        
            newPostBtn.topAnchor.constraint(equalTo: repostBtn.bottomAnchor, constant: 16),
            newPostBtn.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 16),
            newPostBtn.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -16),
            newPostBtn.heightAnchor.constraint(equalToConstant: 30),
            

 
            emailImageView.centerYAnchor.constraint(equalTo: newPostBtn.centerYAnchor),
            emailImageView.heightAnchor.constraint(equalToConstant: 19),
            emailImageView.widthAnchor.constraint(equalToConstant: 19),
            emailImageView.leadingAnchor.constraint(equalTo: newPostBtn.leadingAnchor, constant: 8),
                
            appleImageView.centerYAnchor.constraint(equalTo: repostBtn.centerYAnchor),
            appleImageView.heightAnchor.constraint(equalToConstant: 19),
            appleImageView.widthAnchor.constraint(equalToConstant: 19),
            appleImageView.leadingAnchor.constraint(equalTo: repostBtn.leadingAnchor, constant: 8),
            

            
            
        ])
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }

    
    @objc func backgroundTapped(gesture: UIGestureRecognizer) {
        delegate?.changeBlackView()
        self.dismiss(animated: true)
        
    }
    
    @objc func repostBtnSelected(){
        self.delegate?.changeBlackView()
        dismiss(animated: true){
            
            self.selectedOptions?.option(0, image: self.attachedImage!)
        }
    }
    @objc func newPostBtnSelected(){
        self.delegate?.changeBlackView()
        dismiss(animated: true){
            self.selectedOptions?.option(1, image: self.attachedImage!)
        }
    }


}

class NewPostView: UIViewController, UITextViewDelegate {
    var delegate: blackViewProtocol?
    let realmObjc = try! Realm()
    
    var url = String()
    var titleText = String()
    var desc = String()
    var date = String()
    var source_name = String()
    var image = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(PanGestureFunc)))

        constraintContainer()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textView.becomeFirstResponder()
    }
    let MainWhiteView: CustomView = {
       let view = CustomView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    fileprivate let viewBar: CustomView = {
        let view = CustomView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 3
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    fileprivate let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.image = UIImage(named: "ProfileImage1")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 55/2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    fileprivate let username: CustomLabel = {
       let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "Elon Musk", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    fileprivate let userHandle: CustomLabel = {
       let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "@elon4real", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .semibold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let postBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = TealConstantColor
        btn.setAttributedTitle(NSAttributedString(string: "Post", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)]), for: .normal)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 2
        btn.addTarget(self, action: #selector(PostSelected), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
     lazy var textView: UITextView = {
       let textView = UITextView()
//        textView.text = "Anything to add..."
        textView.keyboardAppearance = .dark
        textView.font = .systemFont(ofSize: 16, weight: .semibold)
        textView.textColor = .black
        textView.delegate = self
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    fileprivate let countabel: CustomLabel = {
       let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "0/280", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .semibold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let articleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func constraintContainer(){
        view.addSubview(MainWhiteView)
        MainWhiteView.addSubview(viewBar)
        MainWhiteView.addSubview(profileImage)
        MainWhiteView.addSubview(username)
        MainWhiteView.addSubview(userHandle)
        MainWhiteView.addSubview(postBtn)
        MainWhiteView.addSubview(countabel)
        MainWhiteView.addSubview(textView)
        MainWhiteView.addSubview(articleImage)
        
        NSLayoutConstraint.activate([
            MainWhiteView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            MainWhiteView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            MainWhiteView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            MainWhiteView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            viewBar.topAnchor.constraint(equalTo: MainWhiteView.topAnchor, constant: 12),
            viewBar.widthAnchor.constraint(equalToConstant: 40),
            viewBar.heightAnchor.constraint(equalToConstant: 6),
            viewBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            profileImage.topAnchor.constraint(equalTo: viewBar.topAnchor, constant: 8),
            profileImage.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 12),
            profileImage.widthAnchor.constraint(equalToConstant: 55),
            profileImage.heightAnchor.constraint(equalToConstant: 55),
            
            username.topAnchor.constraint(equalTo: profileImage.topAnchor),
            username.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor,constant: 4),
            username.trailingAnchor.constraint(equalTo: postBtn.leadingAnchor,constant: -4),
        
            userHandle.topAnchor.constraint(equalTo: username.bottomAnchor),
            userHandle.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 4),
            userHandle.trailingAnchor.constraint(equalTo: postBtn.leadingAnchor,constant: -4),
    
            postBtn.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor),
//            postBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            postBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            postBtn.heightAnchor.constraint(equalToConstant: postBtn.intrinsicContentSize.height),
            postBtn.widthAnchor.constraint(equalToConstant: postBtn.intrinsicContentSize.width+20),

            
            textView.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 8),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            textView.trailingAnchor.constraint(equalTo: articleImage.trailingAnchor, constant: -12),
            textView.heightAnchor.constraint(equalToConstant: 154),
            
            countabel.topAnchor.constraint(equalTo: textView.bottomAnchor),
            countabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            
            articleImage.topAnchor.constraint(equalTo: countabel.bottomAnchor, constant: 8),
            articleImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.68),
            articleImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            articleImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])

    }
    var viewTranslation = CGPoint(x: 0, y: 0)

    @objc func PanGestureFunc(sender: UIPanGestureRecognizer){
        switch sender.state {
        case .changed:
            viewTranslation = sender.translation(in: view)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut) {
                self.view.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
            } completion: { (_) in

            }
        case .ended:
            if viewTranslation.y < 200{
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut) {
                    self.view.transform = .identity
                } completion: { (_) in
                }

            }else {
                delegate?.changeBlackView()
                dismiss(animated: true, completion: nil)
            }
        default:
            break
        }
    }
    
    @objc func PostSelected(){
        let doc = db.collection("posts").document()
            doc.setData([
                "userID":realmObjc.objects(userObject.self)[0].Id,
                
                "url" : url,
                "title" : titleText,
                "desc" : desc,
                "date" : date,
                "source_name" : source_name,
                "image" : image
            ])
        
        let postObjc = PostObject()
        postObjc.docID = doc.documentID
        postObjc.url = url
        postObjc.title = titleText
        postObjc.desc = desc
        postObjc.date = date
        postObjc.source_name = source_name
        postObjc.image = image
        
        try! realmObjc.write{
            realmObjc.add(postObjc)
        }
        delegate?.changeBlackView()
        dismiss(animated: true, completion: nil)
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if text.last == "\n" { //Check if last char is newline
                return false
            }
        // get the current text, or use an empty string if that failed
        let currentText = textView.text ?? ""

        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }

        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)

        // make sure the result is under 280 characters
        countabel.text = "\(textView.text.count)/280"
        return updatedText.count <= 280
    }
}








