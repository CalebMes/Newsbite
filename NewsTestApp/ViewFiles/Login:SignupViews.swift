//
//  Login:SignupViews.swift
//  NewsTestApp
//
//  Created by Caleb Mesfien on 11/18/20.
//

import UIKit
import WebKit
import RealmSwift
//import Realm
import FirebaseFirestore
import AuthenticationServices

let db = Firestore.firestore()

protocol SelectedLoginOption{
    func loginOptions(OptionNum: Int)
}
protocol PostOption{
    func option(_ OptionNum: Int, image: UIImage)
}


class FirstViewController: UIViewController,  blackViewProtocol, SelectedLoginOption {
    let realmObjc = try! Realm()
    let appleProvider = AppleSignInClient()
    let item = 2
    var timer =  Timer()

    
    func fireTimer(_ int: Int){
        var itemInt = int
        var scroll = false
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (Timer) in

            if scroll{
                self.introCollectionView.scrollToItem(at: NSIndexPath(row: itemInt, section: 0) as IndexPath, at: .init(), animated: true)
                if itemInt != self.item {
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
    
    
    func loginOptions(OptionNum: Int) {
        if OptionNum == 0{
            appleProvider.handleAppleIdRequest { (fullName, email, userID)  in
                guard let id = userID else{return}
                db.collection("user").whereField("userId", isEqualTo: id).getDocuments { (QuerySnapshot, error) in
                    if let error = error{
                        print(error)
                    }else{
                        if QuerySnapshot!.isEmpty{
                            print("Not Found")
                            let vc = nameView()
//                            vc.fetchedName = fullName
//                            vc.fetchedId = id
//                            vc.fetchedEmail = email
                            self.navigationController?.pushViewController(vc, animated: true)
//                            db.collection("user").document().setData(["userId" : id, "fetchedName":fullName, "email": email])
                        }else{
                            guard let DocID = QuerySnapshot?.documents[0] else{return}
                            try! self.realmObjc.write{
                                self.realmObjc.deleteAll()

                            }
                            let item = userObject()
                            item.name = DocID.data()["name"] as! String
                            item.username = DocID.data()["username"] as! String
                            item.followerCount = 0
                            item.followingCount = 0
//                            if let hasImage == DocID?.data()["DateJoined"]{
                            item.image = nil
//                            }else{
//                                item.image = profileImage.image?.pngData() as NSData?
//                            }
                            item.Id = String(describing: DocID.documentID)
                            item.joinedDate = DocID.data()["DateJoined"] as! String
                            let interests = DocID.data()["interests"] as! [String]
                            
                            interests.forEach({ (String) in
                                item.interests.append(String)
                            })
//                            if let subscriptions = db.collection("users").document(DocID.documentID).collection("subscriptions").getDocuments(completion: { (snapshot, error) in
//                                let subs = SubscribedTopics()
//                                subs.title = snapshot?.f
//                            }){
                                
//                            }
                            
                            var listOfPosts = [PostObject]()
                            db.collection("posts").whereField("userID", isEqualTo: DocID.documentID).getDocuments { (snapshot, error) in
                                snapshot?.documents.forEach({ (query) in
                                    print("Found!!!!")
                                    let postObjc = PostObject()

//                                    postObjc.docID = query[""]
                                    postObjc.url = query["url"] as! String
                                    postObjc.title = query["title"] as! String
                                    postObjc.desc = query["desc"] as! String
                                    postObjc.date = query["date"] as! String
                                    postObjc.source_name = query["source_name"] as! String
                                    postObjc.image = query["image"] as! String
                                    try! self.realmObjc.write(){
                                        self.realmObjc.add(postObjc)
                                    }
                                    listOfPosts.append(postObjc)
                                })
                            }
                            let darkModeObjc = DarkMode()
                            darkModeObjc.isDarkMode = false
                            DispatchQueue.main.async {
                                try! self.realmObjc.write(){
//                                    self.realmObjc.deleteAll()
                                    self.realmObjc.add(darkModeObjc)
                                    self.realmObjc.add(item)
                                    


                                    print(item)
                                }
                            }
//                            realmObjc.
//                            print(DocID?.data()["DateJoined"])
                            print("found")
                            

                        }
                        
                    }
                }
//                        try! realmObjc.write{
//                        }
                DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                    let vc = CustomTabBarController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }


            }
//            APPLE SIGN IN
//            let request = ASAuthorizationAppleIDProvider().createRequest()
//            request.requestedScopes = [.fullName, .email]
//            let controller = ASAuthorizationController(authorizationRequests: [request])
//            controller.delegate = self
//            controller.presentationContextProvider = self
//            controller.performRequests()
            

        }else if OptionNum == 1{
//            GOOGLE SIGN IN
//            GIDSignIn.sharedInstance()?.signIn()

        }
            else if OptionNum == 2{
////            PHONE NUMBER
//            navigationController?.pushViewController(JoinWithoutSIView(), animated: true)
//        }else if optionNum == 3{
//       EMAIL
        
    }
    }
    func presentCreateViewController() {
        navigationController?.pushViewController(ViewController(), animated: true)
    }
    
    func shareGroup(GroupCode: String) {
        
    }
    
    func changeBlackView() {
            self.blackWindow.alpha = 0
    }
    
    
    
    
    let blackWindow = UIView()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = UIColor(red: 249/255, green: 248/255, blue: 253/255, alpha: 1)
//        let realm = try! Realm

        let index = NSIndexPath(item: 1, section: 0)
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.introCollectionView.scrollToItem(at: index as IndexPath, at: .init(), animated: true)
        }

        constraintContainer()
    }
    
    lazy var introCollectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.register(FirstViewCells.self, forCellWithReuseIdentifier: "FirstViewCells")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    fileprivate let startButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.setAttributedTitle(NSAttributedString(string: "Get started",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .semibold)]), for: .normal)
        button.backgroundColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        button.addTarget(self, action: #selector(NewPartyButtonSelected), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let imageView: UIImageView = {
       let view = UIImageView()
        view.contentMode = .scaleAspectFill
            view.image = UIImage(named: "LightBanner")

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let phraseLbl: CustomLabel = {
        let label = CustomLabel()
        label.text = "Read and Share"
//        label.textColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        label.textColor = .black

        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate func constraintContainer(){
        view.addSubview(startButton)
        view.addSubview(introCollectionView)
        view.addSubview(imageView)
        view.addSubview(phraseLbl)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            imageView.heightAnchor.constraint(equalToConstant: 110),
            imageView.widthAnchor.constraint(equalToConstant: 220),
            
            introCollectionView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            introCollectionView.bottomAnchor.constraint(equalTo: phraseLbl.topAnchor,constant: -12),
            introCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            introCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            phraseLbl.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -12),
            phraseLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            startButton.heightAnchor.constraint(equalToConstant: 42),
        ])
    }
    

    @objc func NewPartyButtonSelected(){
//                generator.impactOccurred()
//                        if let window = UIApplication.shared.keyWindow{
//                            blackWindow.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height)
//                            blackWindow.backgroundColor = UIColor(white: 0, alpha: 0.5)
//                            blackWindow.alpha = 0
//
//
//
//                            view.addSubview(blackWindow)
//
//                            UIView.animate(withDuration: 0.5) {
//                                self.blackWindow.alpha = 1
//                            }
//                }
//
//        let vc = SignupOptions()
//        vc.modalPresentationStyle = .overCurrentContext
//        vc.delegate = self
//        vc.selectedOptions = self
////
//
//
//        navigationController?.present(vc, animated: true)
        let vc = nameView()
        self.navigationController?.pushViewController(vc, animated: true)

    }
    }

extension FirstViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let topics = ["Technology", "Sports", "More"]
        let topicImg = ["TechnologyIntro", "SportsIntro", "EntertainmentIntro"]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstViewCells", for: indexPath) as! FirstViewCells
        cell.tag = indexPath.row
        if cell.tag == indexPath.row{
            timer.invalidate()
            fireTimer(indexPath.row)
            cell.topicTitle.text = topics[indexPath.row]
            cell.img.image = UIImage(named: topicImg[indexPath.row])
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


class FirstViewCells: UICollectionViewCell{
    override init(frame: CGRect){
        super.init(frame: frame)
        addSubview(img)
        addSubview(introTitle)
        addSubview(topicTitle)
        
        NSLayoutConstraint.activate([
//            introTitle.bottomAnchor.constraint(equalTo: img.topAnchor, constant: 18),
//            introTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            
//            img.topAnchor.constraint(equalTo: introTitle.bottomAnchor, constant: 12),
            img.leadingAnchor.constraint(equalTo: leadingAnchor),
            img.trailingAnchor.constraint(equalTo: trailingAnchor),
            img.heightAnchor.constraint(equalTo: widthAnchor),
//            img.topAnchor.constraint(equalTo: topAnchor, constant: 34),
            img.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -28),
//            img.wi.constraint(equalTo: introTitle.topAnchor, constant: -18),
            
//            introTitle.topAnchor.
            introTitle.topAnchor.constraint(equalTo: img.bottomAnchor, constant: -18),
            introTitle.leadingAnchor.constraint(equalTo: topicTitle.leadingAnchor, constant: -22),
            
            topicTitle.topAnchor.constraint(equalTo: introTitle.bottomAnchor),
            topicTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            
        ])
    }
    let introTitle: CustomLabel = {
        let label = CustomLabel()
//        label.textColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        label.textColor = .lightGray
        label.text = "Latest in"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let img: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let topicTitle: CustomLabel = {
        let label = CustomLabel()
        label.text = "-"
//        label.textColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}







// MARK: GET STARTED VIEW CONTROLLER






class SignupOptions: UIViewController {
    var delegate: blackViewProtocol?
    var selectedOptions: SelectedLoginOption?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(PanGestureFunc)))

        constraintContainer()
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

            }else {
                delegate?.changeBlackView()
                dismiss(animated: true, completion: nil)
            }
        default:
            break
        }
        }
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
        label.attributedText = NSAttributedString(string: "Welcome", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 32)])
        
        label.translatesAutoresizingMaskIntoConstraints  = false
        return label
    }()
    
    
    fileprivate let viewDescription: CustomLabel = {
        let label = CustomLabel()
        label.numberOfLines = 2
        label.attributedText = NSAttributedString(string: "Before we start, continue \nwith one of these options.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular)])
        
        label.translatesAutoresizingMaskIntoConstraints  = false
        return label
    }()
    
    
    fileprivate let seperatorLineView: CustomView = {
       let view = CustomView()
        view.backgroundColor = .darkGray
        
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()

    
    fileprivate let appleButton: UIButton = {
        let button  = UIButton()
        button.backgroundColor = .black
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.white.cgColor
        button.setAttributedTitle(NSAttributedString(string: "Continue with Apple", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]), for: .normal)
        button.addTarget(self, action: #selector(AppleLoginSelected), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    fileprivate let appleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "appleIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
       return imageView
    }()

    
    fileprivate let emailButton: UIButton = {
        let button  = UIButton()
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.setAttributedTitle(NSAttributedString(string: "Continue with Google", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]), for: .normal)

//        button.addTarget(self, action: #selector(emailSigninPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    fileprivate let emailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "googleLogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
       return imageView
    }()
    fileprivate let phoneButton: UIButton = {
        let button  = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.backgroundColor = .white
        button.setAttributedTitle(NSAttributedString(string: "Continue with phone", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]), for: .normal)
        button.addTarget(self, action: #selector(PhoneSigninSelected), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    fileprivate let phoneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "PhoneIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
       return imageView
    }()
    
    

    
    fileprivate let otherEmailTypesButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.setAttributedTitle(NSAttributedString(string: "Sign up with email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]), for: .normal)
        button.addTarget(self, action: #selector(OtherEmailSelected), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    fileprivate let emailImageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "emailIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
       return imageView
    }()
    
    fileprivate let termsOfUseButton: UIButton = {
        let button = UIButton()

        button.setAttributedTitle(NSAttributedString(string: "By signing up, you agree with News Terms of use and Privacy Policy", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10),NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]), for: .normal)
        button.addTarget(self, action: #selector(TermsOfUseSelected), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private func constraintContainer(){
        
        view.addSubview(whiteView)
            whiteView.addSubview(viewBar)
            whiteView.addSubview(viewTitle)
            whiteView.addSubview(viewDescription)
        
        whiteView.addSubview(appleButton)
            appleButton.addSubview(appleImageView)
        whiteView.addSubview(phoneButton)
            phoneButton.addSubview(phoneImageView)
        whiteView.addSubview(emailButton)
            emailButton.addSubview(emailImageView)
        
            whiteView.addSubview(seperatorLineView)
        whiteView.addSubview(otherEmailTypesButton)
        otherEmailTypesButton.addSubview(emailImageView2)
        whiteView.addSubview(termsOfUseButton)
        
        NSLayoutConstraint.activate([
            viewBar.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 8),
            viewBar.widthAnchor.constraint(equalToConstant: 40),
            viewBar.heightAnchor.constraint(equalToConstant: 6),
            viewBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            whiteView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            whiteView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            whiteView.heightAnchor.constraint(equalToConstant: 400),
            whiteView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            viewTitle.topAnchor.constraint(equalTo: viewBar.topAnchor, constant: 8),
            viewTitle.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 16),
            viewTitle.heightAnchor.constraint(equalToConstant: viewTitle.intrinsicContentSize.height),
            
            viewDescription.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 8),
            viewDescription.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 16),
            viewDescription.widthAnchor.constraint(equalTo: whiteView.widthAnchor),
            
            appleButton.topAnchor.constraint(equalTo: viewDescription.bottomAnchor, constant: 16),
            appleButton.leadingAnchor.constraint(equalTo:whiteView.leadingAnchor, constant: 16),
            appleButton.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -16),

        
            emailButton.topAnchor.constraint(equalTo: appleButton.bottomAnchor, constant: 16),
            emailButton.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 16),
            emailButton.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -16),
            
            phoneButton.topAnchor.constraint(equalTo: emailButton.bottomAnchor, constant: 16),
            phoneButton.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 16),
            phoneButton.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -16),

 
            emailImageView.centerYAnchor.constraint(equalTo: emailButton.centerYAnchor),
            emailImageView.heightAnchor.constraint(equalToConstant: 18),
            emailImageView.widthAnchor.constraint(equalToConstant: 18),
            emailImageView.leadingAnchor.constraint(equalTo: emailButton.leadingAnchor, constant: 8),

            
            phoneImageView.centerYAnchor.constraint(equalTo: phoneButton.centerYAnchor),
            phoneImageView.heightAnchor.constraint(equalToConstant: 18),
            phoneImageView.widthAnchor.constraint(equalToConstant: 18),
            phoneImageView.leadingAnchor.constraint(equalTo: phoneButton.leadingAnchor, constant: 8),
                
            appleImageView.centerYAnchor.constraint(equalTo: appleButton.centerYAnchor),
            appleImageView.heightAnchor.constraint(equalToConstant: 18),
            appleImageView.widthAnchor.constraint(equalToConstant: 19),
            appleImageView.leadingAnchor.constraint(equalTo: appleButton.leadingAnchor, constant: 7.5),
            
            
            seperatorLineView.topAnchor.constraint(equalTo: phoneButton.bottomAnchor, constant: 16),
            seperatorLineView.heightAnchor.constraint(equalToConstant: 1),
            seperatorLineView.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 32),
            seperatorLineView.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -32),
            
            
            otherEmailTypesButton.topAnchor.constraint(equalTo: seperatorLineView.bottomAnchor, constant: 24),
            otherEmailTypesButton.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 16),
            otherEmailTypesButton.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -16),
            
            emailImageView2.centerYAnchor.constraint(equalTo: otherEmailTypesButton.centerYAnchor),
            emailImageView2.heightAnchor.constraint(equalToConstant: 18),
            emailImageView2.widthAnchor.constraint(equalToConstant: 18),
            emailImageView2.leadingAnchor.constraint(equalTo: otherEmailTypesButton.leadingAnchor, constant: 8),
            
            termsOfUseButton.topAnchor.constraint(equalTo: otherEmailTypesButton.bottomAnchor, constant: 12),
            termsOfUseButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            termsOfUseButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            

            
            
        ])
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        for letter in string{
            for i in "/:;()$&@\",?!'[]{}#%^*+=\\|~<>€£¥•,?!' "{
                if letter == i{
                    return false
                }
            }
        }
    return true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped(gesture:)))
//        view.addGestureRecognizer(tapGesture)
    }

    
//    @objc func backgroundTapped(gesture: UIGestureRecognizer) {
//        delegate?.changeBlackView()
//
//        self.dismiss(animated: true)
//
//    }
//
    @objc func AppleLoginSelected(){
        self.delegate?.changeBlackView()
        dismiss(animated: true){
            
            self.selectedOptions?.loginOptions(OptionNum: 0)
        }
    }
    @objc func GoogleLoginSelected(){
        self.delegate?.changeBlackView()
        dismiss(animated: true){
            self.selectedOptions?.loginOptions(OptionNum: 1)
        }
    }
    @objc func PhoneSigninSelected(){
        
    }
    @objc func OtherEmailSelected(){
        self.delegate?.changeBlackView()
        dismiss(animated: true){
            self.selectedOptions?.loginOptions(OptionNum: 2)
        }
    }
    
    @objc func TermsOfUseSelected(){
        let vc = AboutView()
        present(vc, animated: true)
    }
        

}



protocol logedIn {
    func user(signedIn: Bool)
}
var continueButtonBottom: NSLayoutConstraint?
var continueButtonTop: NSLayoutConstraint?





//      MARK: PHONE NUMBER VIEW

class PhoneNumberVerification: UIViewController, logedIn {
    func user(signedIn: Bool) {
        if signedIn{
            dismiss(animated: true) {
                self.delegate.user(signedIn: true)
            }
        }
    }
    
    var delegate: logedIn!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        textFieldApearing()
        constraintContainer()
    }
    
    fileprivate let ReturnBtn: UIButton = {
       let btn = UIButton()
        btn.setImage(UIImage(named: "ReturnArrow"), for: .normal)
        btn.addTarget(self, action: #selector(ReturnButtonSelected), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    fileprivate let welcomeLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.attributedText = NSAttributedString(string: "Newsbite", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)])
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    fileprivate let mobileNumberLabel: CustomLabel = {
        let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "MOBILE NUMBER", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    fileprivate let textFieldView: CustomView = {
       let view = CustomView()
       view.backgroundColor = .white
        
//        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 7.0)
        view.layer.shadowRadius = 8.0
        view.layer.shadowOpacity = 0.2
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()

    fileprivate let textField: UITextField = {
       let field = UITextField()
        field.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
        field.keyboardType = .phonePad
        field.tintColor = .lightGray

        field.translatesAutoresizingMaskIntoConstraints = false
       return field
    }()
    
    fileprivate let reasonForNumber: CustomLabel = {
        let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "To verify the account a SMS will be sent to this number.", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
//    fileprivate let skipButton: UIButton = {
//        let button = UIButton()
//        button.setAttributedTitle(NSAttributedString(string: "Skip", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15), NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]), for: .normal)
//        button.addTarget(self, action: #selector(skipButtonSelected), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    
    fileprivate let continueButton: UIButton = {
        let button = UIButton()
//        button.backgroundColor = UIColor(red: 1.00, green: 0.99, blue: 0.00, alpha: 1.00)
        button.backgroundColor = TealConstantColor
        button.setAttributedTitle(NSAttributedString(string: "Continue",  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)]), for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
//        button.contentHorizontalAlignment = .left
//        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(ContinueButtonSelected), for: .touchUpInside)
        
        button.layer.cornerRadius = 15
        button.layer.shadowColor = UIColor.lightGray.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowRadius = 10.0
        button.layer.shadowOpacity = 0.3
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    

    
    private func constraintContainer(){
        view.addSubview(ReturnBtn)
        view.addSubview(welcomeLabel)
        view.addSubview(mobileNumberLabel)
        
        view.addSubview(textFieldView)
        textFieldView.addSubview(textField)
        
        view.addSubview(reasonForNumber)
        
        view.addSubview(continueButton)
        continueButtonBottom = continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        NSLayoutConstraint.activate([
            ReturnBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            ReturnBtn.widthAnchor.constraint(equalToConstant: 28),
            ReturnBtn.heightAnchor.constraint(equalToConstant: 28),
            ReturnBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            
            welcomeLabel.topAnchor.constraint(equalTo: ReturnBtn.bottomAnchor, constant: 30),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            mobileNumberLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: view.frame.height*0.05),
            mobileNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mobileNumberLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mobileNumberLabel.heightAnchor.constraint(equalToConstant: mobileNumberLabel.intrinsicContentSize.height),
            
            textFieldView.topAnchor.constraint(equalTo: mobileNumberLabel.bottomAnchor, constant: 8),
            textFieldView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
            textFieldView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            textFieldView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.050),
            textFieldView.heightAnchor.constraint(equalToConstant:35),
            
            textField.topAnchor.constraint(equalTo: textFieldView.topAnchor, constant: 3),
            textField.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -8),
            textField.bottomAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: -3),
            
            reasonForNumber.topAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: 16),
            reasonForNumber.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            reasonForNumber.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            reasonForNumber.heightAnchor.constraint(equalToConstant: mobileNumberLabel.intrinsicContentSize.height*2),
            
            
            continueButton.widthAnchor.constraint(equalToConstant: 150),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.heightAnchor.constraint(equalToConstant: 40),
            
//            continueImageView.trailingAnchor.constraint(equalTo: continueButton.trailingAnchor, constant: -15),
//            continueImageView.heightAnchor.constraint(equalTo: continueButton.heightAnchor, multiplier: 0.5),
//            continueImageView.widthAnchor.constraint(equalTo: continueImageView.heightAnchor),
//            continueImageView.centerYAnchor.constraint(equalTo: continueButton.centerYAnchor),
            

        ])
    }
    func textFieldApearing(){
            self.textField.becomeFirstResponder()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardWillChange(notification: Notification){
        let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        UIView.animate(withDuration: 1) {
            self.continueButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -keyboardRect.height-40).isActive = true
        }

    }
    
    @objc func ContinueButtonSelected(){
//        guard let phoneNumber = textField.text else { return }
//        PhoneAuthProvider.provider().verifyPhoneNumber("+1"+phoneNumber, uiDelegate: nil) { (verificationId, error) in
//            if error == nil{
//                print(verificationId)
//                UserDefaults.standard.set(verificationId, forKey: "authVerificationID")
//
                let view = OTPVerificationView()
                view.delegate = self
                self.present(view, animated: true)
//
//            }else{
//                print("THERE WAS AN ERROR!", error?.localizedDescription)
//            }
//        }

    }
    
    @objc func ReturnButtonSelected(){
        navigationController?.popToRootViewController(animated: true)
    }
        
    
}





class OTPVerificationView: UIViewController{
        var delegate: logedIn!
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            
            textFieldApearing()
            constraintContainer()
        }
        

        
        fileprivate let mobileNumberLabel: CustomLabel = {
            let label = CustomLabel()
            label.attributedText = NSAttributedString(string: "SMS Verification Code", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        
        fileprivate let textFieldView: CustomView = {
           let view = CustomView()
           view.backgroundColor = .white
            
//            view.layer.cornerRadius = 15
            view.layer.shadowColor = UIColor.lightGray.cgColor
            view.layer.shadowOffset = CGSize(width: 0.0, height: 7.0)
            view.layer.shadowRadius = 8.0
            view.layer.shadowOpacity = 0.2
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
        }()

        fileprivate let textField: UITextField = {
           let field = UITextField()
            field.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
            field.keyboardType = .phonePad
            field.tintColor = .lightGray

            field.translatesAutoresizingMaskIntoConstraints = false
           return field
        }()
        
        fileprivate let reasonForNumber: CustomLabel = {
            let label = CustomLabel()
            label.attributedText = NSAttributedString(string: "To verify number, type in the verification code that was sent via SMS", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            label.textAlignment = .center
            label.numberOfLines = 2
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        
        fileprivate let continueButton: UIButton = {
            let button = UIButton()
            button.backgroundColor = TealConstantColor
            button.setAttributedTitle(NSAttributedString(string: "Done",  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)]), for: .normal)
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.addTarget(self, action: #selector(ContinueButtonSelected), for: .touchUpInside)
            
            button.layer.cornerRadius = 15
            button.layer.shadowColor = UIColor.lightGray.cgColor
            button.layer.shadowOffset = CGSize(width: 0.0, height: 7.0)
            button.layer.shadowRadius = 10.0
            button.layer.shadowOpacity = 0.3
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        fileprivate let continueImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "rightArrow")
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        private func constraintContainer(){
            view.addSubview(mobileNumberLabel)
            
            view.addSubview(textFieldView)
            textFieldView.addSubview(textField)
            
            view.addSubview(reasonForNumber)
            
            view.addSubview(continueButton)

            continueButtonBottom = continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
            NSLayoutConstraint.activate([

//
                mobileNumberLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height*0.05),
                mobileNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                mobileNumberLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                mobileNumberLabel.heightAnchor.constraint(equalToConstant: mobileNumberLabel.intrinsicContentSize.height),
                
                textFieldView.topAnchor.constraint(equalTo: mobileNumberLabel.bottomAnchor, constant: 8),
                textFieldView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
                textFieldView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                textFieldView.heightAnchor.constraint(equalToConstant: 35),
                
                textField.topAnchor.constraint(equalTo: textFieldView.topAnchor, constant: 3),
                textField.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor, constant: 8),
                textField.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -8),
                textField.bottomAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: -3),
                
                reasonForNumber.topAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: 16),
                reasonForNumber.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
                reasonForNumber.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
                reasonForNumber.heightAnchor.constraint(equalToConstant: mobileNumberLabel.intrinsicContentSize.height*2),
                
                
                continueButton.widthAnchor.constraint(equalToConstant: 150),
                continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                continueButton.heightAnchor.constraint(equalToConstant: 40),
                

            ])
        }
        func textFieldApearing(){
                self.textField.becomeFirstResponder()
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        }
        
        @objc func keyboardWillChange(notification: Notification){
            let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            
            UIView.animate(withDuration: 1) {
                self.continueButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -keyboardRect.height-16).isActive = true
            }

        }
        
        @objc func ContinueButtonSelected(){
//            guard let OTPCode = textField.text else { return }
//            let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")!
//
//            let credential = PhoneAuthProvider.provider().credential(
//                withVerificationID: verificationID,
//            verificationCode: OTPCode)
//
//
//            Auth.auth().signIn(with: credential) { (success, error) in
//                if error == nil {
//                    print(success, "user Signed in...")
//                    self.dismiss(animated: true, completion: {
//                        self.delegate.user(signedIn: true)
//                    })
//                } else {
//                    print("Something went wrong... \(error?.localizedDescription)")
//                }
//            }
    }
    
}





















//      MARK: TERMSOFUSE (ABOUT VIEW)

class AboutView: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        constraintContainer()
    }
    var url: String?
    
    let webView: WKWebView = {
        let view = WKWebView()
        view.backgroundColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        view.load(URLRequest(url: URL(string: "https://newsbite-trending-n.flycricket.io/privacy.html")!))
//        view.load(URLRequest(url: URL(string: "https://apps.apple.com/us/app/id1514249158")!))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private func constraintContainer(){
        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

    


