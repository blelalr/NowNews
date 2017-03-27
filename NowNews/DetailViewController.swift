//
//  DetailViewController.swift
//  NowNews
//
//  Created by eros.chen on 2017/3/23.
//  Copyright © 2017年 Eros. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate {
    
    var article: Article!
    let headerHeight: CGFloat = 221
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var updateDate: UILabel!
    @IBOutlet weak var updateTime: UILabel!
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var content: UILabel!
    
    override func viewDidLoad() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        updateDate.text = formatter.string(from: article.publishedDate)
        formatter.dateFormat = "HH:mm YYYY"
        updateTime.text = formatter.string(from: article.publishedDate)
        category.text = article.category
        header.text = article.heading
        content.text = article.content
        downloadArticleImage()
    }

    //dismiss status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        scrollView.delegate = self
        scrollView.bounces = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = true
        scrollView.bouncesZoom = true
        self.heightConstraint.constant = headerHeight
    }
    
    func updateHeaderView() {
        let moveY = scrollView.contentOffset.y
        print("scroll: \(scrollView.contentOffset.y)")
        print("constraint: \(self.heightConstraint.constant)")
        
        if moveY < 0 {
            if self.heightConstraint.constant < 450{
                self.heightConstraint.constant =  self.heightConstraint.constant - moveY;
            }
        }
        if moveY > 0 {
            if self.heightConstraint.constant > headerHeight {
                self.heightConstraint.constant =  self.heightConstraint.constant - moveY;
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.heightConstraint.constant =  headerHeight
    }
    
    
    func downloadArticleImage() {
        if let imageURL = article.imageURL {
            var imageData = Data()
            let dataTask = URLSession.shared.dataTask(with: imageURL, completionHandler: { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                imageData.append(data!)
                DispatchQueue.main.async {
                    self.pic.image = UIImage(data: imageData)
                }
            })
            dataTask.resume()
        }
    }
    
    
}
