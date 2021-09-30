//
//  Extension.swift
//  Particle
//
//  Created by Caleb Mesfien on 10/15/20.
//  Copyright © 2020 Caleb Mesfien. All rights reserved.
//

import UIKit
import Lottie
let userDef = UserDefaults.standard



let testImages = ["defaultImage1", "defaultImage2", "defaultImage3","defaultImage4", "defaultImage5"]


protocol blackViewProtocol {
    func changeBlackView()
}

protocol LogOutDelegate {
    func logoutFunc()
}
protocol StartJoiningGroup {
    func joinGroup(ViewNum: Int)
}
extension Date {
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
//let TealConstantColor = UIColor(red: 0/255, green: 191/255, blue: 152/255, alpha: 1)

let TealConstantColor = UIColor(red: 146/255, green: 75/255, blue: 255/255, alpha: 1)
//let BlackBackgroundColor = UIColor.white
//let subViewColor = UIColor.black
//    UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)


//let TealConstantColor = UIColor(red: 123/255, green: 0/255, blue: 255/255, alpha: 1)
let GreenConstantColor = UIColor(red: 33/255, green: 254/255, blue: 152/255, alpha: 1)
let MainPostColor = UIColor(red:97/255, green:75/255, blue:150/255, alpha:1)
let LightBlackColor =  UIColor(red: 47/255, green: 50/255, blue: 55/255, alpha: 1)
let PurpleConstantColor = UIColor(red: 142/255, green: 101/255, blue: 218/255, alpha: 1)
let BlueConstantColor = UIColor(red: 40/255, green: 96/255, blue: 215/255, alpha: 1)
//let RedConstantColor = UIColor(red: 255/255, green: 90/255, blue: 96/255, alpha: 1)


//class CollectionViewHelper{
//    let menuCollectionView = "menuCollectionView"
//    let partyCollectionView = "partyCollectionView"
//    let postCollectionView = "postCollectionView"
//    let imagePostCollectionView = "imagePostCollectionView"
//    let newPostCollectionView = "newPostCollectionView"
//    let AnswerCollectionView = "AnswerCollectionView"
//    
////    TABLE VIEW
//    let settingsTableView  = "settingsTableView"
//    let groupMembersTableView = "groupMembersTableView"
//    let postSearchTableView = "postSearchTableView"
//}

struct DefaultKey {
    static let signedIn = "SignedIn"
    static let formOfSignIn = "FormOfSignIn"
    static let userID = "userID"
    static let userProfileImageName = "userProfileImageName"
    static let username = "username"
    static let UserProfileImage  = "UserProfileImage"

}

let generator = UIImpactFeedbackGenerator()




protocol CreateNewProtocol {
    func presentCreateViewController()
    func shareGroup(GroupCode: String)
}

extension UIView{
    func addConstraintsWithFormat(format: String, views: UIView...){
        var viewDictionary: Dictionary = [String: UIView]()
        
        for (index, view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewDictionary))
    }
}


let imageCache = NSCache<NSString, AnyObject>()



extension UIViewController {

    /**
     *  Height of status bar + navigation bar (if navigation bar exist)
     */

    var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}

class CustomImageView2:  UIImageView {
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String) {
        
        imageUrlString = urlString
        
        let url = NSURL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = imageFromCache
            return
    }
        
        URLSession.shared.dataTask(with: url! as URL) { (data, response, error) in
            
            if error != nil{
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                guard let imageToCache = UIImage(data: data!) else{return}
                
                
                guard let ciimage = CIImage(image: imageToCache) else {return}
                
                
                let blurFilter = CIFilter(name: "CIGaussianBlur")
                blurFilter?.setValue(ciimage, forKey: kCIInputImageKey)
                blurFilter?.setValue(1.5, forKey: kCIInputRadiusKey)
                
                guard let outputImage = blurFilter?.outputImage else {return}
                
                
                if self.imageUrlString == urlString {
//                    self.image = imageToCache
                    self.image = UIImage(ciImage:outputImage)
                }
//                imageCache.setObject(imageToCache!, forKey: urlString as NSString)
                imageCache.setObject(outputImage, forKey: urlString as NSString)

            }
        }.resume()
    }
}
extension String {
//    func htmlDecoded()->String {
//
//        guard (self != "") else { return self }
//
//        var newStr = self
//
//        let entities = [
//            "&quot;"    : "\"",
//            "&amp;"     : "&",
//            "&apos;"    : "'",
//            "&lt;"      : "<",
//            "&gt;"      : ">",
//            "&gt;"      : "'",
//        ]
//
//        for (name,value) in entities {
//            newStr = newStr.replacingOccurrences(of: name, with: value)
//        }
//        return newStr
//    }
//}
func htmlDecoded() -> String{

    guard let data = self.data(using: .utf8) else {
        return "nil"
    }

    let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
        .documentType: NSAttributedString.DocumentType.html,
        .characterEncoding: String.Encoding.utf8.rawValue
    ]

    guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
        return "nil"
    }
    return attributedString.string
}
}

//class CustomPostImageView:  UIImageView {
//    var imageNameFound: String?
//
//    func loadPostImagesProperly(imageName: String){
//
//        imageNameFound = imageName
//
//        image = nil
//        if let cachedImage = imageCache.object(forKey: imageName as NSString) as? UIImage{
//            if self.imageNameFound == imageName{
//            self.image = cachedImage
//            return
//            }
//        }
//            let imageRef = storageRef.reference(withPath:"/PostImages/\(imageName)")
//                    imageRef.getData(maxSize: 10 * 1024 * 1024) { data, error in
//                      if let error = error {
//                        print(error)
//                        self.image = UIImage(named: testImages.randomElement()!)
//                      }
//
//                        if let imageData = data{
//                        DispatchQueue.main.async {
//                            let downloadedImage = UIImage(data: imageData)!
//
//                            if self.imageNameFound == imageName{
//                                self.image = downloadedImage
//                        }
//                            imageCache.setObject(downloadedImage, forKey: imageName as NSString)
//                        }
//
//                    }
//                    }
//    }
//}



class CustomView: UIView {
    override var intrinsicContentSize: CGSize {
        let intrinsic = super.intrinsicContentSize
        return CGSize(width: intrinsic.width, height: intrinsic.height)
    }
}


class CustomLabel: UILabel {
    override var intrinsicContentSize: CGSize {
        let intrinsic = super.intrinsicContentSize
        return CGSize(width: intrinsic.width, height: intrinsic.height)
    }
}

class CustomImageView: UIImageView {
    override var intrinsicContentSize: CGSize {
        let intrinsic = super.intrinsicContentSize
        return CGSize(width: intrinsic.width, height: intrinsic.height)
    }
}



class AutoSizedCollectionView: UICollectionView {

    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}


extension String {
    func isEmptyOrWhitespace() -> Bool {
        
        // Check empty string
        if self.isEmpty {
            return true
        }
        // Trim and check empty string
        return (self.trimmingCharacters(in: .whitespaces) == "")
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}



var vSpinner : UIView?
 
extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
//        spinnerView.backgroundColor = BlackBackgroundColor
//        spinnerView.alpha = 0.6
//        let ai = UIActivityIndicatorView.init(style: .medium)
//        ai.startAnimating()
//        ai.center = spinnerView.center
        let ai = AnimationView()
        ai.animation = Animation.named("LoadingAnimation")
        ai.animationSpeed = 1.5
        ai.play()
        ai.loopMode = .loop
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
//
        vSpinner = spinnerView
//
//        let label: CustomLabel = {
//            let label = CustomLabel()
//            label.attributedText = NSAttributedString(string: "Trending", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .semibold)])
//            label.translatesAutoresizingMaskIntoConstraints = false
//            return label
//        }()
//
//        let label2: CustomLabel = {
//            let label = CustomLabel()
//            label.attributedText = NSAttributedString(string: "Basketball", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .semibold)])
//
//            label.translatesAutoresizingMaskIntoConstraints = false
//            return label
//        }()
//
//        let label3: CustomLabel = {
//            let label = CustomLabel()
//            label.attributedText = NSAttributedString(string: "Politics", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .semibold)])
//
//            label.translatesAutoresizingMaskIntoConstraints = false
//            return label
//        }()
//
//        let loadingLabel: CustomLabel = {
//            let label = CustomLabel()
//            label.attributedText = NSAttributedString(string: "Loading Stories...", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
//
//            label.translatesAutoresizingMaskIntoConstraints = false
//            return label
//        }()
//
//
//        spinnerView.backgroundColor = .white
//        spinnerView.addSubview(label)
//        spinnerView.addSubview(label2)
//        spinnerView.addSubview(label3)
//        spinnerView.addSubview(loadingLabel)
//
//        NSLayoutConstraint.activate([
//            label3.trailingAnchor.constraint(equalTo: spinnerView.trailingAnchor, constant: -8),
//            label3.bottomAnchor.constraint(equalTo: spinnerView.safeAreaLayoutGuide.bottomAnchor, constant: -8),
//
//            label2.trailingAnchor.constraint(equalTo: spinnerView.trailingAnchor, constant: -8),
//            label2.bottomAnchor.constraint(equalTo: spinnerView.topAnchor, constant: -8),
//
//            label.trailingAnchor.constraint(equalTo: spinnerView.trailingAnchor, constant: -8),
//            label.bottomAnchor.constraint(equalTo: label2.topAnchor, constant: -8),
//
//            loadingLabel.leadingAnchor.constraint(equalTo: spinnerView.leadingAnchor, constant: 8),
//            loadingLabel.bottomAnchor.constraint(equalTo: spinnerView.safeAreaLayoutGuide.bottomAnchor, constant: -8)
//
//        ])
//
//        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
//            loadAnimation(labelSelected: label)
//        }
//
//
//
//
//
//
//
//
//    func loadAnimation(labelSelected: CustomLabel){
//        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
//            loadAnimation2(labelSelected: labelSelected)
//        }
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut) {
//            labelSelected.transform = CGAffineTransform(translationX: -150, y: 0)
//        } completion: { (_) in
//        }
//
//    }
//    func loadAnimation2(labelSelected: CustomLabel){
//        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
//            if labelSelected == label{
//                loadAnimation(labelSelected: label2)
//            }else if labelSelected == label2{
//                loadAnimation(labelSelected: label3)
//            }
//        }
//        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut) {
//            labelSelected.transform = CGAffineTransform(translationX: -150, y: -80)
//            labelSelected.alpha = 0
//        } completion: { (_) in
//        }
//    }
//
    }
//
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
    }


extension UIImage{
    func getCropRatio() -> CGFloat {
        let widthRatio = CGFloat(self.size.width / self.size.height)
        return widthRatio
    }
}

//class SpinnerViewController: UIViewController {
//    var spinner = UIActivityIndicatorView(style: .whiteLarge)
//
//    override func loadView() {
//        view = UIView()
//        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
//
//        spinner.translatesAutoresizingMaskIntoConstraints = false
//        spinner.startAnimating()
//        view.addSubview(spinner)
//
//        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//    }
//}
//extension UIViewController {
//    func showSpinner(onView : UIView) {
//        let spinnerView = UIView.init(frame: onView.bounds)
//        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
//        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
//        ai.startAnimating()
//        ai.center = spinnerView.center
//
//        DispatchQueue.main.async {
//            spinnerView.addSubview(ai)
//            onView.addSubview(spinnerView)
//        }
//
//        vSpinner = spinnerView
//    }
//
//    func removeSpinner() {
//        DispatchQueue.main.async {
//            vSpinner?.removeFromSuperview()
//            vSpinner = nil
//        }
//    }
//}











//          MARK: COMMING SOOM



//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        navigationController?.setNavigationBarHidden(true, animated: true)
//        view.backgroundColor = .white
//
//        constraintContainer()
//    }
//
//    fileprivate let NewsView: UIView = {
//       let view = UIView()
//        view.backgroundColor = .white
//
//        view.layer.cornerRadius = 16
//        view.layer.shadowColor = UIColor.lightGray.cgColor
//        view.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
//        view.layer.shadowRadius = 5.0
//        view.layer.shadowOpacity = 0.5
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//
//    fileprivate let chatCollectionView: UICollectionView = {
//       let layout = UICollectionViewFlowLayout()
//        layout.minimumLineSpacing = 24
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.backgroundColor = .clear
//        collectionView.register(chatCell.self, forCellWithReuseIdentifier: "chatCellID")
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        return collectionView
//    }()
//
//
//
//
////    INSIDE NEWSITEM
//    fileprivate let publicationImage: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "wpImage")
//        imageView.layer.cornerRadius = 35/2
//        imageView.clipsToBounds = true
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//
//    fileprivate let publicationName: CustomLabel = {
//        let label = CustomLabel()
//        label.attributedText = NSAttributedString(string: "Washington Post", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .semibold)])
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    fileprivate let PostImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "PostExample")
//        imageView.contentMode = .scaleAspectFill
//        imageView.layer.cornerRadius = 35/2
//        imageView.clipsToBounds = true
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//
//    fileprivate let TitleBlackFade: UIImageView = {
//            let view = UIImageView()
//            view.image = UIImage(named: "TopGradientImage")
//            view.alpha = 0.5
//            view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
//            view.clipsToBounds = true
//            view.layer.cornerRadius = 16
//            view.translatesAutoresizingMaskIntoConstraints = false
//            return view
//        }()
//
//
//    fileprivate let DetailsBlackFade: UIImageView = {
//        let view = UIImageView()
//        view.image = UIImage(named: "GradientImage")
//        view.alpha = 0.5
//        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//        view.clipsToBounds = true
//        view.layer.cornerRadius = 16
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    fileprivate let PostTitleLabel: CustomLabel = {
//        let label = CustomLabel()
//        label.numberOfLines = 0
//        label.attributedText = NSAttributedString(string: "The Weeknd to headline Super Bowl halftime show", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .semibold)])
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    fileprivate let DescriptionLabel: CustomLabel = {
//        let label = CustomLabel()
//        label.numberOfLines = 0
//        label.attributedText = NSAttributedString(string: "The Weeknd, the Canadian pop star, has been chosen to play the halftime show at the Super Bowl in Tampa, Fla., in February, a performance that may face challenges because of pandemic restrictions. The Weeknd has had five No. 1 hits, including “Can’t Feel My Face,” produced in part by the Swedish pop mastermind Max Martin, and “Starboy,” created with Daft Punk, the French dance-rock duo.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)])
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    fileprivate let dateLabel: CustomLabel = {
//        let label = CustomLabel()
//        label.numberOfLines = 0
//        label.attributedText = NSAttributedString(string: "2 Hours", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .regular)])
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//
//
//
//    fileprivate let chatNavBar: CustomView = {
//       let view = CustomView()
//        view.backgroundColor = .white
//
//        view.layer.cornerRadius = 14
//        view.layer.shadowColor = UIColor.lightGray.cgColor
//        view.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
//        view.layer.shadowRadius = 5.0
//        view.layer.shadowOpacity = 0.5
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//
//    fileprivate let chatLabel: CustomLabel = {
//        let label = CustomLabel()
//        label.numberOfLines = 0
//        label.attributedText = NSAttributedString(string: "Chat", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold)])
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//
//
//    fileprivate func constraintContainer(){
//
//
//
//        chatCollectionView.delegate = self
//        chatCollectionView.dataSource = self
//        view.addSubview(NewsView)
//        NewsView.addSubview(PostImageView)
//        NewsView.addSubview(TitleBlackFade)
//        NewsView.addSubview(DetailsBlackFade)
//            NewsView.addSubview(publicationImage)
//            NewsView.addSubview(publicationName)
//            NewsView.addSubview(PostTitleLabel)
//            NewsView.addSubview(dateLabel)
//            NewsView.addSubview(PostTitleLabel)
//            NewsView.addSubview(DescriptionLabel)
//
//        view.addSubview(chatNavBar)
//        chatNavBar.addSubview(chatLabel)
//
//        view.addSubview(chatCollectionView)
//
//        NSLayoutConstraint.activate([
//            NewsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            NewsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            NewsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
//            NewsView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45),
////            NewsView.bottomAnchor.constraint(equalTo: chatNavBar.topAnchor, constant: -8),
//
//            TitleBlackFade.heightAnchor.constraint(equalTo: NewsView.heightAnchor, multiplier: 0.30),
//            TitleBlackFade.leadingAnchor.constraint(equalTo: NewsView.leadingAnchor),
//            TitleBlackFade.trailingAnchor.constraint(equalTo: NewsView.trailingAnchor),
//            TitleBlackFade.topAnchor.constraint(equalTo: NewsView.topAnchor),
//
//            DetailsBlackFade.heightAnchor.constraint(equalTo: NewsView.heightAnchor, multiplier: 0.25),
//            DetailsBlackFade.leadingAnchor.constraint(equalTo: NewsView.leadingAnchor),
//            DetailsBlackFade.trailingAnchor.constraint(equalTo: NewsView.trailingAnchor),
//            DetailsBlackFade.bottomAnchor.constraint(equalTo: NewsView.bottomAnchor),
//
//                PostImageView.topAnchor.constraint(equalTo: NewsView.topAnchor),
//                PostImageView.leadingAnchor.constraint(equalTo: NewsView.leadingAnchor),
//                PostImageView.trailingAnchor.constraint(equalTo: NewsView.trailingAnchor),
//                PostImageView.bottomAnchor.constraint(equalTo: NewsView.bottomAnchor),
//
//                publicationImage.topAnchor.constraint(equalTo: NewsView.topAnchor, constant: 8),
//                publicationImage.leadingAnchor.constraint(equalTo: NewsView.leadingAnchor, constant: 8),
//                publicationImage.widthAnchor.constraint(equalToConstant: 35),
//                publicationImage.heightAnchor.constraint(equalToConstant: 35),
//
//                publicationName.leadingAnchor.constraint(equalTo: publicationImage.trailingAnchor, constant: 4),
//                publicationName.centerYAnchor.constraint(equalTo: publicationImage.centerYAnchor),
//                publicationName.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -8),
//
//                dateLabel.trailingAnchor.constraint(equalTo: NewsView.trailingAnchor, constant: -16),
//                dateLabel.centerYAnchor.constraint(equalTo: publicationName.centerYAnchor),
//                dateLabel.widthAnchor.constraint(equalToConstant: dateLabel.intrinsicContentSize.width),
//
//
//            PostTitleLabel.topAnchor.constraint(equalTo: publicationName.bottomAnchor, constant: 8),
//            PostTitleLabel.leadingAnchor.constraint(equalTo: NewsView.leadingAnchor, constant: 8),
//            PostTitleLabel.trailingAnchor.constraint(equalTo: NewsView.trailingAnchor, constant: -0),
//            PostTitleLabel.bottomAnchor.constraint(equalTo: TitleBlackFade.bottomAnchor, constant: -16),
//
//            DescriptionLabel.topAnchor.constraint(equalTo: DetailsBlackFade.topAnchor, constant: 16),
//            DescriptionLabel.leadingAnchor.constraint(equalTo: NewsView.leadingAnchor, constant: 8),
//            DescriptionLabel.trailingAnchor.constraint(equalTo: NewsView.trailingAnchor, constant: -8),
//            DescriptionLabel.bottomAnchor.constraint(equalTo: NewsView.bottomAnchor, constant: -8),
//
//
//
//
//            chatNavBar.topAnchor.constraint(equalTo: NewsView.bottomAnchor, constant: 8),
//            chatNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
//            chatNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
////            chatNavBar.heightAnchor.constraint(equalToConstant: 50),
//            chatNavBar.heightAnchor.constraint(equalToConstant: chatNavBar.intrinsicContentSize.height+32),
//
//            chatLabel.centerYAnchor.constraint(equalTo: chatNavBar.centerYAnchor),
//            chatLabel.leadingAnchor.constraint(equalTo: chatNavBar.leadingAnchor, constant: 8),
//
//
//
//
//
//            chatCollectionView.topAnchor.constraint(equalTo: chatNavBar.bottomAnchor, constant: 8),
//            chatCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            chatCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            chatCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
//
//
//        ])
//    }
//
//}
