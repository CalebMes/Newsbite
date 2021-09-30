//
//  RealmObjects.swift
//  NewsTestApp
//
//  Created by Caleb Mesfien on 12/5/20.
//

import UIKit
import RealmSwift


class userObject: Object {
    @objc dynamic var name = ""
    @objc dynamic var username = ""
    @objc dynamic var image: NSData?
    @objc dynamic var joinedDate =  ""
    @objc dynamic var Id = ""
//    @objc dynamic var pro
    @objc dynamic var followerCount = 0
    @objc dynamic var followingCount = 0
    var interests =  List<String>()
}

class trendingArtTop: Object {
    let Technology = List<TrendingArticleObject>()
    let Entertainment = List<TrendingArticleObject>()
    let Sports = List<TrendingArticleObject>()
    let Buisness = List<TrendingArticleObject>()
    let Politics = List<TrendingArticleObject>()
    let Science = List<TrendingArticleObject>()
    
    let Trending = List<TrendingArticleObject>()
}
//
struct ArticleItem{
    var url: String
    var title: String
    var desc: String
    var date: String
    var source_name: String
    var image: String
  }
class SubscribedTopics: Object{
    @objc dynamic var title = ""
    @objc dynamic var topicTitle = ""
    @objc dynamic var topicImgURL = ""
    @objc dynamic var source_name = ""
}

//class TrendingArticlesTopicOject: Object{
//}

//class ObjectTechnology: Object{
//    var list = List<TrendingArticleObject>()
//}

//class ObjectTechnology: Object{
//    var list = List<TrendingArticleObject>()
//}
//
//class ObjectEntertainment: Object{
//    var list = List<TrendingArticleObject>()
//
//}
//
//class ObjectSports: Object{
//    var list = List<TrendingArticleObject>()
//
//}
//
//class ObjectBuisness: Object{
//    var list = List<TrendingArticleObject>()
//
//}
//
//class ObjectPolitics: Object{
//    var list = List<TrendingArticleObject>()
//
//}
//
//class ObjectScience: Object{
//    var list = List<TrendingArticleObject>()
//
//}

class TrendingArticleObject: Object{
    @objc dynamic var id: String?
    @objc dynamic var url: String?
    @objc dynamic var title: String?
    @objc dynamic var desc: String?
    @objc dynamic var author: String?
    @objc dynamic var date: String?
    @objc dynamic var source_name: String?
    @objc dynamic var image: String?
  }

class friendObject: Object{
    @objc dynamic var name: String?
    @objc dynamic var username: String?
    @objc dynamic var id: String?
    @objc dynamic var image: NSData?
    @objc dynamic var joinedData: String?
    @objc dynamic var isFollowing = false
}

class PostObject: Object{
    @objc dynamic var docID = ""
    @objc dynamic var url = ""
    @objc dynamic var title = ""
    @objc dynamic var desc = ""
    @objc dynamic var date = ""
    @objc dynamic var source_name = ""
    @objc dynamic var image = ""
}

class NotificationObject: Object{
    @objc dynamic var id: String?
    @objc dynamic var isSentPost = false
    @objc dynamic var image: NSData?
}


class DarkMode: Object{
    @objc dynamic var isDarkMode = false
}
class AutoReaderMode: Object{
    @objc dynamic var isOn = false
}
class currentTrendingTime: Object{
    @objc dynamic var date = Date()
}
