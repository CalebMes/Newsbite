//
//  Friends.swift
//  NewsTestApp
//
//  Created by Caleb Mesfien on 12/4/20.
//

import UIKit
import RealmSwift
class NewFriendCell: UITableViewCell{

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        constraintContainer()
    }
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ProfileImage1")
        imageView.layer.cornerRadius = 50/2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
     let username: CustomLabel = {
        let label = CustomLabel()
        label.textColor = subViewColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let userHandle: CustomLabel = {
        let label = CustomLabel()
        label.textColor = .lightGray
//        label.text = ""
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let addBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = TealConstantColor
        btn.setAttributedTitle(NSAttributedString(string: "Add", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .bold)]), for: .normal)
        btn.addTarget(self, action: #selector(addBtnSelected), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 5
        return btn
    }()

    fileprivate func constraintContainer(){
        
        
        self.addSubview(profileImage)
        self.addSubview(username)
        self.addSubview(userHandle)
        self.addSubview(addBtn)
        
        NSLayoutConstraint.activate([

            profileImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            profileImage.heightAnchor.constraint(equalToConstant: 50),
            profileImage.widthAnchor.constraint(equalToConstant: 50),
            
            username.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            username.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 12),
            username.trailingAnchor.constraint(equalTo: addBtn.leadingAnchor,constant: -8),
            username.bottomAnchor.constraint(equalTo: profileImage.centerYAnchor),
            
            userHandle.topAnchor.constraint(equalTo: profileImage.centerYAnchor),
            userHandle.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor,constant: 12),
            userHandle.trailingAnchor.constraint(equalTo: addBtn.leadingAnchor, constant: -8),
            
            addBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -16),
            addBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            addBtn.widthAnchor.constraint(equalToConstant: addBtn.intrinsicContentSize.width+20),
            addBtn.heightAnchor.constraint(equalToConstant: 28),
            
        ])
    }
    
    @objc func addBtnSelected(){
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class NewFriendView: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var delegate: blackViewProtocol?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewFriendCell", for: indexPath) as! NewFriendCell
        cell.selectionStyle = .none
        cell.tag = indexPath.row
        
        if cell.tag == indexPath.row{
            cell.username.text = "Kevin hart"
            cell.userHandle.text = "@Kev$Real"
        }
            return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BlackBackgroundColor
        textField.becomeFirstResponder()
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(PanGestureFunc)))
        constraintContainer()
    }
    var viewTranslation = CGPoint(x: 0, y: 0)
    @objc func PanGestureFunc(sender: UIPanGestureRecognizer){
        print(sender.translation(in: view))
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

    fileprivate let textFieldView: CustomView = {
       let view = CustomView()
       view.backgroundColor = .white
        view.layer.cornerRadius = 8
        if subViewColor == .black{
            view.layer.shadowColor = UIColor.lightGray.cgColor.copy(alpha: 0.5)
            view.layer.shadowOpacity = 1
            view.layer.shadowOffset = CGSize(width: 0, height: 3)
            view.layer.shadowRadius = 4
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
        field.placeholder = "Search for friends..."
        field.tintColor = .lightGray
        field.autocorrectionType = .no
        field.returnKeyType = .search
        if subViewColor == .white{
            field.keyboardAppearance = .dark
        }else{
            field.keyboardAppearance = .light
        }

        field.translatesAutoresizingMaskIntoConstraints = false
       return field
    }()
    
    
    
    fileprivate lazy var userTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = BlackBackgroundColor
        tableView.isScrollEnabled = true
//        tableView.tableFooterView = UIView()
        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(NewFriendCell.self, forCellReuseIdentifier: "NewFriendCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    fileprivate let titleLbl: CustomLabel = {
       let lbl = CustomLabel()
        lbl.text = "Add Friends"
        lbl.textColor = subViewColor
        lbl.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    fileprivate let removeBtn: UIButton = {
       let btn = UIButton()
        btn.addTarget(self, action: #selector(RemoveView), for: .touchUpInside)
        if subViewColor == .white{
            btn.setImage(UIImage(named: "DownArrowWhite"), for: .normal)
        }else{
            btn.setImage(UIImage(named: "DownArrowBlack"), for: .normal)
        }
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    func constraintContainer(){
        view.addSubview(titleLbl)
        view.addSubview(removeBtn)
        view.addSubview(textFieldView)
        textFieldView.addSubview(searchIcon)
        textFieldView.addSubview(textField)
        view.addSubview(userTableView)
        
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            removeBtn.centerYAnchor.constraint(equalTo: titleLbl.centerYAnchor),
            removeBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            removeBtn.widthAnchor.constraint(equalToConstant: 28),
            removeBtn.heightAnchor.constraint(equalToConstant: 28),
            
            textFieldView.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 12),
            textFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            textFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            textFieldView.heightAnchor.constraint(equalToConstant:36),
            
            searchIcon.centerYAnchor.constraint(equalTo: textFieldView.centerYAnchor),
            searchIcon.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor, constant: 4),
            searchIcon.widthAnchor.constraint(equalTo: textFieldView.heightAnchor, constant: -16),
            searchIcon.heightAnchor.constraint(equalTo: textFieldView.heightAnchor, constant: -16),
            
            
            textField.topAnchor.constraint(equalTo: textFieldView.topAnchor, constant: 3),
            textField.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor, constant: 4),
            textField.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -8),
            textField.bottomAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: -3),
            
            userTableView.topAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: 8),
            userTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            userTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    @objc func RemoveView(){
        delegate?.changeBlackView()
        dismiss(animated: true)
    }
}





class UserAccountView: UIViewController{
    let realmObjc = try! Realm()

    var delegate: blackViewProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Account"
        
//        try! realmObjc.write {
//            realmObjc.delete(realmObjc.objects(SubscribedTopics.self).last!)
//        }

        
        view.backgroundColor = BlackBackgroundColor
        constraintContainer()
//        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(PanGestureFunc)))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = BlackBackgroundColor
        navigationController?.navigationBar.tintColor = subViewColor
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: subViewColor]
        if realmObjc.objects(DarkMode.self)[0].isDarkMode{
            UIApplication.shared.statusBarStyle = .lightContent
        }else{
            UIApplication.shared.statusBarStyle = .darkContent
        }
    }
//    var viewTranslation = CGPoint(x: 0, y: 0)
//       @objc func PanGestureFunc(sender: UIPanGestureRecognizer){
//        switch sender.state {
//        case .changed:
//            viewTranslation = sender.translation(in: view)
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut) {
//                self.view.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
//            } completion: { (_) in
//
//            }
//        case .ended:
//            if viewTranslation.y < 200{
//                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut) {
//                    self.view.transform = .identity
//                } completion: { (_) in
//                }
//
//                if viewTranslation.y >= sender.translation(in: view).y{
//                    print("HEHE")
//                    break
//                }
//
//            }else {
//                delegate?.changeBlackView()
//                dismiss(animated: true, completion: nil)
//            }
//        default:
//            break
//        }
//       }
    
    
//    let MainWhiteView: CustomView = {
//       let view = CustomView()
//        view.backgroundColor = .white
//        view.clipsToBounds = true
//        view.layer.cornerRadius = 15
//
////        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner]
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//
//
//    fileprivate let viewBar: CustomView = {
//        let view = CustomView()
//        view.backgroundColor = .lightGray
//        view.layer.cornerRadius = 3
//
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    fileprivate lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFill
        if realmObjc.objects(userObject.self)[0].image != nil{
            imageView.image = UIImage(data: realmObjc.objects(userObject.self)[0].image! as Data)
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
        label.textAlignment = .center
        label.attributedText = NSAttributedString(string: realmObjc.objects(userObject.self)[0].name, attributes: [NSAttributedString.Key.foregroundColor: subViewColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 21, weight: .semibold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    fileprivate lazy var userHandle: CustomLabel = {
       let label = CustomLabel()
        label.textAlignment = .center
        label.attributedText = NSAttributedString(string: "@"+realmObjc.objects(userObject.self)[0].username, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    fileprivate let FriendsBtn: UIButton = {
       let btn = UIButton()
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 3
        btn.backgroundColor = UIColor(red: 235/255, green: 237/255, blue: 239/255, alpha: 1)
        btn.setAttributedTitle(NSAttributedString(string: "Friends", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)]), for: .normal)
        btn.addTarget(self, action: #selector(FriendsBtnSelected), for: .touchUpInside)
        
//        btn.layer.shadowColor = UIColor.lightGray.cgColor
//        btn.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
//        btn.layer.shadowRadius = 5.0
//        btn.layer.shadowOpacity = 0.4
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    fileprivate let instaImageiew: UIButton = {
       let view = UIButton()
        if subViewColor == .white{
            view.setImage(UIImage(named: "instagramIconWhite"), for: .normal)
        }else{
            view.setImage(UIImage(named: "instagramIcon"), for: .normal)
        }
        view.addTarget(self, action: #selector(instaBtnSelected), for: .touchUpInside)
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()
    
    fileprivate let AddUser: CustomView = {
       let btn = CustomView()
        btn.backgroundColor = UIColor(red: 235/255, green: 237/255, blue: 239/255, alpha: 1)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 3
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    fileprivate let addImg: UIImageView = {
       let view = UIImageView()
        view.image = UIImage(named:"addFriendImage")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    fileprivate let addText: CustomLabel = {
       let lbl = CustomLabel()
        lbl.text = "Add"
        lbl.font = .systemFont(ofSize: 16, weight: .bold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    fileprivate let shareAccountButton: UIButton = {
       let btn = UIButton()

//        button.setImage(UIImage(named: "blackShareIcon"), for: .normal)
        if subViewColor == .white{
            btn.setImage(UIImage(named: "Share"), for: .normal)
        }else{
            btn.setImage(UIImage(named: "blackShare"), for: .normal)
        }
        btn.backgroundColor = .clear

        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
//    INTRESTS AND SAVED
    fileprivate let InterestHeader: CustomLabel = {
       let lbl = CustomLabel()
        lbl.text = "Interests"
        lbl.textColor = subViewColor
        lbl.font = .systemFont(ofSize: 19, weight: .bold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    fileprivate lazy var UserInterestsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumLineSpacing = 2
        layout.scrollDirection = .horizontal
        collectionView.delegate = self
        collectionView.dataSource = self
//        collectionView.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        collectionView.backgroundColor = .clear
//        collectionView.register(UserInterestCell.self, forCellWithReuseIdentifier: "UserInterestCell")
        collectionView.register(interestCollectionViewCell.self, forCellWithReuseIdentifier: "UserInterestCell")

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    fileprivate let SubscriptionsHeader: CustomLabel = {
       let lbl = CustomLabel()
        lbl.text = "Subscriptions"
        lbl.textColor = subViewColor
        lbl.font = .systemFont(ofSize: 19, weight: .bold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    fileprivate lazy var UserSubscriptionsCollection: UICollectionView = {
        let layout = CustomViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(UserSubsCell.self, forCellWithReuseIdentifier: "UserSubsCell")

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    fileprivate let UserInfoHeader: CustomLabel = {
       let lbl = CustomLabel()
        lbl.text = "Info"
        lbl.textColor = subViewColor
        lbl.font = .systemFont(ofSize: 19, weight: .bold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
//    fileprivate let infoView: CustomView = {
//       let view = CustomView()
//        view.backgroundColor = .white
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    fileprivate let JoinedLbl: CustomLabel = {
       let lbl = CustomLabel()
        lbl.text = "Joined Nov 3, 2020"
        lbl.backgroundColor = .white
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 16, weight: .semibold)
//        lbl.clipsToBounds = true
        lbl.layer.masksToBounds = false
        lbl.layer.cornerRadius = 5
        if subViewColor == .black{
            lbl.layer.shadowColor = UIColor.lightGray.cgColor.copy(alpha: 0.3)
            lbl.layer.shadowOpacity = 0.9
            lbl.layer.shadowOffset = CGSize(width: 0, height: 4)
            lbl.layer.shadowRadius = 4
        }
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    fileprivate let FriendCountLbl: CustomLabel = {
       let lbl = CustomLabel()
        lbl.text = "32 Friends"
        lbl.layer.cornerRadius = 5
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 16, weight: .semibold)
        lbl.backgroundColor = .white
//        lbl.clipsToBounds = true
        lbl.layer.masksToBounds = false
        
        if subViewColor == .black{
            lbl.layer.shadowColor = UIColor.lightGray.cgColor.copy(alpha: 0.3)
            lbl.layer.shadowOpacity = 0.9
            lbl.layer.shadowOffset = CGSize(width: 0, height: 4)
            lbl.layer.shadowRadius = 4
        }
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    
    func constraintContainer(){
//        view.addSubview(MainWhiteView)
//        MainWhiteView.addSubview(viewBar)
        view.addSubview(profileImage)
        view.addSubview(username)
        view.addSubview(userHandle)
        view.addSubview(shareAccountButton)
        
        view.addSubview(FriendsBtn)
        view.addSubview(AddUser)
        AddUser.addSubview(addImg)
        AddUser.addSubview(addText)
        view.addSubview(instaImageiew)
        
        
        view.addSubview(UserInfoHeader)
//        view.addSubview(infoView)
        view.addSubview(JoinedLbl)
        view.addSubview(FriendCountLbl)
        
        view.addSubview(InterestHeader)
        view.addSubview(UserInterestsCollection)
        
        view.addSubview(SubscriptionsHeader)
        view.addSubview(UserSubscriptionsCollection)
        
        NSLayoutConstraint.activate([
//            MainWhiteView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.82),
//            MainWhiteView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            MainWhiteView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            MainWhiteView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//
//            viewBar.topAnchor.constraint(equalTo: MainWhiteView.topAnchor, constant: 12),
//            viewBar.widthAnchor.constraint(equalToConstant: 28),
//            viewBar.heightAnchor.constraint(equalToConstant: 4.5),
//            viewBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//
            
//            EVERYTHNG IN WHITE VIEW

            
            profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
//            profileImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            profileImage.widthAnchor.constraint(equalToConstant: 100),
            
            username.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 8),
            username.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            username.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            userHandle.topAnchor.constraint(equalTo: username.bottomAnchor, constant: 4),
            userHandle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            userHandle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            
            shareAccountButton.centerYAnchor.constraint(equalTo: FriendsBtn.centerYAnchor),
            shareAccountButton.heightAnchor.constraint(equalToConstant: 30),
            shareAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            shareAccountButton.widthAnchor.constraint(equalTo: shareAccountButton.heightAnchor),
            
            FriendsBtn.heightAnchor.constraint(equalToConstant: 35),
            FriendsBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            FriendsBtn.trailingAnchor.constraint(equalTo: AddUser.leadingAnchor, constant: -12),
            FriendsBtn.topAnchor.constraint(equalTo: userHandle.bottomAnchor, constant: 8),
            
            AddUser.heightAnchor.constraint(equalToConstant: 35),
            AddUser.widthAnchor.constraint(equalToConstant: 110),
            AddUser.topAnchor.constraint(equalTo: userHandle.bottomAnchor, constant: 8),
            AddUser.trailingAnchor.constraint(equalTo: instaImageiew.leadingAnchor, constant: -8),
            
            
                addImg.topAnchor.constraint(equalTo: AddUser.topAnchor, constant: 8),
                addImg.bottomAnchor.constraint(equalTo: AddUser.bottomAnchor, constant: -8),
                addImg.leadingAnchor.constraint(equalTo: AddUser.leadingAnchor, constant: 26),
                addImg.widthAnchor.constraint(equalTo: addImg.heightAnchor),
                
                addText.leadingAnchor.constraint(equalTo: addImg.trailingAnchor, constant: 4),
                addText.trailingAnchor.constraint(equalTo: AddUser.trailingAnchor),
                addText.topAnchor.constraint(equalTo: AddUser.topAnchor),
                addText.bottomAnchor.constraint(equalTo: AddUser.bottomAnchor),
            
            instaImageiew.heightAnchor.constraint(equalToConstant: 32),
            instaImageiew.widthAnchor.constraint(equalToConstant: 32),
            instaImageiew.centerYAnchor.constraint(equalTo: AddUser.centerYAnchor),
            instaImageiew.trailingAnchor.constraint(equalTo: shareAccountButton.leadingAnchor, constant: -8),
            
//            INTERESTS AND SUBSCRIPTIONS
            UserInfoHeader.topAnchor.constraint(equalTo: FriendsBtn.bottomAnchor, constant: 12),
            UserInfoHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            UserInfoHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            FriendCountLbl.topAnchor.constraint(equalTo: UserInfoHeader.bottomAnchor, constant: 8),
            FriendCountLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            FriendCountLbl.widthAnchor.constraint(equalToConstant: FriendCountLbl.intrinsicContentSize.width+24),
            FriendCountLbl.heightAnchor.constraint(equalToConstant: FriendCountLbl.intrinsicContentSize.height+16),

            
            JoinedLbl.topAnchor.constraint(equalTo: UserInfoHeader.bottomAnchor, constant: 8),
            JoinedLbl.leadingAnchor.constraint(equalTo: FriendCountLbl.trailingAnchor, constant: 12),
            JoinedLbl.widthAnchor.constraint(equalToConstant: JoinedLbl.intrinsicContentSize.width+24),
            JoinedLbl.heightAnchor.constraint(equalToConstant: JoinedLbl.intrinsicContentSize.height+16),
            
//            JoinedLbl.topAnchor.constraint(equalTo: FriendCountLbl.bottomAnchor, constant: 12),
//            JoinedLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
//            JoinedLbl.widthAnchor.constraint(equalToConstant: JoinedLbl.intrinsicContentSize.width+24),
//            JoinedLbl.heightAnchor.constraint(equalToConstant: JoinedLbl.intrinsicContentSize.height+16),
            
            
            InterestHeader.topAnchor.constraint(equalTo: JoinedLbl.bottomAnchor, constant: 12),
            InterestHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            InterestHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            UserInterestsCollection.topAnchor.constraint(equalTo: InterestHeader.bottomAnchor, constant: 8),
            UserInterestsCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            UserInterestsCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            UserInterestsCollection.heightAnchor.constraint(equalToConstant: 200),
            
            SubscriptionsHeader.topAnchor.constraint(equalTo: UserInterestsCollection.bottomAnchor, constant: 8),
            SubscriptionsHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            SubscriptionsHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 12),
            
            UserSubscriptionsCollection.topAnchor.constraint(equalTo: SubscriptionsHeader.bottomAnchor),
            UserSubscriptionsCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            UserSubscriptionsCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            UserSubscriptionsCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            UserSubscriptionsCollection.heightAnchor.constraint(equalToConstant:150 ),
            
        ])
    }
    @objc func FriendsBtnSelected(){
        let vc = RelationshipViewController()
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
}

let userColorPicker = [
    UIColor(red: 255/255, green: 237/255, blue: 237/255, alpha: 1),
    UIColor(red: 255/255, green: 255/255, blue: 237/255, alpha: 1),
    UIColor(red: 237/255, green: 255/255, blue: 237/255, alpha: 1),
    UIColor(red: 237/255, green: 246/255, blue: 255/255, alpha: 1),
    UIColor(red: 247/255, green: 237/255, blue: 255/255, alpha: 1),
]
extension UserAccountView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == UserInterestsCollection{
            return cataList.count
        }
        let Count = realmObjc.objects(SubscribedTopics.self).count
        return Count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == UserInterestsCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserInterestCell", for: indexPath) as! interestCollectionViewCell
    //        cell.layer.cornerRadius = 5
            cell.interestLabel.text = cataList[indexPath.row]
            cell.topicBackgroundImage.image = UIImage(named: cataList[indexPath.row])
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 5
            
            return cell
        }
        let attr1 = [NSAttributedString.Key.foregroundColor: TealConstantColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)]
        let attr2 = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)]
        let string1 = NSMutableAttributedString(string:"#", attributes: attr1)
        let string2 = NSMutableAttributedString(string:realmObjc.objects(SubscribedTopics.self)[indexPath.row].title.uppercased(), attributes: attr2)
        
        string1.append(string2)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserSubsCell", for: indexPath) as! UserSubsCell
        cell.textLbl.attributedText = string1

        cell.backgroundColor = .white
        cell.clipsToBounds = true
        cell.layer.masksToBounds = false
//        cell.layer.cornerRadius = 5
        if subViewColor == .black{
            cell.layer.shadowColor = UIColor.lightGray.cgColor.copy(alpha: 0.3)
            cell.layer.shadowOpacity = 0.9
            cell.layer.shadowOffset = CGSize(width: 0, height: 4)
            cell.layer.shadowRadius = 4
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == UserInterestsCollection{
        let size = CGSize(width: (collectionView.frame.width/2)-24, height: collectionView.frame.height/2-4)
            return size
        }
        let item = "#"+realmObjc.objects(SubscribedTopics.self)[indexPath.row].title.uppercased()
        let itemSize = item.size(withAttributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .bold)
        ])
        let size = CGSize(width: itemSize.width+24, height: itemSize.height+16)
        return size

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == UserInterestsCollection{
            return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        }
        return UIEdgeInsets(top: 8, left: 12, bottom: 12, right: 12)
    }
}
class CustomViewFlowLayout: UICollectionViewFlowLayout {

let cellSpacing:CGFloat = 6

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
            self.minimumLineSpacing = 6.0
            self.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
            let attributes = super.layoutAttributesForElements(in: rect)

            var leftMargin = sectionInset.left
            var maxY: CGFloat = -1.0
            attributes?.forEach { layoutAttribute in
                if layoutAttribute.frame.origin.y >= maxY {
                    leftMargin = sectionInset.left
                }
                layoutAttribute.frame.origin.x = leftMargin
                leftMargin += layoutAttribute.frame.width + cellSpacing
                maxY = max(layoutAttribute.frame.maxY , maxY)
            }
            return attributes
    }
}


class UserSubsCell: UICollectionViewCell{
    override init(frame: CGRect){
        super.init(frame: frame)
//        backgroundColor = .cyan
        addSubview(textLbl)
        addConstraintsWithFormat(format: "H:|[v0]|", views: textLbl)
        addConstraintsWithFormat(format: "V:|[v0]|", views: textLbl)
    }
    let textLbl: CustomLabel = {
       let lbl = CustomLabel()
        lbl.textAlignment = .center
        lbl.backgroundColor = .clear

        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
