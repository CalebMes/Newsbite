//
//  NotificationViews.swift
//  NewsTestApp
//
//  Created by Caleb Mesfien on 11/27/20.
//

import UIKit
import RealmSwift

class RequestBtnCell: UICollectionViewCell{
    let realmObjc = try! Realm()
    override init(frame: CGRect){
        super.init(frame: frame)
        constraintContainer()
    }

    fileprivate lazy var imgView: UIImageView = {
        let imageView = UIImageView()
        if realmObjc.objects(DarkMode.self)[0].isDarkMode{
            imageView.image = UIImage(named: "FriendRequestIconWhite")
        }else{
            imageView.image = UIImage(named: "FriendRequestIcon")
        }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    fileprivate let imgArrow: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = UIImage(named: "BlackRightArrow")
        if subViewColor == .black{
            imageView.image = UIImage(named: "BlackRightArrow")
        }else{
            imageView.image = UIImage(named: "WhiteRightArrow")
        }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    fileprivate let label: CustomLabel = {
        let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "Friend Requests", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .semibold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        func constraintContainer(){
            self.addSubview(imgView)
            self.addSubview(label)
            self.addSubview(imgArrow)
            NSLayoutConstraint.activate([
            imgView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imgView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            imgView.heightAnchor.constraint(equalToConstant: 24),
            imgView.widthAnchor.constraint(equalToConstant: 24),
                
            imgArrow.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imgArrow.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            imgArrow.heightAnchor.constraint(equalToConstant: 20),
            imgArrow.widthAnchor.constraint(equalToConstant: 20),
            
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 8),
            ])
        }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}










class NotificationViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    let realmObjc = try! Realm()
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1{
            return 4
        }else{
            return 23
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0{
            return CGSize(width: 0, height: 0)
        }else{
            let size = CGSize(width: collectionView.frame.width, height: 44)
            return size
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let TESTIMAGES = ["ProfileImage1","ProfileImage2", "ProfileImage3", "ProfileImage4", "ProfileImage5","ProfileImage1","ProfileImage2", "ProfileImage3", "ProfileImage4", "ProfileImage5"]
        let TESTIMAGES2 = ["firstImage", "secondImage","thirdImage", "fourthImage", "fifthImage","firstImage", "secondImage","thirdImage", "fourthImage", "fifthImage"]
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RequestBtnCell", for: indexPath) as! RequestBtnCell

            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NotificaitonCollectionView", for: indexPath) as! NotificaitonCell
            cell.backgroundColor = BlackBackgroundColor
            cell.profileImage.image = UIImage(named: TESTIMAGES.randomElement()!)
            cell.activityImage.image = UIImage(named: TESTIMAGES2.randomElement()!)
            
            cell.activityLabel.text = "liked your post."
            cell.username.text = "Elon Musk"
            cell.dateLabel.text = "2 days"
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            return CGSize(width: collectionView.frame.width, height: 40)
        }else{
            let size = CGSize(width: collectionView.frame.width, height: UIScreen.main.bounds.width*0.16)
            return size
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "notificationHeaderID", for: indexPath)
            header.backgroundColor = BlackBackgroundColor
        let title: CustomLabel = {
            let label = CustomLabel()
            label.textColor = .lightGray
            label.font = .systemFont(ofSize: 16, weight: .semibold)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
    }()
        let lineView: UIView = {
           let view = CustomView()
//            view.backgroundColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1)
            view.backgroundColor = .lightGray
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        header.addSubview(lineView)
        header.addSubview(title)
        
        lineView.topAnchor.constraint(equalTo: header.topAnchor, constant: 8).isActive = true
        lineView.leadingAnchor.constraint(equalTo: header.leadingAnchor).isActive = true
        lineView.trailingAnchor.constraint(equalTo: header.trailingAnchor).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 0.3).isActive = true

        title.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 8).isActive = true
        title.leadingAnchor.constraint(equalTo: header.leadingAnchor,constant: 8).isActive = true
        
        if indexPath.section == 1{
            title.text = "Today"
        }else if indexPath.section == 2{
            title.text = "Past"
        }
        
        if indexPath.section == 0{
            lineView.backgroundColor = .white
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0{
//            let vc = ReequestView()
            let vc = ReequestView()
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
            return
        }
        let vc = ExpandedPost()
        vc.url = ""
        vc.TopicTitle.text = "Hamilton"
        vc.TopicDesc.text = ""
        vc.DateOfTopic.text = ""
        vc.TopicImage.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named:"placeholder"))
        tabBarController?.tabBar.isHidden = true
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        title = "Activity"
        let addFriends = UIBarButtonItem(image: UIImage(named: "AddFriend"), style: .plain, target: self, action: #selector(addFriendSelected))
        navigationItem.rightBarButtonItem = addFriends
        view.backgroundColor = BlackBackgroundColor
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        view.addSubview(NotificaitonCollectionView)
        NotificaitonCollectionView.addSubview(refreshControl)
        NotificaitonCollectionView.backgroundView = refreshControl
        NotificaitonCollectionView.dataSource = self
        NotificaitonCollectionView.delegate = self
        
        NSLayoutConstraint.activate([
            NotificaitonCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            NotificaitonCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            NotificaitonCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            NotificaitonCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: subViewColor]
        navigationController?.navigationBar.barTintColor = BlackBackgroundColor
        navigationController?.navigationBar.tintColor = subViewColor
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: subViewColor]

    }

    fileprivate let NotificaitonCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = BlackBackgroundColor
        collectionView.isScrollEnabled = true
        collectionView.bounces = true
        
        collectionView.register(NotificaitonCell.self, forCellWithReuseIdentifier: "NotificaitonCollectionView")
        collectionView.register(RequestBtnCell.self, forCellWithReuseIdentifier: "RequestBtnCell")

        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "notificationHeaderID")
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
    @objc private func refreshGroupList(_ sender: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.6, execute: {
            sender.endRefreshing()
        })
    }
    @objc func addFriendSelected(){
        let vc = NewFriendView()
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }

}





//      MARK: Request CONTROLLER
class ReequestView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

            return 23
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let TESTIMAGES = ["ProfileImage1","ProfileImage2", "ProfileImage3", "ProfileImage4", "ProfileImage5","ProfileImage1","ProfileImage2", "ProfileImage3", "ProfileImage4", "ProfileImage5"]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RequestCells", for: indexPath) as! RequestCells
        cell.backgroundColor = .white
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
        let vc = ExpandedPost()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }




    override func viewDidLoad() {
        super.viewDidLoad()


        title = "Requests"
        view.backgroundColor = .white


        view.addSubview(NotificaitonCollectionView)
        NotificaitonCollectionView.addSubview(refreshControl)
        NotificaitonCollectionView.backgroundView = refreshControl
        NotificaitonCollectionView.dataSource = self
        NotificaitonCollectionView.delegate = self

        NSLayoutConstraint.activate([
            NotificaitonCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            NotificaitonCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            NotificaitonCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            NotificaitonCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .black
    }

    fileprivate let NotificaitonCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = true
        collectionView.bounces = true

        collectionView.register(RequestCells.self, forCellWithReuseIdentifier: "RequestCells")
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "notificationHeaderID")
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
    @objc private func refreshGroupList(_ sender: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.6, execute: {
            sender.endRefreshing()
        })
    }
}

//
class RequestCells: UICollectionViewCell {

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
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    fileprivate let name: CustomLabel = {
        let label = CustomLabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    fileprivate let acceptBtn: UIButton = {
        let btn = UIButton()
        btn.setAttributedTitle(NSAttributedString(string: "Accept", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .bold)]), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = TealConstantColor
        btn.layer.cornerRadius = 5
        btn.layer.borderColor = TealConstantColor.cgColor
        btn.layer.borderWidth = 0.8
        return btn
    }()
    fileprivate let declineBtn: UIButton = {
        let btn = UIButton()
        btn.setAttributedTitle(NSAttributedString(string: "Remove", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .bold)]), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .clear
        btn.layer.cornerRadius = 5
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.layer.borderWidth = 0.8
        return btn
    }()

    fileprivate let lineView: CustomView = {
       let view = CustomView()
//        view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    fileprivate func constraintContainer(){


        self.addSubview(profileImage)
        self.addSubview(username)
        self.addSubview(name)
        self.addSubview(acceptBtn)
        self.addSubview(declineBtn)
        self.addSubview(lineView)

        NSLayoutConstraint.activate([
//            profileImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            profileImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            profileImage.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.12),
            profileImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.12),

            username.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            username.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 12),
            username.trailingAnchor.constraint(equalTo: declineBtn.leadingAnchor,constant: -8),
            username.bottomAnchor.constraint(equalTo: profileImage.centerYAnchor),


            name.topAnchor.constraint(equalTo: profileImage.centerYAnchor),
            name.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor,constant: 12),
            name.trailingAnchor.constraint(equalTo: declineBtn.leadingAnchor,constant: -8),

            declineBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            declineBtn.trailingAnchor.constraint(equalTo: acceptBtn.leadingAnchor,constant: -8),
            declineBtn.widthAnchor.constraint(equalToConstant: declineBtn.intrinsicContentSize.width+14),

            acceptBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -16),
            acceptBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            acceptBtn.widthAnchor.constraint(equalToConstant: acceptBtn.intrinsicContentSize.width+14),

            lineView.heightAnchor.constraint(equalToConstant: 0.3),
            lineView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class NotificaitonCell: UICollectionViewCell {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        constraintContainer()
}
    
    fileprivate let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "ProfileImage1")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = (UIScreen.main.bounds.width*0.11)/2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate let username: CustomLabel = {
        let label = CustomLabel()
        label.textColor = subViewColor
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let activityLabel: CustomLabel = {
        let label = CustomLabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let dateLabel: CustomLabel = {
        let label = CustomLabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let activityImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "PostExample")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
//    fileprivate let lineView: CustomView = {
//       let view = CustomView()
////        view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
//        view.backgroundColor = .white
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    fileprivate func constraintContainer(){
        
        
        self.addSubview(profileImage)
        self.addSubview(username)
        self.addSubview(activityLabel)
        self.addSubview(dateLabel)
        self.addSubview(activityImage)
//        self.addSubview(lineView)
        
        NSLayoutConstraint.activate([
//            profileImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            profileImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            profileImage.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.11),
            profileImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.11),
            
            username.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            username.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 12),
            username.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -8),
            username.bottomAnchor.constraint(equalTo: profileImage.centerYAnchor),
            
            
            activityLabel.topAnchor.constraint(equalTo: profileImage.centerYAnchor),
            activityLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor,constant: 12),
//            activityLabel.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor),
            
            dateLabel.leadingAnchor.constraint(equalTo: activityLabel.trailingAnchor, constant: 8),
            dateLabel.topAnchor.constraint(equalTo: username.bottomAnchor),
//            dateLabel.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor),

            
            activityImage.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -16),
            activityImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1),
            activityImage.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.14),
            activityImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
//            lineView.heightAnchor.constraint(equalToConstant: 0.5),
//            lineView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
