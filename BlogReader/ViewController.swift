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
        let API_PATH = "https://keiba-news-api.herokuapp.com/"
        let API_PATH_MATOME = "https://keiba-news-api.herokuapp.com/matome"
        let API_PATH_PREDICT = "https://keiba-news-api.herokuapp.com/predict"
        
        let URL_SPONAVI = "http://m.sports.yahoo.co.jp/keiba/schedule/list/"
        let URL_MOVIE = "https://www.google.co.jp/search?hl=ja&q=%E7%AB%B6%E9%A6%AC&lr=lang_ja&gws_rd=ssl#q=%E7%AB%B6%E9%A6%AC&lr=lang_ja&hl=ja&tbs=lr:lang_1ja,qdr:d,srcf:H4sIAAAAAAAAANOuzC8tKU1K1UvOz1XLy0zOL8tMSc3XyypQy03MBPIzMkHsosTs0pLUPKAiEM8kPTE3tUgvL7VELSUxM6cSKgwAr8rCCEsAAAA&tbm=vid"
        
        var titleImageView: UIImageView? = UIImageView( image: UIImage(named: "cat"))
        self.navigationItem.title = "Umart News"
        
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = UIColor.hexStr("29B6F6", alpha: 1.0)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = false
        
        // Array to keep track of controllers in page menu
        var controllerArray : [UIViewController] = []
  
        var matomeVC : ArticleViewController  = ArticleViewController(nibName: "ArticleViewController", bundle: nil)
        matomeVC.parentNavigationController = self.navigationController
        matomeVC.feedURL = API_PATH_MATOME
        matomeVC.title = "2chまとめ"
        matomeVC.setTableView()
        
        var predictVC : ArticleViewController = ArticleViewController(nibName: "ArticleViewController", bundle: nil)
        predictVC.parentNavigationController = self.navigationController
        predictVC.feedURL = API_PATH_PREDICT
        predictVC.title = "予想"
        predictVC.setTableView()
        
        var sponaviVC: WebViewController = WebViewController()
        sponaviVC.parentNavigationController = self.navigationController
        sponaviVC.pageUrl = URL_SPONAVI
        sponaviVC.pageTitle = "レース結果"
        sponaviVC.title = "レース結果"
        
        var movieVC: WebViewController = WebViewController()
        movieVC.parentNavigationController = self.navigationController
        movieVC.pageUrl = URL_MOVIE
        movieVC.pageTitle = "動画"
        movieVC.title = "動画"
        
        controllerArray.append(sponaviVC)
        controllerArray.append(movieVC)
        controllerArray.append(matomeVC)
        controllerArray.append(predictVC)
 
        var parameters: [String: AnyObject] = [
            "scrollMenuBackgroundColor": UIColor(red:253/255.0, green:253/255.0, blue:253/255.0, alpha: 1.0),
            "viewBackgroundColor": UIColor(red:253/255.0, green:253/255.0, blue:253/255.0, alpha: 1.0),
            "selectionIndicatorColor": UIColor(red:223/255.0, green:124/255.0, blue:170/255.0, alpha: 1.0),
            "bottomMenuHairlineColor": UIColor.hexStr("29B6F6", alpha: 1.0),
            "selectedMenuItemLabelColor": UIColor(red:223/255.0, green:124/255.0, blue:170/255.0, alpha: 1.0),
            "selectionIndicatorHeight": 2.0,
            "menuItemFont": UIFont(name: "HiraKakuProN-W3", size: 13.0)!,
            "menuHeight": 30.0,
            "menuItemWidth": 80.0,
            "menuMargin": 0.0,
            "menuItemSeparatorRoundEdges": true,
            "centerMenuItems": true]
        
        self.pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height), options: parameters)
        self.view.addSubview(self.pageMenu!.view)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

