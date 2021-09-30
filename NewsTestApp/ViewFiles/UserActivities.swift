//
//  UserActivities.swift
//  NewsTestApp
//
//  Created by Caleb Mesfien on 12/25/20.
//

import UIKit
import RealmSwift
import StoreKit

class UserSettings: UIViewController{
    let realmObjc = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        if realmObjc.objects(DarkMode.self)[0].isDarkMode{
            view.backgroundColor = .black
            navigationController?.navigationBar.barTintColor = .black
        }else{
            view.backgroundColor = UIColor(red: 242/255, green: 241/255, blue: 246/255, alpha: 1)
            navigationController?.navigationBar.barTintColor = .white
        }
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        
        view.addSubview(settingsTableView)
        settingsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        settingsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: settingsTableView)

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
        if subViewColor == .white{
            UIApplication.shared.statusBarStyle = .lightContent
        }else{
            UIApplication.shared.statusBarStyle = .darkContent
        }
    }
    fileprivate let settingsTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = true
        tableView.tableFooterView = UIView()
        
        tableView.register(settingsTableViewCell.self, forCellReuseIdentifier: "SettingTableView")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
}




let userLabelText = ["Screen Name","User Handle", "Identifier"]
let preferencesLabelText = ["Dark Mode", "Auto Reader Mode", "Browser"]
let settingsLabelText = ["Rate App", "Terms & Conditions", "Version 1.0", "Log Out"]
let removeAccountText = ["Delete Account"]
extension UserSettings: UITableViewDelegate, UITableViewDataSource{

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return userLabelText.count
        } else if section == 1 {
            return preferencesLabelText.count
        }else if section == 2{
            return settingsLabelText.count
        }else{
            return 1
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = [userLabelText,preferencesLabelText, settingsLabelText,removeAccountText]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableView", for: indexPath) as! settingsTableViewCell
        cell.selectionStyle = .none
        
        if indexPath.section == 2{
            if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 4{
                cell.interactiveCell = true
            }
            if indexPath.row == 3{
                cell.cellLabel.alpha = 0.3
                cell.interactiveCell = true
            }
            if indexPath.row == 2{
                cell.cellResponse.text = "v1.000.001"
                cell.cellResponseActive = true
            }
        }
        
        cell.cellLabel.text = item[indexPath.section][indexPath.row]

        if indexPath.section == 1{
            if indexPath.row == 0{
                let Switch = UISwitch(frame: .zero)
                if realmObjc.objects(DarkMode.self)[0].isDarkMode{
                    Switch.setOn(true, animated: true)
                }else{
                    Switch.setOn(false, animated: true)
                }
                Switch.tag = indexPath.row
                Switch.addTarget(self, action: #selector(SwitchFlipped(_:)), for: .valueChanged)
                cell.accessoryView = Switch
            }
            if indexPath.row == 1{
                let Switch = UISwitch(frame: .zero)
                if realmObjc.objects(AutoReaderMode.self)[0].isOn{
                    Switch.setOn(true, animated: true)
                }else{
                    Switch.setOn(false, animated: true)
                }
                Switch.tag = indexPath.row
                Switch.addTarget(self, action: #selector(SwitchFlipped(_:)), for: .valueChanged)
                cell.accessoryView = Switch
            }else if indexPath.row == 2{
                cell.cellResponse.text = "Safari"
                cell.cellResponseActive = true
            }
        }
        
        if indexPath.section == 0{
            switch indexPath.row{
                case 0:
                    cell.cellResponse.text = realmObjc.objects(userObject.self)[0].name
//                    cell.cellResponse.text = "user292571950"
                    cell.cellResponseActive = true
                case 1:
//                    cell.cellResponse.text = realmObjc.objects(userObject.self)[0].username
                    cell.cellResponse.text = "@user292571950"
                    cell.cellResponseActive = true
                case 2:
                    cell.cellResponse.text = "None"
                    cell.cellResponseActive = true
                default:
                    print("nil")
            }
        
        }else if indexPath.section == 3{
            cell.cellLabel.attributedText = NSAttributedString(string: "Delete Account", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemRed])
            cell.cellLabel.alpha = 0.3
            cell.interactiveCell = true
        }

        return cell
    }
    
    @objc func SwitchFlipped(_ sender: UISwitch){
        print(sender.tag, sender.isOn)
        if sender.tag == 0{
            try! realmObjc.write{
                realmObjc.objects(DarkMode.self)[0].isDarkMode = sender.isOn
            }
        }else{
            try! realmObjc.write{
//                realmObjc.add(objc)
                realmObjc.objects(AutoReaderMode.self)[0].isOn = sender.isOn
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 38
    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let sectionHeaderTitle = ["User", "Preferences", "Settings", ""]
//        return sectionHeaderTitle[section]
//    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2{
            if indexPath.row == 0{
                let view = SKStoreProductViewController()
                view.delegate = self as? SKStoreProductViewControllerDelegate

                view.loadProduct(withParameters: [SKStoreProductParameterITunesItemIdentifier: 1539330378])
                            present(view, animated: true, completion: nil)
            }
            if indexPath.row == 1{
                let vc = AboutView()
                present(vc, animated: true)
            }
        }
    }
    
}



class settingsTableViewCell: UITableViewCell{
    var interactiveCell = false {
        didSet{
            if interactiveCell == true{
                self.addSubview(arrowImage)

                NSLayoutConstraint.activate([
                    arrowImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18),
                    arrowImage.heightAnchor.constraint(equalToConstant: 18),
                    arrowImage.widthAnchor.constraint(equalToConstant: 18),
                    arrowImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                ])

            }
        }
    }
    var cellResponseActive = false {
        didSet{
            if cellResponseActive == true{
                self.addSubview(cellResponse)

                NSLayoutConstraint.activate([
                    cellResponse.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18),
                    cellResponse.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                    cellResponse.leadingAnchor.constraint(equalTo: cellLabel.trailingAnchor, constant: 12)
                ])

            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if subViewColor == .black{
            backgroundColor = .white
        }else{
            self.backgroundColor = BlackBackgroundColor
        }

        constraintContainer()
    }
    
    
    fileprivate let cellLabel: CustomLabel = {
       let label = CustomLabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = subViewColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    fileprivate lazy var arrowImage: UIImageView = {
       let imageView = UIImageView()
        if subViewColor == UIColor.white{
            imageView.image = UIImage(named: "WhiteRightArrow")
        }else{
            imageView.image = UIImage(named: "BlackRightArrow")
        }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate let cellResponse: CustomLabel = {
       let label = CustomLabel()
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = subViewColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate func constraintContainer(){
        self.addSubview(cellLabel)
        NSLayoutConstraint.activate([
            cellLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cellLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
//            cellLabel.widthAnchor.constraint(equalToConstant: 115)
        
        ])
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    
    
    
    
class InstagramStoryPostView: UIViewController{
    let realmObjc = try! Realm()
    
    var PostImage: UIImage?
    var TitleText: String?
    var Publication: String?
    var DescriptionText: String?
    var Date: String?
    var MainWhiteViewHeight: NSLayoutConstraint?
    var delegate: blackViewProtocol?
    var SubColorItem: UIColor?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(PanGestureFunc)))
        view.backgroundColor = .clear
        SubColorItem = UIColor.white
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
        view.backgroundColor = BlackBackgroundColor
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

    
    fileprivate lazy var sendBtn: UIButton = {
       let btn = UIButton()
        btn.backgroundColor = TealConstantColor
        btn.layer.cornerRadius = 3
        btn.setAttributedTitle(NSAttributedString(string: "Post", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .semibold)]), for: .normal)
        btn.addTarget(self, action: #selector(SendBtnSelected), for: .touchUpInside)
        if realmObjc.objects(DarkMode.self)[0].isDarkMode == false{
            btn.layer.shadowColor = UIColor.lightGray.cgColor
            btn.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            btn.layer.shadowRadius = 5.0
            btn.layer.shadowOpacity = 0.4
        }
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    fileprivate let viewDesc: CustomLabel = {
       let label = CustomLabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedText = NSAttributedString(string: "Post this story on your Instagram story.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10, weight: .semibold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
//
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
    
    fileprivate lazy var TopicImage: CustomImageView2 = {
        let view = CustomImageView2()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .clear
        view.layer.cornerRadius = 20
//        view.image = UIImage(named: "BlankBackground")
        view.image = PostImage
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


    fileprivate lazy var TopicTitle: CustomLabel = {
        let label = CustomLabel()
        label.numberOfLines = 0
//        label.adjustsFontSizeToFitWidth = true
        label.attributedText = NSAttributedString(string: TitleText!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .bold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var TopicDesc: CustomLabel = {
        let label = CustomLabel()
        label.numberOfLines = 3

//        UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        label.attributedText = NSAttributedString(string: DescriptionText!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    fileprivate lazy var PublicationName: CustomLabel = {
        let label = CustomLabel()
        label.attributedText = NSAttributedString(string: Publication!, attributes: [NSAttributedString.Key.foregroundColor: SubColorItem, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    fileprivate lazy var DoteSeperator: CustomLabel = {
        let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "•", attributes: [NSAttributedString.Key.foregroundColor: SubColorItem, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    fileprivate lazy var DateOfTopic: CustomLabel = {
        let label = CustomLabel()
        label.attributedText = NSAttributedString(string: Date!, attributes: [NSAttributedString.Key.foregroundColor: SubColorItem, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let NewsBite: CustomLabel = {
        let lbl = CustomLabel()
         lbl.attributedText = NSAttributedString(string: "@Newsbite", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .semibold)])
         lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
 //
    let slider: UISlider = {
       let slider = UISlider()
//        slider.minimumValue = 62
        slider.maximumValue = 300
        slider.value = 0
        slider.isContinuous = true
        slider.tintColor = subViewColor
        slider.addTarget(self, action: #selector(sliderValueDidChange(_:)), for: .valueChanged)

        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    let smallImg: UIImageView = {
       let img = UIImageView()
        if subViewColor == .white{
            img.image = UIImage(named: "smallRectangleWhite")
        }else{
            img.image = UIImage(named: "smallRectangle")
        }
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let bigImg: UIImageView = {
       let img = UIImageView()
        if subViewColor == .white{
            img.image = UIImage(named: "bigRectangleWhite")
        }else{
            img.image = UIImage(named: "bigRectangle")
        }
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    func constraintContainer(){
        view.addSubview(MainWhiteView)
        MainWhiteView.addSubview(slider)
        MainWhiteView.addSubview(smallImg)
        MainWhiteView.addSubview(bigImg)
        
        MainWhiteView.addSubview(viewBar)
        MainWhiteView.addSubview(mainViewCard)
        mainViewCard.addSubview(TopicImage)
        mainViewCard.addSubview(DimTopicLayer)
        mainViewCard.addSubview(TopicTitle)
        mainViewCard.addSubview(NewsBite)

            mainViewCard.addSubview(TopicDesc)
        
            mainViewCard.addSubview(PublicationName)
            mainViewCard.addSubview(DoteSeperator)
            mainViewCard.addSubview(DateOfTopic)
        
        MainWhiteView.addSubview(sendBtn)
        MainWhiteView.addSubview(viewDesc)
        
        MainWhiteViewHeight = MainWhiteView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.9)
        NSLayoutConstraint.activate([
            
            MainWhiteViewHeight!,
            MainWhiteView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            MainWhiteView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            MainWhiteView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            viewBar.topAnchor.constraint(equalTo: MainWhiteView.topAnchor, constant: 12),
            viewBar.widthAnchor.constraint(equalToConstant: 40),
            viewBar.heightAnchor.constraint(equalToConstant: 6),
            viewBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            

            
            sendBtn.bottomAnchor.constraint(equalTo: viewDesc.topAnchor, constant: -4),
            sendBtn.heightAnchor.constraint(equalToConstant: 40),
            sendBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            sendBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            viewDesc.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -4),
            viewDesc.widthAnchor.constraint(equalToConstant: 175),
            viewDesc.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewDesc.heightAnchor.constraint(equalToConstant: viewDesc.intrinsicContentSize.height*2),
            
//            THIS IS THE VIEW THAT WILL BE SENT TO INSTAGRAM -->
            
            
            mainViewCard.topAnchor.constraint(equalTo: viewBar.bottomAnchor, constant: 8),
            mainViewCard.centerXAnchor.constraint(equalTo: MainWhiteView.centerXAnchor),
            mainViewCard.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95),
            mainViewCard.bottomAnchor.constraint(equalTo: slider.topAnchor, constant: -12),
 
 
            slider.bottomAnchor.constraint(equalTo: sendBtn.topAnchor, constant: -12),
            slider.widthAnchor.constraint(equalToConstant: 200),
            slider.heightAnchor.constraint(equalToConstant: 20),
            slider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
 

            smallImg.leadingAnchor.constraint(equalTo: slider.trailingAnchor, constant: 8),
            smallImg.centerYAnchor.constraint(equalTo: slider.centerYAnchor),
            smallImg.heightAnchor.constraint(equalToConstant: 20),
            smallImg.widthAnchor.constraint(equalToConstant: 20),
            
            bigImg.trailingAnchor.constraint(equalTo: slider.leadingAnchor, constant: -8),
            bigImg.centerYAnchor.constraint(equalTo: slider.centerYAnchor),
            bigImg.heightAnchor.constraint(equalToConstant: 22),
            bigImg.widthAnchor.constraint(equalToConstant: 20),
 //            TopicView.topAnchor.constraint(equalTo: mainViewCard.topAnchor, constant: 8),
 //            TopicView.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor),
 //            TopicView.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor),
 //            TopicView.bottomAnchor.constraint(equalTo: mainViewCard.bottomAnchor),
 
             TopicImage.topAnchor.constraint(equalTo: mainViewCard.topAnchor),
             TopicImage.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor),
             TopicImage.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor),
             TopicImage.bottomAnchor.constraint(equalTo: mainViewCard.bottomAnchor),
 
             DimTopicLayer.topAnchor.constraint(equalTo: mainViewCard.topAnchor),
             DimTopicLayer.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor),
             DimTopicLayer.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor),
             DimTopicLayer.bottomAnchor.constraint(equalTo: mainViewCard.bottomAnchor),
 
             TopicTitle.topAnchor.constraint(equalTo: mainViewCard.topAnchor, constant: 12),
             TopicTitle.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor, constant: 12),
             TopicTitle.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor, constant: -8),
 
             TopicDesc.topAnchor.constraint(equalTo:TopicTitle.bottomAnchor ,constant: 8),
             TopicDesc.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor, constant: 12),
             TopicDesc.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor, constant: -16),
 
             PublicationName.topAnchor.constraint(equalTo: TopicDesc.bottomAnchor, constant: 8),
             PublicationName.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor, constant: 12),
            PublicationName.widthAnchor.constraint(equalToConstant: PublicationName.intrinsicContentSize.width),
 
             DoteSeperator.topAnchor.constraint(equalTo: TopicDesc.bottomAnchor, constant: 8),
             DoteSeperator.leadingAnchor.constraint(equalTo: PublicationName.trailingAnchor, constant: 4),
 
 
             DateOfTopic.topAnchor.constraint(equalTo: TopicDesc.bottomAnchor, constant: 8),
             DateOfTopic.leadingAnchor.constraint(equalTo: DoteSeperator.leadingAnchor, constant: 8),
             DateOfTopic.trailingAnchor.constraint(equalTo: mainViewCard.trailingAnchor, constant: -4),
 
            NewsBite.bottomAnchor.constraint(equalTo: mainViewCard.bottomAnchor, constant: -12),
            NewsBite.leadingAnchor.constraint(equalTo: mainViewCard.leadingAnchor, constant: 12)
            
            
        ])
    }

//    @objc func backgroundTapped(gesture: UIGestureRecognizer) {
//
//
//    }
    
    @objc func sliderValueDidChange(_ sender:UISlider!)
    {
        print("Slider value changed")

        let num: CGFloat = CGFloat(sender.value)
//        MainWhiteViewHeight = MainWhiteView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: num)
        MainWhiteViewHeight?.constant = -num
//        view.layoutIfNeeded()
//        view.layoutSubviews()
        print("Slider step value \(num)")
    }
    
    @objc func SendBtnSelected(){
        delegate?.changeBlackView()
        self.dismiss(animated: true)
        
        let renderer = UIGraphicsImageRenderer(size: mainViewCard.bounds.size)
        let image = renderer.image { ctx in
            mainViewCard.drawHierarchy(in: mainViewCard.bounds, afterScreenUpdates: true)
        }
        if let storiesUrl = URL(string: "instagram-stories://share"){
            if UIApplication.shared.canOpenURL(storiesUrl) {
                guard let pngImage = image.pngData() else {return}
                let pastboardItems: [String: Any] = [
                    "com.instagram.sharedSticker.stickerImage": pngImage,
//                        "com.instagram.sharedSticker.backgroundTopColor": "#000000",
//                        "com.instagram.sharedSticker.backgroundBottomColor": "#000000"
//                        "com.instagram.sharedSticker.backgroundBottomColor": "#ff5a60"
                ]
                let pastboardOptions = [
                    UIPasteboard.OptionsKey.expirationDate: Foundation.Date().advanced(by: 300)
                ]

                UIPasteboard.general.setItems([pastboardItems], options: pastboardOptions)
                UIApplication.shared.open(storiesUrl, options: [:], completionHandler: nil)
            }else{
                print("User doesn't have instagram")
            }
        }    }

}
