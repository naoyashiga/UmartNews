//
//  ViewController.swift
//  BlogReader
//
//  Created by naoyashiga on 2014/12/28.
//  Copyright (c) 2014年 naoyashiga. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    var pageMenu : CAPSPageMenu?
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var titleImageView: UIImageView? = UIImageView( image: UIImage(named: "cat"))
        self.navigationItem.title = "Umart News"
        
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = UIColor.brownColor()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = false
        
        // Array to keep track of controllers in page menu
        var controllerArray : [UIViewController] = []
  
        var matomeController : ArticleViewController  = ArticleViewController(nibName: "ArticleViewController", bundle: nil)
        matomeController.parentNavigationController = self.navigationController
        matomeController.feedURL = "https://keiba-news-api.herokuapp.com/matome"
        matomeController.title = "2chまとめ"
        controllerArray.append(matomeController)
        
        var predictController : ArticleViewController = ArticleViewController(nibName: "ArticleViewController", bundle: nil)
        predictController.parentNavigationController = self.navigationController
        predictController.feedURL = "https://keiba-news-api.herokuapp.com/predict"
        predictController.title = "予想"
        controllerArray.append(predictController)
        
        var sponaviVC: WebViewController = WebViewController(nibName: "WebViewController", bundle: nil)
        sponaviVC.parentNavigationController = self.navigationController
        sponaviVC.pageUrl = "http://m.sports.yahoo.co.jp/keiba/schedule/list/"
        sponaviVC.title = "レース結果"
        controllerArray.append(sponaviVC)
        
        var movieVC: WebViewController = WebViewController(nibName: "WebViewController", bundle: nil)
        movieVC.parentNavigationController = self.navigationController
        movieVC.pageUrl = "https://www.google.co.jp/search?hl=ja&q=%E7%AB%B6%E9%A6%AC&lr=lang_ja&gws_rd=ssl#q=%E7%AB%B6%E9%A6%AC&lr=lang_ja&hl=ja&tbs=lr:lang_1ja,qdr:d,srcf:H4sIAAAAAAAAANOuzC8tKU1K1UvOz1XLy0zOL8tMSc3XyypQy03MBPIzMkHsosTs0pLUPKAiEM8kPTE3tUgvL7VELSUxM6cSKgwAr8rCCEsAAAA&tbm=vid"
        movieVC.title = "動画"
        controllerArray.append(movieVC)
 
        var parameters: [String: AnyObject] = [
            "scrollMenuBackgroundColor": UIColor(red:253/255.0, green:253/255.0, blue:253/255.0, alpha: 1.0),
            "viewBackgroundColor": UIColor(red:253/255.0, green:253/255.0, blue:253/255.0, alpha: 1.0),
            "selectionIndicatorColor": UIColor(red:223/255.0, green:124/255.0, blue:170/255.0, alpha: 1.0),
            "bottomMenuHairlineColor": UIColor(red:187/255.0, green:187/255.0, blue:187/255.0, alpha: 1.0),
            "selectedMenuItemLabelColor": UIColor(red:223/255.0, green:124/255.0, blue:170/255.0, alpha: 1.0),
            "selectionIndicatorHeight": 2.0,
            "menuItemFont": UIFont(name: "HiraKakuProN-W3", size: 13.0)!,
            "menuHeight": 30.0,
            "menuItemWidth": 80.0,
            "menuMargin": 0.0,
            "menuItemSeparatorRoundEdges": true,
            "centerMenuItems": true]
        
        // Initialize page menu with controller array, frame, and optional parameters
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height), options: parameters)
        
        // Lastly add page menu as subview of base view controller view
        // or use pageMenu controller in you view hierachy as desired
        self.view.addSubview(pageMenu!.view)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

