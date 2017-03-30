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
    let headerHeight: CGFloat = 300
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var updateDate: UILabel!
    @IBOutlet weak var updateTime: UILabel!
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var shareBtn: UIButton!
    
    @IBAction func Share(_ sender: UIView) {
        let textToShare = article.heading
        let myWebsite = article.url
        
        let objectsToShare = [textToShare as Any, myWebsite] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        DispatchQueue.main.async {
            activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
        
            activityVC.popoverPresentationController?.sourceView = sender
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        updateDate.text = formatter.string(from: article.publishedDate)
        formatter.dateFormat = "HH:mm YYYY"
        updateTime.text = formatter.string(from: article.publishedDate)
        category.text = article.category
        category.textColor = setColor(category: article.category!)
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
                shareBtn.isHidden = false
                self.heightConstraint.constant =  self.heightConstraint.constant - moveY;
            }
        }
        if moveY > 0 {
            if self.heightConstraint.constant > headerHeight {
                shareBtn.isHidden = true
                self.heightConstraint.constant =  self.heightConstraint.constant - moveY;
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.heightConstraint.constant =  headerHeight
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
                    self.pic.image = self.resizeImage(image: UIImage(data: imageData)!, targetSize: CGSize(width: 375, height: 250))
                }
            })
            dataTask.resume()
        }
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    func setColor(category: String) -> UIColor {
        switch (category) {
        case "focus":
            return UIColor(red:0.94, green:0.23, blue:0.23, alpha:1.0)
            
        case "politics":
            return UIColor(red:0.23, green:0.60, blue:0.94, alpha:1.0)
            
        case "society":
            return UIColor(red:0.94, green:0.57, blue:0.23, alpha:1.0)
            
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
