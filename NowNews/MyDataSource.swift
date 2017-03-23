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
        cell.cellHeader.text = articles[indexPath.row].heading
//        print("\( articles[indexPath.row]["headering"])")
        return cell
    }

}
