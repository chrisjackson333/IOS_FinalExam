//
//  Source.swift
//  FinalExam
//
//  Created by Jackson, William on 6/26/19.
//  Copyright © 2019 Jackson, William. All rights reserved.
//
import SwiftyJSON

class Source {
    let name: String?
    let desc: String?
    let id: String?
    
    init(json: JSON) {
        name = json["name"].stringValue
        desc = json["description"].stringValue
        id = json["id"].stringValue
    }
    
}
