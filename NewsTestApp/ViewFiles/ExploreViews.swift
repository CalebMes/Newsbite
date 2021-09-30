//
//  ExploreViews.swift
//  NewsTestApp
//
//  Created by Caleb Mesfien on 11/19/20.
//

import UIKit
import Lottie

class TopicViewController: UIViewController{
    override func viewDidLoad(){
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.backButtonTitle = ""
        title = "Topic"
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        constraintContainer()
    }
    override func viewWillAppear(_ animated: Bool) {
        comingSoonAnimation.play(toFrame:36)
    }
    
    
    fileprivate let comingSoonAnimation: AnimationView = {
       let animationView = AnimationView()
        animationView.animation = Animation.named("ComingSoon")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        return animationView
    }()
    
    
    func constraintContainer(){
        view.addSubview(comingSoonAnimation)
        
        NSLayoutConstraint.activate([
            comingSoonAnimation.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            comingSoonAnimation.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            comingSoonAnimation.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            comingSoonAnimation.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6)
        ])

    }
}
