//
//  UserAccountViews.swift
//  NewsTestApp
//
//  Created by Caleb Mesfien on 11/16/20.
//

import UIKit
import Lottie
import RealmSwift














let sideBarB1 = ["Edit", "Friends", "Favorites", "Add Friends", "Settings"]
let sideBarImage = ["slideTabPost", "slideTabInterests", "slideTabFavorites", "slideTabAddFriend", "slideTabSettings"]
extension AccountViewController: UITableViewDelegate, UITableViewDataSource{

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideBarB1.count
    }
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 1{
            return 52
        }
//        return 50
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sideBarCell", for: indexPath) as! sideBarCell
        
        cell.cellLabel.text = sideBarB1[indexPath.row]
        cell.IconImaage.image = UIImage(named: sideBarImage[indexPath.row])
        
        if indexPath.section == 0{
            cell.cellLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        } else if indexPath.section == 1{
            cell.cellLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true) {
            self.MenuItemDelegate?.ItemSelected(indexPath.row)
        }
        if indexPath.section == 1{
//        switch indexPath.row{
//            case 1:
//                let view = SKStoreProductViewController()
//                view.delegate = self as? SKStoreProductViewControllerDelegate
//
//                view.loadProduct(withParameters: [SKStoreProductParameterITunesItemIdentifier: 1539330378])
//                            present(view, animated: true, completion: nil)
//            case 2:
//                let vc = AboutView()
//                present(vc, animated: true)
//            case 4:
//                generator.impactOccurred()
//                        if let window = UIApplication.shared.keyWindow{
//                            blackWindow.frame = window.frame
//                            blackWindow.backgroundColor = UIColor(white: 0, alpha: 0.5)
//                            blackWindow.alpha = 0
//
//                            view.addSubview(blackWindow)
//
//                            UIView.animate(withDuration: 0.5) {
//                                self.blackWindow.alpha = 1
//                            }
//                }
//                let vc = LogoutConfirmation()
//                vc.modalPresentationStyle = .overCurrentContext
//                vc.delegate = self
//                vc.logoutDelegate = self
//
//
//                navigationController?.present(vc, animated: true)
//                default:
//                    print("nil")
//            }
        }
    }
    
}


class sideBarCell: UITableViewCell{
//    var interactiveCell = false {
//        didSet{
//            if interactiveCell == true{
//                self.addSubview(arrowImage)
//
//                NSLayoutConstraint.activate([
//                    arrowImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
//                    arrowImage.heightAnchor.constraint(equalToConstant: 18),
//                    arrowImage.widthAnchor.constraint(equalToConstant: 18),
//                    arrowImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//                ])
//
//            }
//        }
//    }
//    var cellResponseActive = false {
//        didSet{
//            if cellResponseActive == true{
//                self.addSubview(cellResponse)
//
//                NSLayoutConstraint.activate([
//                    cellResponse.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
//                    cellResponse.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//                    cellResponse.leadingAnchor.constraint(equalTo: cellLabel.trailingAnchor, constant: 8)
//                ])
//
//            }
//        }
//    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        
        constraintContainer()
    }
    
    
    fileprivate let cellLabel: CustomLabel = {
       let label = CustomLabel()
//        label.font =
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    fileprivate let IconImaage: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "BlackRightArrow")
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate let cellResponse: CustomLabel = {
       let label = CustomLabel()
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate func constraintContainer(){
        self.addSubview(cellLabel)
        self.addSubview(IconImaage)
        NSLayoutConstraint.activate([
            IconImaage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            IconImaage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            IconImaage.heightAnchor.constraint(equalToConstant: 28),
            IconImaage.widthAnchor.constraint(equalToConstant: 28),
            
            cellLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cellLabel.leadingAnchor.constraint(equalTo: IconImaage.trailingAnchor, constant: 12),
//            cellLabel.widthAnchor.constraint(equalToConstant: 115)
        
        ])
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



protocol scrollViewPro {
    func scroll(at: CGFloat)
}




class AccountViewController: UIViewController,exapndAccountPosts, scrollViewPro  {
    let maxMainViewHeight: CGFloat = 180
    
    func scroll(at: CGFloat) {
        let newViewHeight: CGFloat = mainViewHeight!.constant - at
//        mainView.alpha = 1
        if newViewHeight > maxMainViewHeight{
            mainViewHeight?.constant = maxMainViewHeight
        }else if mainViewHeight!.constant < 0{
            mainViewHeight?.constant = 0
        }else{
            mainView.alpha = 1-at/20
            mainViewHeight?.constant = newViewHeight
        }

//        if mainViewHeight!.constant == 0 || mainViewHeight!.constant == 180{
//                    MainCollectionView.reloadData()
//        }

//        mainViewHeight?.constant = mainViewHeight!.constant-at
    }
    var delegate: blackViewProtocol?
    var MenuItemDelegate: MenuProtocol?
    var mainViewHeight: NSLayoutConstraint?
    
    let realm2 = try! Realm()
    func expandPost(title: String, url: String, desc: String, provider: String, date: String) {
        
    }
//    let realmObjc = try
    func expandPost() {
        let vc = ExpandedPost()
        vc.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.navigationBar.barTintColor = .white
//        navigationController?.navigationBar.isTranslucent = false
//        navigationItem.backButtonTitle = ""
//        navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")


        
//        let userSettings = UIBarButtonItem(image: UIImage(named: "SettingsIcon"), style: .plain, target: self, action: #selector(UserSettingsSelected))
//        let addFriends = UIBarButtonItem(image: UIImage(named: "AddFriend"), style: .plain, target: self, action: #selector(UserSettingsSelected))

//        addFriends.tintColor = .black
//
//        navigationItem.rightBarButtonItem = userSettings
//        navigationItem.leftBarButtonItem = addFriends

//        title = "Account"
//        view.backgroundColor = .
        
        constraintContainer()


        
//        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(PanGestureFunc)))

//                userTableView.scrollToRow(at: NSIndexPath(row: 10, section: 0) as IndexPath, at: .bottom, animated: true)
    }
//    var viewTranslation = CGPoint(x: 0, y: 0)
//    @objc func PanGestureFunc(sender: UIPanGestureRecognizer){
//
//        switch sender.state {
//        case .changed:
//
//            viewTranslation = sender.translation(in: view)
//            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut) {
//                self.view.transform = CGAffineTransform(translationX: self.viewTranslation.x, y: 0)
//            } completion: { (_) in
//
//            }
//        case .ended:
//            if viewTranslation.x < -UIScreen.main.bounds.width{
//                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut) {
//                    self.view.transform = .identity
//                } completion: { (_) in
//                }
//
//                if viewTranslation.x >= sender.translation(in: view).x{
//                    break
//                }
//
//            }else {
//                UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut) {
//                    self.view.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
//                } completion: { (_) in
//                }
//                self.delegate?.changeBlackView()
//                DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
//                    self.dismiss(animated: true, completion: nil)
//                }
//
//
//            }
//        default:
//            break
//        }
//    }
        

        
        
        
        
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .black
        if realm2.objects(DarkMode.self)[0].isDarkMode{
            UIApplication.shared.statusBarStyle = .lightContent
        }else{
            UIApplication.shared.statusBarStyle = .darkContent
        }
    }


    lazy var stackOptionCollectionView: AccountStackPrefrence = {
        let AccountStack = AccountStackPrefrence()
        AccountStack.translatesAutoresizingMaskIntoConstraints = false
        AccountStack.AccountViewControllerItem = self
        return AccountStack
    }()

//    fileprivate lazy var MainCollectionView: UICollectionView = {
//       let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.minimumLineSpacing = 0
////        layout.sectionInset = UIEdgeInsets(top: mainViewHeight!.constant, left: 0, bottom: 0, right: 0)
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.isPagingEnabled = true
//        collectionView.backgroundColor = .white
////        collectionView.bounces = false
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.register(collectionStackViewCell.self, forCellWithReuseIdentifier: "collectionOfStackViews")
//        collectionView.register(fullSizePost.self, forCellWithReuseIdentifier: "fullItemViews")
//        collectionView.register(collectionStackViewCellInterest.self, forCellWithReuseIdentifier: "collectionStackViewCellInterest")
////        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "MainCollectionViewCell")
////        collectionView.register(profileInfoHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "profileInfoHeader")
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        return collectionView
//    }()
    
    let lineViewIntrests: CustomView = {
       let view = CustomView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    private let refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshGroupList(_:)), for: .valueChanged)
        refresh.layoutIfNeeded()
        refresh.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)

        return refresh
    }()
    
    let mainView: CustomView = {
        let view = CustomView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
//        view.layer.shadowColor = UIColor.lightGray.cgColor
//        view.layer.shadowOffset = CGSize(width: 0.0, height: -3.0)
//        view.layer.shadowRadius = 8.0
//        view.layer.shadowOpacity = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    fileprivate lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFill
//        if realm2.objects(userObject.self)[0].image != nil{
//            imageView.image = UIImage(data: realm2.objects(userObject.self)[0].image! as Data)
//        }else{
//            imageView.image = UIImage(named: "ProfileImage2")
//        }
        imageView.image = UIImage(named: "placeholderProfileImage")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 100/2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    fileprivate lazy var username: CustomLabel = {
       let label = CustomLabel()
        label.attributedText = NSAttributedString(string: realm2.objects(userObject.self)[0].name, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 21, weight: .semibold)])
//        label.attributedText = NSAttributedString(string: "user392571950", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 21, weight: .semibold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    fileprivate lazy var userHandle: CustomLabel = {
       let label = CustomLabel()
//        label.attributedText = NSAttributedString(string: "@"+realm2.objects(userObject.self)[0].username, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .semibold)])
        label.attributedText = NSAttributedString(string: "@user392571950", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .semibold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

//    fileprivate let mainUserInfoStack: UIStackView = {
//        let stack = UIStackView()
//        stack.axis = .vertical
//        stack.distribution = .fill
//        stack.spacing = 2.0
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        return stack
//    }()
    
    fileprivate let userInfoStackTitle: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.spacing = 26.0

        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let userInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.spacing = 26.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    fileprivate let followersTextTitle: CustomLabel = {
       let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "Followers", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)])
//        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let followingTextTitle: CustomLabel = {
       let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "Following", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)])
//        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let likesTextTitle: CustomLabel = {
       let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "Posts", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)])
//        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var followersText: CustomLabel = {
       let label = CustomLabel()
        label.attributedText = NSAttributedString(string: String(realm2.objects(userObject.self)[0].followerCount), attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)])
//        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var followingText: CustomLabel = {
       let label = CustomLabel()
        label.attributedText = NSAttributedString(string: String(realm2.objects(userObject.self)[0].followingCount), attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)])
//        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var likesText: CustomLabel = {
       let label = CustomLabel()
//        label.textAlignment = .center
        label.attributedText = NSAttributedString(string:"0", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    fileprivate let activityButton: UIButton = {
//       let button = UIButton()
//        button.setAttributedTitle(NSAttributedString(string: "Edit", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .bold)]), for: .normal)
//        button.addTarget(self, action: #selector(EditProfileSelected), for: .touchUpInside)
//        button.backgroundColor = .clear
//        button.layer.borderWidth = 1.5
//        button.layer.borderColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1).cgColor
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    
    
    fileprivate let shareAccountButton: UIButton = {
       let button = UIButton()

        button.setImage(UIImage(named: "blackShareIcon"), for: .normal)
        button.backgroundColor = .clear

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
//
    fileprivate lazy var settingsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(sideBarCell.self, forCellReuseIdentifier: "sideBarCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    
    fileprivate lazy var versionLbl: UIButton = {
       let label = UIButton()
        label.setAttributedTitle(NSAttributedString(string:"v1.000.001", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .bold)]), for: .normal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var TermsOfUseLbl: UIButton = {
       let label = UIButton()
        label.setAttributedTitle(NSAttributedString(string:"Terms & Conditions", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)]), for: .normal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var PrivacyPolicyLbl: UIButton = {
       let label = UIButton()
        label.setAttributedTitle(NSAttributedString(string:"Privacy Policy", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)]), for: .normal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lineView: UIView = {
       let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    fileprivate func constraintContainer(){
        mainViewHeight =  mainView.heightAnchor.constraint(equalToConstant: 180)
        
//        view.addSubview(lineView)
        view.addSubview(mainView)
                
        view.addSubview(stackOptionCollectionView)
//
        mainView.addSubview(profileImage)
        mainView.addSubview(username)
        mainView.addSubview(userHandle)
        
        view.addSubview(lineViewIntrests)

//        mainView.addSubview(mainUserInfoStack)
//        mainUserInfoStack.addArrangedSubview(userInfoStack)
//        mainUserInfoStack.addArrangedSubview(userInfoStackTitle)

        userInfoStackTitle.addArrangedSubview(followersTextTitle)
        userInfoStackTitle.addArrangedSubview(followingTextTitle)
        userInfoStackTitle.addArrangedSubview(likesTextTitle)

        userInfoStack.addArrangedSubview(followersText)
//        userInfoStack.
        userInfoStack.addArrangedSubview(followingText)
        userInfoStack.addArrangedSubview(likesText)
        
//        mainView.addSubview(activityButton)
        mainView.addSubview(shareAccountButton)
        
        
        mainView.addSubview(settingsTableView)
        
        mainView.addSubview(TermsOfUseLbl)
        mainView.addSubview(PrivacyPolicyLbl)
        mainView.addSubview(versionLbl)

//        stackOptionCollectionView)
//        view.addSubview(MainCollectionView)
        view.addSubview(stackOptionCollectionView)

        

        NSLayoutConstraint.activate([
            lineViewIntrests.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lineViewIntrests.heightAnchor.constraint(equalToConstant: 0.5),
            lineViewIntrests.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lineViewIntrests.topAnchor.constraint(equalTo: mainView.bottomAnchor),
            
            
            stackOptionCollectionView.topAnchor.constraint(equalTo: lineViewIntrests.bottomAnchor),
            stackOptionCollectionView.heightAnchor.constraint(equalToConstant: 44),
            stackOptionCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackOptionCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            stackOptionCollectionView.widthAnchor.con
//
//
//            MainCollectionView.topAnchor.constraint(equalTo: stackOptionCollectionView.bottomAnchor),
//            MainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            MainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            MainCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
//            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
//            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            mainViewHeight!,
//            lineView.widthAnchor.constraint(equalToConstant: 0.5),
//            lineView.topAnchor.constraint(equalTo: view.topAnchor),
//            lineView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            lineView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.widthAnchor.constraint(equalTo: view.widthAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

                profileImage.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8),
                profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
                profileImage.heightAnchor.constraint(equalToConstant: 100),
                profileImage.widthAnchor.constraint(equalToConstant: 100),



////                mainUserInfoStack.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -8),
//                mainUserInfoStack.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
//                mainUserInfoStack.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 26),
////                mainUserInfoStack.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -12),
////                mainUserInfoStack.heightAnchor.constraint(equalToConstant: 40),
                
                
                username.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 8),
                username.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor),
                username.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -8),
                username.heightAnchor.constraint(equalToConstant: username.intrinsicContentSize.height),
                
//                userHandle.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 8),
                userHandle.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor),
                userHandle.topAnchor.constraint(equalTo: username.bottomAnchor, constant: 2),
                userHandle.heightAnchor.constraint(equalToConstant: userHandle.intrinsicContentSize.height),
                
//                joinedDate.topAnchor.constraint(equalTo: profileImage.bottomAnchor,constant: 8),
//                joinedDate.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 12),
//                joinedDate.heightAnchor.constraint(equalToConstant: joinedDate.intrinsicContentSize.height),
                
//                activityButton.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor),
//                activityButton.widthAnchor.constraint(equalToConstant: 100),
//                activityButton.trailingAnchor.constraint(equalTo: shareAccountButton.leadingAnchor, constant: -16),
//                activityButton.heightAnchor.constraint(equalToConstant: 32),
//
//
                shareAccountButton.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor),
                shareAccountButton.widthAnchor.constraint(equalToConstant: 28),
                shareAccountButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -8),
                shareAccountButton.heightAnchor.constraint(equalToConstant: 28),
            
            settingsTableView.topAnchor.constraint(equalTo: userHandle.bottomAnchor, constant: 8),
            settingsTableView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            settingsTableView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            settingsTableView.bottomAnchor.constraint(equalTo: versionLbl.topAnchor, constant: -8),
            
            

            
            PrivacyPolicyLbl.bottomAnchor.constraint(equalTo:TermsOfUseLbl.topAnchor, constant: -4 ),
            PrivacyPolicyLbl.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 12),

            TermsOfUseLbl.bottomAnchor.constraint(equalTo:versionLbl.topAnchor, constant: -8),
            TermsOfUseLbl.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 12),

            versionLbl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            versionLbl.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),

        ])
    }
    
    
    @objc func UserSettingsSelected(){
        let vc = UserSettings()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func instaBtnSelected(){
        guard let url = URL(string: "https://instagram.com/caleb.mesfien")  else { return }
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    @objc func EditProfileSelected(){
        let vc = EditProfileView()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func refreshGroupList(_ sender: UIRefreshControl) {
//        MainCollectionView.reloadData()
        collectionStackViewCell().recentCollectionView.reloadData()
        collectionStackViewCell().recentCollectionView.layoutSubviews()
        collectionStackViewCell().layoutIfNeeded()
//        MainCollectionView.layoutSubviews()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.6, execute: {
            sender.endRefreshing()

        })
    }

    
}










//extension AccountViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate{
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let const = scrollView.contentOffset.x/3
//        let reduced = ((UIScreen.main.bounds.width/3)-30)/3
//
//        if scrollView.contentOffset.x == 0{
////            mainScrollView.contentSize.height = (251*5)+245
//        }else{
////            mainScrollView.contentSize.height = (131*9)+245
//
//        }
//
//
//        stackOptionCollectionView.leftHorizontalBar?.constant = const+reduced
//    }
//    
////        func scrollViewDidScroll(_ scrollView: UIScrollView) {
////            let const = scrollView.contentOffset.x/2
////            let reduced = ((UIScreen.main.bounds.width/2)-64)/2
////
////            if scrollView.contentOffset.x == 0{
////    //            mainScrollView.contentSize.height = (251*5)+245
////            }else{
////    //            mainScrollView.contentSize.height = (131*9)+245
////
////            }
////
////    //        stackOptionCollectionView.leftHorizontalBar?.constant = const+reduced
////        }
//    
//    
//        func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//            let item = targetContentOffset.pointee.x/view.frame.width
//            stackOptionCollectionView.stackOptionCollectionView.selectItem(at: NSIndexPath(item: Int(item), section: 0) as IndexPath, animated: true, scrollPosition: .init())
//        }
//    
//
//    
////    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
////        guard kind == UICollectionView.elementKindSectionHeader else{return UICollectionReusableView()}
////
////        let InfoHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "profileInfoHeader", for: indexPath) as! profileInfoHeader
////        return InfoHeader
////    }
////
////    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
////        if section == 0{
////            return CGSize(width: collectionView.frame.width, height: 250)
////        }
////        return .zero
////        }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 2
//    }
//    
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if indexPath.row == 0{
////            mainScrollView.contentSize.height = (254*5)+245
//
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionOfStackViews", for: indexPath) as! collectionStackViewCell
//            cell.scrollDelegate = self
//            return cell
////        }else if indexPath.row == 1{
////            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fullItemViews", for: indexPath) as! fullSizePost
////            cell.scrollDelegate = self
////            return cell
//        }else{
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"collectionStackViewCellInterest", for: indexPath) as! collectionStackViewCellInterest
//            cell.scrollDelegate = self
//            return cell
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
////        if indexPath.row == 0 || indexPath.row == 2{
//        let size = CGSize(width: collectionView.frame.width, height: collectionView.frame.height+mainViewHeight!.constant)
////        ((UIScreen.main.bounds.height-topbarHeight-topbarHeight)*30)
//            return size
////        }
////        let itemCount = realObjc.objects(userObject.self)[0].interests.count
////        let itemCount = cataList.count
////        if itemCount % 2 == 0{
////            let size = CGSize(width: collectionView.frame.width, height: 140*CGFloat(itemCount/2))
////            return size
////        }
////        let size = CGSize(width: collectionView.frame.width, height: 140*CGFloat(itemCount/2+1))
////        return size
////        let size = CGSize(width: collectionView.frame.width, height:collectionView.frame.height)
////        return size
//    }
//
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//}







//extension AccountViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate{
//

//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//
//
//
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
//
//            return cell
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let itemCount = realm2.objects(PostObject.self).count
//        if itemCount % 2 == 0{
//            let size = CGSize(width: collectionView.frame.width, height: 180*CGFloat(itemCount/2))
//            return size
//        }
//        let size = CGSize(width: collectionView.frame.width, height: 180*CGFloat(itemCount/2+1))
//        return size
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//}












class RelationshipViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, blackViewProtocol{
    func changeBlackView() {
        UIView.animate(withDuration: 0.3) {
            self.blackWindow.alpha = 0
        }
    }
    let blackWindow = UIView()

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 23
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let TESTIMAGES = ["ProfileImage1","ProfileImage2", "ProfileImage3", "ProfileImage4", "ProfileImage5","ProfileImage1","ProfileImage2", "ProfileImage3", "ProfileImage4", "ProfileImage5"]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RelationShipCell", for: indexPath) as! RelationShipCell
        cell.profileImage.image = UIImage(named: TESTIMAGES.randomElement()!)
        
        cell.name.text = "Caleb Mesfien"
        cell.username.text = "cm4real"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width, height: UIScreen.main.bounds.width*0.14)
        return size
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let window = UIApplication.shared.keyWindow{
//            blackWindow.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height)
//            blackWindow.backgroundColor = UIColor(white: 0, alpha: 0.5)
//            blackWindow.alpha = 0
//            view.addSubview(blackWindow)
//            UIView.animate(withDuration: 0.5) {
//                self.blackWindow.alpha = 1
//            }
//        }
        let vc = UserAccountView()
//        vc.delegate = self
        vc.hidesBottomBarWhenPushed = true
//        vc.modalPresentationStyle = .overCurrentContext
//        self.tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BlackBackgroundColor
        title = "Friends"
        let addFriends = UIBarButtonItem(image: UIImage(named: "AddFriend"), style: .plain, target: self, action: #selector(addFriendSelected))
        navigationItem.rightBarButtonItem = addFriends
        //        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        view.addSubview(CollectionView)
        CollectionView.addSubview(refreshControl)
        CollectionView.backgroundView = refreshControl
        CollectionView.dataSource = self
        CollectionView.delegate = self
        
        NSLayoutConstraint.activate([
            CollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            CollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            CollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            CollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = BlackBackgroundColor
        navigationController?.navigationBar.tintColor = subViewColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: subViewColor]
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    fileprivate let CollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = BlackBackgroundColor
        collectionView.isScrollEnabled = true
        collectionView.bounces = true
        
        collectionView.register(RelationShipCell.self, forCellWithReuseIdentifier: "RelationShipCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    @objc func addFriendSelected(){
        let vc = NewFriendView()
        vc.hidesBottomBarWhenPushed = true
        present(vc, animated: true, completion: nil)
    }

    private let refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshGroupList(_:)), for: .valueChanged)
        refresh.layoutIfNeeded()
        refresh.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)

        return refresh
    }()
    @objc private func refreshGroupList(_ sender: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.6, execute: {
            sender.endRefreshing()
        })
    }
}

class RelationShipCell: UICollectionViewCell{
    override init(frame: CGRect){
        super.init(frame: frame)
        constraintContainer()
    }
    fileprivate let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ProfileImage1")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = (UIScreen.main.bounds.width*0.12)/2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate let username: CustomLabel = {
        let label = CustomLabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    fileprivate let name: CustomLabel = {
        let label = CustomLabel()
        label.textColor = subViewColor
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
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

    
    fileprivate func constraintContainer(){
        
        
        self.addSubview(profileImage)
        self.addSubview(username)
        self.addSubview(name)
        self.addSubview(imgArrow)
        
        NSLayoutConstraint.activate([
//            profileImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            profileImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            profileImage.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.12),
            profileImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.12),
            
            name.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            name.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 12),
            name.trailingAnchor.constraint(equalTo: imgArrow.leadingAnchor,constant: -16),
            name.bottomAnchor.constraint(equalTo: profileImage.centerYAnchor),
            
            imgArrow.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imgArrow.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            imgArrow.heightAnchor.constraint(equalToConstant: 20),
            imgArrow.widthAnchor.constraint(equalToConstant: 20),
            
            username.topAnchor.constraint(equalTo: profileImage.centerYAnchor),
            username.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor,constant: 12),
            username.trailingAnchor.constraint(equalTo: imgArrow.leadingAnchor,constant: -16),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
