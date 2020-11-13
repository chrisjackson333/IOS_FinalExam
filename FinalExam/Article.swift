//
//  Article.swift
//  FinalExam
//
//  Created by Jackson, William on 6/26/19.
//  Copyright © 2019 Jackson, William. All rights reserved.
//

import SwiftyJSON

class Article {
    let author: String?
    let sourceName: String?
    let publishedAt: String?
    let title: String?
    let desc: String?
    let urlToImg: String?
    let urlToSource: String?
    
    init(json: JSON) {
        author = json["author"].stringValue
        sourceName = json["source"]["id"].stringValue
        publishedAt = json["publishedAt"].stringValue
        title = json["title"].stringValue
        desc = json["description"].stringValue
        urlToImg = json["urlToImage"].stringValue
        urlToSource = json["url"].stringValue
    }
    
}
