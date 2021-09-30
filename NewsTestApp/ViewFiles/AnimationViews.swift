//
//  AnimationViews.swift
//  NewsTestApp
//
//  Created by Caleb Mesfien on 12/8/20.
//

import UIKit
import RealmSwift
import OpenGraph
import SWXMLHash
import Lottie

struct Article{
    var title: String
    var link: String
    var pubDate: String
    var description: String
}
class ParseRSS: NSObject, XMLParserDelegate{
    private var myData: Data
    var rssHeader: Article
    var items: [Article]
    override init() {
        myData = " ".data(using: .ascii)!
        rssHeader = Article(title: "", link: "", pubDate: "", description: "")
        items = []
    }
    
    func setData(data: Data) -> Void{
        if data == nil{
            return}
        
        myData = data
    }
    
    func parse() -> Void{
        let parser = XMLParser(data: myData)
        parser.delegate = self
        parser.parse()
    }
}

class LoadingTopicsScreen: UIViewController {

    var delegate: blackViewProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BlackBackgroundColor
//        navigationController?.isNavigationBarHidden = true

//        fetchImage()
        view.addSubview(imageView)
        view.addSubview(MainLabel)
        view.addSubview(animationView)
        view.addSubview(label)
        view.addSubview(subLabel)
        view.addSubview(btn)

        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            imageView.heightAnchor.constraint(equalToConstant: 110),
            imageView.widthAnchor.constraint(equalToConstant: 220),

            MainLabel.bottomAnchor.constraint(equalTo: animationView.topAnchor, constant: -8),
            MainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.heightAnchor.constraint(equalToConstant: 220),
            animationView.widthAnchor.constraint(equalToConstant: 220),
            
            label.topAnchor.constraint(equalTo: animationView.bottomAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            subLabel.topAnchor.constraint(equalTo: label.bottomAnchor),
            subLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subLabel.widthAnchor.constraint(equalToConstant: 218),
            
            btn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            btn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            btn.heightAnchor.constraint(equalToConstant: 36),

        ])

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animationView.play()
    }
    
    let animationView: AnimationView = {
       let animationView = AnimationView()
        animationView.loopMode = .loop
        animationView.animation = Animation.named("ComingSoon2")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    let imageView: UIImageView = {
       let view = UIImageView()
        view.contentMode = .scaleAspectFill
        if subViewColor == .black{
            view.image = UIImage(named: "LightBanner")
        }else{
            view.image = UIImage(named: "DarkBanner")
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let MainLabel: CustomLabel = {
        let label = CustomLabel()
        label.textColor = subViewColor
        label.numberOfLines = 2
        label.textAlignment = .center
        label.attributedText = NSAttributedString(string: "Unavailable Feature", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let label: CustomLabel = {
        let label = CustomLabel()
        label.textColor = subViewColor
        label.numberOfLines = 2
        label.textAlignment = .center
        label.attributedText = NSAttributedString(string: "Account Creation\nComing Soon", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subLabel: CustomLabel = {
        let label = CustomLabel()
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedText = NSAttributedString(string: "In the coming week, users will be allowed to create accounts and share articles among eachother.", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let btn: UIButton = {
        let label = UIButton()
        label.setAttributedTitle(NSAttributedString(string: "Return", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .semibold)]), for: .normal)
        label.layer.cornerRadius = 5
        label.backgroundColor = .white
        if subViewColor == .black{
            label.layer.shadowColor = UIColor.lightGray.cgColor.copy(alpha: 0.5)
            label.layer.shadowOpacity = 1
            label.layer.shadowOffset = CGSize(width: 0, height: 3)
            label.layer.shadowRadius = 4
        }
        label.addTarget(self, action: #selector(removeView), for: .touchUpInside)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let label3: CustomLabel = {
        let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "Politics", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .semibold)])

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let loadingLabel: CustomLabel = {
        let label = CustomLabel()
        label.attributedText = NSAttributedString(string: "Loading Stories...", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.lightGray])

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.changeBlackView()
        print("Done")
    }
    
    @objc func removeView(){
        delegate?.changeBlackView()
        dismiss(animated: true)
    }
    
    
    
//    func loadAnimation(labelSelected: CustomLabel){
//        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
//            self.loadAnimation2(labelSelected: labelSelected)
//        }
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut) {
//            labelSelected.transform = CGAffineTransform(translationX: -150, y: 0)
//        } completion: { (_) in
//        }
//
//    }
//    func loadAnimation2(labelSelected: CustomLabel){
//        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
//            if labelSelected == self.label{
//                self.loadAnimation(labelSelected: self.label2)
//            }else if labelSelected == self.label2{
//                self.loadAnimation(labelSelected: self.label3)
//            }
//        }
//        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut) {
//            labelSelected.transform = CGAffineTransform(translationX: -150, y: -80)
//            labelSelected.alpha = 0
//        } completion: { (_) in
//        }
//    }
}
