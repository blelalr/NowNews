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
//    let ArticlesURL = URL(string: "https://hpd-iosdev.firebaseio.com/news/latest.json")!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let newFrame = CGRect(x: 0, y: -navigationController!.navigationBar.frame.height, width: navigationController!.navigationBar.frame.width, height: navigationController!.navigationBar.frame.height)
        navigationController?.navigationBar.frame = newFrame
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let navigationController = self.navigationController!
        print("\(navigationController.navigationBar.frame)")
    }
    
    func downloadLatestArticles() {
        Article.downloadLatestArticles { (articles, error) in
            if let error = error {
                print("下載失敗：\(error)")
                return
            }
            
            if let articles = articles {
                self.articles = articles
                self.dataResource.articles = articles
                self.refreshControl?.endRefreshing()

            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showArticleDetail"{
            print("翻頁囉～")
            
            let cell = sender as! ArticleCell
            let detailVC = segue.destination as! DetailViewController
            
            let row = articleTableView.indexPath(for: cell)!.row
            
            let article = articles[row]
            detailVC.article = article
        
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    @IBAction func reloadNews(_ sender: Any) {
        downloadLatestArticles()
        
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let result = dataResource.articles {
//            print("\(dataResource.articles[indexPath.row])")
//        }
//    }
    
        
}
