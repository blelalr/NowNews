//
//  Article.swift
//  NowNews
//
//  Created by eros.chen on 2017/3/23.
//  Copyright © 2017年 Eros. All rights reserved.
//

import UIKit
import SwiftyJSON

class Article {
    
    let heading: String?
    let content: String?
    
    let imageURL: URL?
    let category: String?
    let publishedDate: Date
    let url: URL
    
    init (rawData: JSON ) {
        heading = rawData["heading"].string
        content = rawData["content"].string
        
        if let imageURLString = rawData["imageUrl"].string {
            imageURL = URL(string: imageURLString)
        } else {
            imageURL = nil
        }
        category = rawData["category"].string

        let publishedDateMS = rawData["publishedDate"].double!
        publishedDate = Date(timeIntervalSince1970: publishedDateMS / 1000)

        let urlString = rawData["url"].string!
        url = URL(string: urlString)!
        
    }
    
}
