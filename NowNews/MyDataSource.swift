//
//  MyDataSource.swift
//  NowNews
//
//  Created by eros.chen on 2017/3/23.
//  Copyright © 2017年 Eros. All rights reserved.
//

import UIKit
import SwiftyJSON

class ArticleCell: UITableViewCell {
    @IBOutlet weak var cellCategory: UILabel!
    @IBOutlet weak var cellHeader: UILabel!

}

class MyDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    var articles = [Article]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell") as! ArticleCell
        cell.cellCategory.text = articles[indexPath.row].category
        cell.cellCategory.textColor = setColor(category: articles[indexPath.row].category!)
        cell.cellHeader.text = articles[indexPath.row].heading
//        print("\( articles[indexPath.row]["headering"])")
        return cell
    }
    
    func setColor(category: String) -> UIColor {
        switch (category) {
        case "focus":
            return UIColor(red:0.94, green:0.23, blue:0.23, alpha:1.0)
        
        case "politics":
            return UIColor(red:0.23, green:0.60, blue:0.94, alpha:1.0)
            
        case "society":
            return UIColor(red: 0.988, green: 0.271, blue: 0.282, alpha: 1)
            
        case "life":
            return UIColor(red:0.09, green:0.59, blue:0.18, alpha:1.0)
            
        case "world":
            return UIColor(red:0.93, green:0.89, blue:0.39, alpha:1.0)
            
        case "talk":
            return UIColor(red:0.73, green:0.39, blue:0.93, alpha:1.0)
            
        case "business":
            return UIColor(red:0.39, green:0.93, blue:0.51, alpha:1.0)
            
        case "sports":
            return UIColor(red:0.93, green:0.39, blue:0.68, alpha:1.0)
            
        case "local":
            return UIColor(red:0.27, green:0.77, blue:0.89, alpha:1.0)
            
        case "entertainment":
            return UIColor(red:1.00, green:0.64, blue:0.20, alpha:1.0)
            
        case "consumer":
            return UIColor(red:0.36, green:0.20, blue:1.00, alpha:1.0)
            
        case "supplement":
            return UIColor(red:0.20, green:1.00, blue:0.76, alpha:1.0)
            
        case "3c":
            return UIColor(red:0.54, green:0.59, blue:0.59, alpha:1.0)
            
        case "cars":
            return UIColor(red:0.52, green:0.03, blue:0.03, alpha:1.0)
            
        case "istyle":
            return UIColor(red:0.18, green:0.17, blue:0.17, alpha:1.0)
            
        default:
            return UIColor(red:0.18, green:0.17, blue:0.17, alpha:1.0)
        }
    }
}

