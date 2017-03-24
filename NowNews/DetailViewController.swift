//
//  DetailViewController.swift
//  NowNews
//
//  Created by eros.chen on 2017/3/23.
//  Copyright © 2017年 Eros. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var article: Article!
    
    override func viewWillAppear(_ animated: Bool) {
        print("Article: \(article)")
    }

}
