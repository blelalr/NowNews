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
    @IBOutlet weak var updateTime: UILabel!
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var content: UILabel!
    
    override func viewDidLoad() {
        print("Article: \(article)")
        let publishDate = Calendar.current.component(.hour, from: article.publishedDate)
        print("publishDate: \(publishDate)")
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        headerView.tag = 1
        scrollView.delegate = self
        scrollView.bounces = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bouncesZoom = true
        
        // 縮放元件的預設縮放大小
        scrollView.zoomScale = 1.0
        
        // 縮放元件可縮小到的最小倍數
        scrollView.minimumZoomScale = 0.5
        
        // 縮放元件可放大到的最大倍數
        scrollView.maximumZoomScale = 1.0
        
        // 縮放元件縮放時是否在超過縮放倍數後使用彈回效果
        scrollView.bouncesZoom = true
        self.heightConstraint.constant = headerHeight
    }
    
    func updateHeaderView() {
        let moveY = scrollView.contentOffset.y + 64
        print("scroll: \(scrollView.contentOffset.y)")
        print("constraint: \(self.heightConstraint.constant)")
//        if let headerHeight = headerHeight {
//            let headerRect = CGRect(x: 0, y: moveY , width: headerView.bounds.width, height: headerHeight)
            if moveY < 0 {
                self.heightConstraint.constant =  self.heightConstraint.constant - moveY;
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
    
    // 縮放的元件
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
            return self.headerView.viewWithTag(1)
    }
    
    
}
