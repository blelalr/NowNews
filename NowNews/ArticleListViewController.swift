//
//  ArticleListViewController.swift
//  NowNews
//
//  Created by Eros on 2017/3/20.
//  Copyright © 2017年 Eros. All rights reserved.
//

import UIKit
import SwiftyJSON

class ArticleListViewController: UITableViewController {
    let ArticlesURL = URL(string: "https://hpd-iosdev.firebaseio.com/news/latest.json")!
    
    @IBOutlet weak var articleTableView: UITableView!
    
    
    var dataResource = MyDataSource()
    var articles = [Article]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    //dismiss status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        articleTableView.dataSource = dataResource
        articleTableView.delegate = self
        articleTableView.rowHeight = UITableViewAutomaticDimension
        downloadLatestArticles()
    }
    
    func downloadLatestArticles() {
        let session = URLSession.shared
        
        let task = session.dataTask(with: ArticlesURL) { data, response, error in
            if let error = error {
                print("下載新聞錯誤: \(error)")
                return
            }
            
            if let jsonArray = JSON(data: data!).array {
                var articles = [Article]()
                for jsonObj in jsonArray {
                    let article = Article(rawData: jsonObj)
                    articles.append(article)
                }
                self.articles = articles
                self.dataResource.articles = articles
                print("新聞下載完成！！")
            }
        }
        task.resume()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let result = self.dataResource.articles {
//            print("\(result[indexPath.row])")
//            drawMap(result: result[indexPath.row])
//        }
    }
    
        
}
