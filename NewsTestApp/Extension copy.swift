//
//  Extension.swift
//  Particle
//
//  Created by Caleb Mesfien on 10/15/20.
//  Copyright © 2020 Caleb Mesfien. All rights reserved.
//

import UIKit

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


let GreenConstantColor = UIColor(red: 33/255, green: 254/255, blue: 152/255, alpha: 1)
let MainPostColor = UIColor(red:97/255, green:75/255, blue:150/255, alpha:1)
let BlackBackgroundColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)
let LightBlackColor =  UIColor(red: 47/255, green: 50/255, blue: 55/255, alpha: 1)
let PurpleConstantColor = UIColor(red: 142/255, green: 101/255, blue: 218/255, alpha: 1)
let BlueConstantColor = UIColor(red: 40/255, green: 96/255, blue: 215/255, alpha: 1)
let RedConstantColor = UIColor(red:255/255, green:90/255, blue:96/255, alpha:1)


class CollectionViewHelper{
    let menuCollectionView = "menuCollectionView"
    let partyCollectionView = "partyCollectionView"
    let postCollectionView = "postCollectionView"
    let imagePostCollectionView = "imagePostCollectionView"
    let newPostCollectionView = "newPostCollectionView"
    let AnswerCollectionView = "AnswerCollectionView"
    
//    TABLE VIEW
    let settingsTableView  = "settingsTableView"
    let groupMembersTableView = "groupMembersTableView"
    let postSearchTableView = "postSearchTableView"
}

struct DefaultKey {
    static let signedIn = "SignedIn"
    static let formOfSignIn = "FormOfSignIn"
    static let userID = "userID"
    static let userProfileImageName = "userProfileImageName"
    static let username = "username"
    static let UserProfileImage  = "UserProfileImage"

}

let generator = UIImpactFeedbackGenerator()




protocol SearchItem {
    func FoundItem(Post: PostObject, postKey: String)
}

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

class CustomProfileImageView:  UIImageView {
    var imageNameFound: String?

    func loadImagesProperly(imageName: String){
        
        imageNameFound = imageName
        
        image = nil
        if let cachedImage = imageCache.object(forKey: imageName as NSString) as? UIImage{
            if self.imageNameFound == imageName{
            self.image = cachedImage
            return
            }
        }
            let imageRef = storageRef.reference(withPath:"/UserImages/\(imageName)")
                    imageRef.getData(maxSize: 10 * 1024 * 1024) { data, error in
                      if let error = error {
                        print(error)
                      }
    
                        DispatchQueue.main.async {
                            let downloadedImage = UIImage(data: data!)!
                            
                            if self.imageNameFound == imageName{
                                self.image = downloadedImage
                        }
                            imageCache.setObject(downloadedImage, forKey: imageName as NSString)
                        }
                    }
    }
}



class CustomPostImageView:  UIImageView {
    var imageNameFound: String?

    func loadPostImagesProperly(imageName: String){
        
        imageNameFound = imageName
        
        image = nil
        if let cachedImage = imageCache.object(forKey: imageName as NSString) as? UIImage{
            if self.imageNameFound == imageName{
            self.image = cachedImage
            return
            }
        }
            let imageRef = storageRef.reference(withPath:"/PostImages/\(imageName)")
                    imageRef.getData(maxSize: 10 * 1024 * 1024) { data, error in
                      if let error = error {
                        print(error)
                        self.image = UIImage(named: testImages.randomElement()!)
                      }
    
                        if let imageData = data{
                        DispatchQueue.main.async {
                            let downloadedImage = UIImage(data: imageData)!
                            
                            if self.imageNameFound == imageName{
                                self.image = downloadedImage
                        }
                            imageCache.setObject(downloadedImage, forKey: imageName as NSString)
                        }

                    }
                    }
    }
}



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
        spinnerView.backgroundColor = BlackBackgroundColor
        spinnerView.alpha = 0.6
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
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

