//
//  Article.swift
//  NowNews
//
//  Created by eros.chen on 2017/3/23.
//  Copyright © 2017年 Eros. All rights reserved.
//

import UIKit
import SwiftyJSON

let ArticlesURL = URL(string: "https://hpd-iosdev.firebaseio.com/news/latest.json")!

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
    
    class func downloadLatestArticles(completionHandler: @escaping ([Article]?, Error?) -> Void) {
        let session = URLSession.shared
        
        let task = session.dataTask(with: ArticlesURL) { data, response, error in
            if let error = error {
                print("下載新聞錯誤: \(error)")
                completionHandler(nil, error)
                return
            }
            
            if let jsonArray = JSON(data: data!).array {
//                var articles = [Article]()
//                for jsonObj in jsonArray {
//                    let article = Article(rawData: jsonObj)
//                    articles.append(article)
//                }
                
                let articles = jsonArray.map { Article(rawData: $0) }
                
                completionHandler(articles, nil)
//                self.articles = articles
//                self.dataResource.articles = articles
                print("新聞下載完成！！")
            }
        }
        task.resume()
    }

    
}
