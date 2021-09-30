//
//  AccountSetup.swift
//  NewsTestApp
//
//  Created by Caleb Mesfien on 11/29/20.
//

import UIKit
import FirebaseFirestore
import RealmSwift


//          MARK: NAME VIEWCONTROLLER



class nameView: UIViewController, UITextFieldDelegate {

//    var fetchedName: String?
//    var fetchedId: String?
//    var fetchedEmail: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        view.backgroundColor = .white
        textField.delegate = self
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
        label.attributedText = NSAttributedString(string: "What's Your Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    
    fileprivate let textFieldView: CustomView = {
       let view = CustomView()
       view.backgroundColor = .white
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 7.0)
        view.layer.shadowRadius = 8.0
        view.layer.shadowOpacity = 0.2
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()

    fileprivate let textField: UITextField = {
       let field = UITextField()
        field.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22)])
        field.tintColor = .lightGray
        field.autocorrectionType = .no

        field.translatesAutoresizingMaskIntoConstraints = false
       return field
    }()
    
    fileprivate let reasonForName: CustomLabel = {
        let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "People will be able to see the name you provide.", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    fileprivate let continueButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = TealConstantColor.withAlphaComponent(0.5)
        button.setAttributedTitle(NSAttributedString(string: "Continue",  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)]), for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.clipsToBounds = true
        button.isEnabled = false
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(ContinueButtonSelected), for: .touchUpInside)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    

    
    private func constraintContainer(){
        view.addSubview(ReturnBtn)
        view.addSubview(welcomeLabel)
        view.addSubview(textFieldView)
        textFieldView.addSubview(textField)
        
        view.addSubview(reasonForName)
        
        view.addSubview(continueButton)
        continueButtonBottom = continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        NSLayoutConstraint.activate([
            ReturnBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            ReturnBtn.widthAnchor.constraint(equalToConstant: 26),
            ReturnBtn.heightAnchor.constraint(equalToConstant: 26),
            ReturnBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            
            welcomeLabel.topAnchor.constraint(equalTo: ReturnBtn.bottomAnchor, constant: 30),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            textFieldView.topAnchor.constraint(equalTo: reasonForName.bottomAnchor, constant: 8),
            textFieldView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
            textFieldView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldView.heightAnchor.constraint(equalToConstant:35),
            
            textField.topAnchor.constraint(equalTo: textFieldView.topAnchor, constant: 3),
            textField.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -8),
            textField.bottomAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: -3),
            
            reasonForName.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 8),
            reasonForName.widthAnchor.constraint(equalToConstant: 180),
            reasonForName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reasonForName.heightAnchor.constraint(equalToConstant: reasonForName.intrinsicContentSize.height*2),
            
            
            continueButton.widthAnchor.constraint(equalToConstant: 150),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.heightAnchor.constraint(equalToConstant: 40),

            

        ])
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
        
        if count >= 3{
            continueButton.backgroundColor = TealConstantColor
            continueButton.isEnabled = true
        }else{
//            continueButton.backgroundColor = UIColor(red: 255/255, green: 173/255, blue: 173/255, alpha: 1)
            continueButton.backgroundColor = TealConstantColor.withAlphaComponent(0.5)
            continueButton.isEnabled = false
        }
        return count <= 28
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
        let vc = TopicSelectorView()
        vc.providedName = textField.text!
//        vc.fetchedName = fetchedName
//        vc.fetchedId = fetchedId
//        vc.fetchedEmail = fetchedEmail
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func ReturnButtonSelected(){
        navigationController?.popViewController(animated: true)
    }
        
    
}






//          MARK: TOPIC SELECTOR VIEWCONTROLLER
let months = ["January","February","March","April","May","June","July","August","September","October","November","December"]

let cataList = ["Covid-19", "Politics","Basketball", "Fitness", "Hip-Hop", "Gaming", "Cosmetics", "Sports", "Science", "Technology", "Environment","Football", "Economy", "Business", "Entertainment", "Fashion","World", "Elon Musk", "Music", "Art"]
class TopicSelectorView: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
//    var fetchedName: String?
//    var fetchedId: String?
//    var fetchedEmail: String?
//
    var userIntrests = [String]()
    var providedName = String()
    override func viewDidLoad(){
        view.backgroundColor = .white
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.isNavigationBarHidden = true
        let date = Date()
        let format = DateFormatter()
//        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        format.dateFormat = "MM"
        let formattedDate = format.string(from: date)
        let formattedMonth = format.string(from: date)
        print(months[Int(formattedMonth)!-1])
        
        constraintContainer()
    }
    fileprivate let ReturnBtn: UIButton = {
       let btn = UIButton()
        btn.setImage(UIImage(named: "ReturnArrow"), for: .normal)
        btn.addTarget(self, action: #selector(ReturnButtonSelected), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    fileprivate let titleLabel: CustomLabel = {
       let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "Interests", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .semibold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    fileprivate let descLabel: CustomLabel = {
       let label = CustomLabel()
        label.numberOfLines = 0
        
        label.attributedText = NSAttributedString(string: "Select at least 3 topics that interest you. The articles in your feed will be composed of these topics.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .semibold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let countabel: CustomLabel = {
       let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "0/3", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .semibold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var cataCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 1.0
//        chtcollec
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(cataCollectionViewCell.self, forCellWithReuseIdentifier: "cataCollectionViewCell")
        collectionView.backgroundColor = .white
        collectionView.bounces = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    fileprivate let continueBtn: UIButton = {
       let btn = UIButton()
        btn.backgroundColor = TealConstantColor.withAlphaComponent(0.5)
        btn.isEnabled = false
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 4
        btn.addTarget(self, action: #selector(continueBtnSelected), for: .touchUpInside)
        btn.setAttributedTitle(NSAttributedString(string: "Continue", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)]), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    fileprivate func constraintContainer(){
        view.addSubview(ReturnBtn)
        view.addSubview(titleLabel)
        view.addSubview(descLabel)
        view.addSubview(countabel)
        view.addSubview(cataCollectionView)
        view.addSubview(continueBtn)
        NSLayoutConstraint.activate([
            
            ReturnBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            ReturnBtn.widthAnchor.constraint(equalToConstant: 26),
            ReturnBtn.heightAnchor.constraint(equalToConstant: 26),
            ReturnBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            
            titleLabel.topAnchor.constraint(equalTo: ReturnBtn.bottomAnchor,constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            descLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            descLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            
            countabel.bottomAnchor.constraint(equalTo: descLabel.bottomAnchor),
            countabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            cataCollectionView.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 8),
            cataCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cataCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cataCollectionView.bottomAnchor.constraint(equalTo: continueBtn.topAnchor, constant: -8),
            
            continueBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            continueBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            continueBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            continueBtn.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    @objc func ReturnButtonSelected(){
        navigationController?.popViewController(animated: true)
    }
    @objc func continueBtnSelected(){
        let realmObjc = try! Realm()
//        showSpinner(on?View: self.view)
//        var stringOfInts = ""
//
//        let vc = usernameView()
//
//        //  This creates 5 random nums in a row
//        for _ in 0...5{
//            let num = Int.random(in: 0..<10)
//            stringOfInts.append(String(num))
////            if db contains name == false{
//            if stringOfInts.count == 6{
//
//                DispatchQueue.main.async{
//                    vc.providedName = self.providedName
//                    vc.username = self.providedName
//                    vc.listOfInterests = self.userIntrests
//
////                    vc.fetchedName = self.fetchedName
////                    vc.fetchedId = self.fetchedId
////                    vc.fetchedEmail = self.fetchedEmail
//                    self.navigationController?.pushViewController(vc, animated: true)
//                }
//            }else{
////                continueBtnSelected()
//            }
////        }
//        }
        let darkModeObjc = DarkMode()
        let autoReaderObjc = AutoReaderMode()
        let userObjc = userObject()

        darkModeObjc.isDarkMode = false
        autoReaderObjc.isOn = true
        userObjc.name = providedName
        for i in userIntrests{
            userObjc.interests.append(i)
        }
        
        try! realmObjc.write{
            realmObjc.add(darkModeObjc)
            realmObjc.add(autoReaderObjc)
            realmObjc.add(userObjc)
        }
        
        
        let vc = CustomTabBarController()
        DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }
    
    
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cataCollectionViewCell", for: indexPath) as! cataCollectionViewCell
        cell.tag = indexPath.row
        
        if cell.tag == indexPath.row{
        if userIntrests.contains(cataList[indexPath.row]){
            cell.dimView.alpha = 0.75
        }else{
            cell.dimView.alpha = 0.3
            
        }
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 12
        cell.cataImageView.image = UIImage(named: cataList[indexPath.row])
        cell.title.text = "#"+cataList[indexPath.row]
        }
        return cell
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        var size = CGSize()
//        size.height = 150;
//
//        let screenSize = UIScreen.main.bounds.size
//
//        if(indexPath.item % 4 == 0 || indexPath.item % 4 == 3)
//        {
//            // Size : 1/4th of screen
//            size.width = screenSize.width * 0.35;
//        }
//        else
//        {
//            // Size : 3/4th of screen
//            size.width = screenSize.width * 0.65;
//
//        }
//        return size
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.frame.width/2-12
//        let itemHeight = 220
        return CGSize(width: itemWidth, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, columnCountFor section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if userIntrests.contains(cataList[indexPath.row]){
            userIntrests.removeAll{ $0 == cataList[indexPath.row] }
        }else{
            userIntrests.append(cataList[indexPath.row])
        }
        if userIntrests.count >= 3{
            continueBtn.isEnabled = true
            continueBtn.backgroundColor = TealConstantColor
        }else{
            continueBtn.isEnabled = false
            continueBtn.backgroundColor = TealConstantColor.withAlphaComponent(0.5)
        }
        
        countabel.text = "\(userIntrests.count)/3"
        collectionView.reloadData()
    }
}

class cataCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        constraintContainer()
        
    }

    fileprivate let cataImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    fileprivate let dimView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    fileprivate let title: CustomLabel = {
        let label = CustomLabel()
        label.textColor = UIColor.white
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate func constraintContainer(){
        addSubview(cataImageView)
        addSubview(dimView)
        addSubview(title)
        NSLayoutConstraint.activate([
            cataImageView.topAnchor.constraint(equalTo: topAnchor),
            cataImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cataImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cataImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            dimView.topAnchor.constraint(equalTo: topAnchor),
            dimView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dimView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dimView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4),
            title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




//          MARK: USERNAME VIEWCONTROLLER
class usernameView: UIViewController, UITextFieldDelegate {
    var fetchedName: String?
    var fetchedId: String?
    var fetchedEmail: String?
    
    var providedName = String()
    var listOfInterests: [String]?
    var accountType = String()
    var hasImage = false
    var username = String(){
        didSet{
            var stringOfInts = ""
            username.removeAll  {$0 == " "}

            if username.count >= 22{
//                let index = username.index(username.startIndex, offsetBy: 22)
                
                for _ in 0...5{
                    let num = Int.random(in: 0..<10)
                    stringOfInts.append(String(num))
        //            if db contains name == false{
                    if stringOfInts.count == 6{
                        textField.text = String(username.prefix(22)) + stringOfInts
                    }
                }
            }else{
                for _ in 0...5{
                    let num = Int.random(in: 0..<10)
                    stringOfInts.append(String(num))
        //            if db contains name == false{
                    if stringOfInts.count == 6{
                        textField.text = username+stringOfInts
                    }
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        view.backgroundColor = .white
        textField.delegate = self
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
    
    
    fileprivate lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"placeholderProfileImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = (view.frame.height*0.15)/2
        imageView.translatesAutoresizingMaskIntoConstraints = false
       return imageView
    }()
    
    fileprivate let changeProfileImage: UIButton = {
       let btn = UIButton()
        btn.setAttributedTitle(NSAttributedString(string: "Change Profile Image", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.systemBlue]), for: .normal)
        btn.titleLabel?.tintColor = .systemBlue
        btn.titleLabel?.textAlignment = .center
        btn.addTarget(self, action: #selector(ChangeImageSelected), for: .touchUpInside)
        btn.titleLabel!.font = .systemFont(ofSize: 10, weight: .semibold)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    fileprivate let welcomeLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.attributedText = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    
    fileprivate let textFieldView: CustomView = {
       let view = CustomView()
       view.backgroundColor = .white
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 7.0)
        view.layer.shadowRadius = 8.0
        view.layer.shadowOpacity = 0.2
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()

    fileprivate let textField: UITextField = {
       let field = UITextField()
        field.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22)])
        field.tintColor = .lightGray
        field.autocorrectionType = .no

        field.translatesAutoresizingMaskIntoConstraints = false
       return field
    }()
    
    fileprivate let reasonForName: CustomLabel = {
        let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "This is the name friends will use to find you.", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
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
        button.clipsToBounds = true
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(ContinueButtonSelected), for: .touchUpInside)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    

    
    private func constraintContainer(){
        view.addSubview(ReturnBtn)
        view.addSubview(profileImage)
        view.addSubview(changeProfileImage)
        view.addSubview(welcomeLabel)
        view.addSubview(textFieldView)
        textFieldView.addSubview(textField)
        
        view.addSubview(reasonForName)
        
        view.addSubview(continueButton)
        continueButtonBottom = continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        NSLayoutConstraint.activate([
            ReturnBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            ReturnBtn.widthAnchor.constraint(equalToConstant: 26),
            ReturnBtn.heightAnchor.constraint(equalToConstant: 26),
            ReturnBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            
            profileImage.topAnchor.constraint(equalTo: ReturnBtn.bottomAnchor, constant: 8),
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15),
            profileImage.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15),


            changeProfileImage.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 8),
            changeProfileImage.centerXAnchor.constraint(equalTo: profileImage.centerXAnchor),
            
            welcomeLabel.topAnchor.constraint(equalTo: changeProfileImage.bottomAnchor, constant: 30),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            textFieldView.topAnchor.constraint(equalTo: reasonForName.bottomAnchor, constant: 8),
            textFieldView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
            textFieldView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldView.heightAnchor.constraint(equalToConstant:35),
            
            textField.topAnchor.constraint(equalTo: textFieldView.topAnchor, constant: 3),
            textField.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -8),
            textField.bottomAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: -3),
            
            reasonForName.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 8),
            reasonForName.widthAnchor.constraint(equalToConstant: 180),
            reasonForName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            

            
            
            continueButton.widthAnchor.constraint(equalToConstant: 150),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.heightAnchor.constraint(equalToConstant: 40),

            

        ])
    }
    
    
    @objc func ChangeImageSelected(){
        let pickerController = UIImagePickerController()
        pickerController.allowsEditing = true
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        self.present(pickerController, animated: true, completion: nil)
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
        
        if count >= 3{
            continueButton.backgroundColor = TealConstantColor
            continueButton.isEnabled = true
        }else{
            continueButton.backgroundColor = TealConstantColor.withAlphaComponent(0.5)
            continueButton.isEnabled = false
        }
        return count <= 28
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
        let dateJoined = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM-dd-yyyy"
        let date = dateFormatter.string(from: dateJoined)

        guard let interests = listOfInterests else{return}
        guard interests.count >= 3 else{return}

        guard let usernameText = textField.text else{return}
        guard usernameText.count >= 6 else{return}
        
        
        let vc = CustomTabBarController()
        let realm2 = try! Realm()

        db.collection("user").whereField("username", isEqualTo:usernameText).getDocuments { [self] (QuerySnapshot, error) in
            if let error = error{
                print(error)
            }else{
                if QuerySnapshot!.isEmpty{
                    print("Not Found !")
//
                    let doc = db.collection("user").document()
                    doc.setData(["userId" : fetchedId!, "fetchedName":fetchedName!, "fetchedEmail": fetchedEmail!, "name": providedName, "username":usernameText, "interests":interests, "DateJoined":date, "accountType":accountType])
                    

                    let item = userObject()
                    item.name = providedName
                    item.username = usernameText
                    item.followerCount = 0
                    item.followingCount = 0
                    if hasImage == false{
                        item.image = nil
                    }else{
                        item.image = profileImage.image?.pngData() as NSData?
                    }
                    item.Id = String(describing: doc.documentID)
                    item.joinedDate = date
                    for i in interests{
                        item.interests.append(i)
                    }
                    
                    DispatchQueue.main.async {
                        try! realm2.write(){
                            realm2.deleteAll()
                            realm2.add(item)
                            print(item)
                        }
                    }

                    
//                    print(Realm.Configuration.defaultConfiguration.fileURL)
//                    let results = realm2.objects(userObject.self)
//                    print(results)
//                    let item = userObject()
//                    item.name = "providedName"
//                    item.username = "username"
//                    item.followerCount = 0
//                    item.followingCount = 0
//                    item.image = nil
//            //        item.joinedDate = date
//            //        for i in interests{
//            //            item.interests.append(i)
//            //        }
//
//                    try! realm2.write(){
//                        realm2.add(item)
//                        print("Done")
//                    }
//                    print("HERE is your account", realm2.objects(userObject.self)[0])
                    

                }else{

                    print("found")
                    reasonForName.attributedText = NSAttributedString(string: "This username is already in use. Select another username.", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.red])

                    DispatchQueue.main.asyncAfter(deadline: .now()+2.5) {
                        self.reasonForName.attributedText = NSAttributedString(string: "This is the name friends will use to find you.", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                    }
                }
            }
        }
        self.navigationController?.pushViewController(vc, animated: true)

        
    }
    
    @objc func ReturnButtonSelected(){
        navigationController?.popViewController(animated: true)
    }
        
    
}
extension usernameView: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            self.profileImage.image = image
            hasImage = true
            dismiss(animated: true, completion: nil)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
