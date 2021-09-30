//
//  FeedTabBar.swift
//  NewsTestApp
//
//  Created by Caleb Mesfien on 11/26/20.
//

import UIKit
import Lottie

class FeedStack: UIView,  UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate{
    var FeedViewControllerItem: FeedViewController?
    var leftHorizontalBar: NSLayoutConstraint?
    var widthHorizontalBar: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)

        
        constraintContainer()
        setUpHorizontalBar()
        stackOptionCollectionView.selectItem(at: NSIndexPath(item: 1, section: 0) as IndexPath, animated: true, scrollPosition: .init())
//        FeedViewControllerItem?.scrollToStackIndex(index: 1)

    }
    
    let stackOptionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        
        collectionView.register(FeedStackCollectionCell.self, forCellWithReuseIdentifier: "FeedStackCollectionCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    func setUpHorizontalBar(){
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = subViewColor
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBarView)
        
//        87.5
//        68.5
        leftHorizontalBar = horizontalBarView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        leftHorizontalBar?.isActive = true
        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3).isActive = true
        widthHorizontalBar = horizontalBarView.widthAnchor.constraint(equalToConstant: 87.5)
        widthHorizontalBar?.isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    func constraintContainer(){
        stackOptionCollectionView.delegate = self
        stackOptionCollectionView.dataSource = self
        addSubview(stackOptionCollectionView)
        
        self.addConstraintsWithFormat(format: "V:|[v0]|", views: stackOptionCollectionView)
        self.addConstraintsWithFormat(format: "H:|[v0]|", views: stackOptionCollectionView)
    }
    
    
    

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 2
    }
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let stackImages = ["Subscriptions", "For you"]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedStackCollectionCell", for: indexPath) as! FeedStackCollectionCell
        cell.title.text = stackImages[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if indexPath.row == 0{
//            let size = CGSize(width: 87.5, height: self.frame.height)
//            return size
//        }else
        if indexPath.row == 0{
            let size = CGSize(width: 134, height: self.frame.height)
            return size
        }else{
            let size = CGSize(width: 100, height: self.frame.height)
            return size
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let x = (UIScreen.main.bounds.width/3)*0.75

//        leftHorizontalBar?.constant = CGFloat(x)
//        if indexPath.row == 0{
//            widthHorizontalBar?.constant = 87.5
//        }else if indexPath.row == 1{
//            widthHorizontalBar?.constant = 120
//        }else{
//            widthHorizontalBar?.constant = 68.5
//        }

        FeedViewControllerItem?.scrollToStackIndex(index: indexPath.row)

    }


    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//      MARK: STACKOPTIONCOLLECTIONVIEWCELL

class FeedStackCollectionCell: UICollectionViewCell{
    override init(frame: CGRect){
        super.init(frame: frame)
        print(title.frame.width, "Done is the name")
        self.addSubview(title)
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6)
        ])
    }
    
    override var isHighlighted: Bool{
        didSet{
            title.textColor = isHighlighted ? subViewColor : UIColor.lightGray
        }
    }
    
    override var isSelected: Bool{
        didSet{
            title.textColor = isSelected ? subViewColor : UIColor.lightGray
        }
    }
    let title: CustomLabel = {
       let label = CustomLabel()
        label.textColor = .lightGray
        label.font  = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


