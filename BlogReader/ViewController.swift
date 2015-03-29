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
        let URL_REALTIME = "http://realtime.search.yahoo.co.jp/search?fr=sfp_as&p=%E7%AB%B6%E9%A6%AC&ei=UTF-8&rkf=1"
        let URL_NEWS = "https://www.google.co.jp/search?q=%E7%AB%B6%E9%A6%AC&lr=lang_ja&hl=ja&gl=jp&authuser=0&tbas=0&tbs=lr:lang_1ja,qdr:d&tbm=nws&source=lnt&sa=X&ei=LvAXVZ-NHYWomgXDroHYCw&ved=0CBMQpwU&biw=320&bih=568&dpr=2"
        
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
        matomeVC.title = "まとめ"
        matomeVC.setTableView()
        
        var predictVC : ArticleViewController = ArticleViewController(nibName: "ArticleViewController", bundle: nil)
        predictVC.parentNavigationController = self.navigationController
        predictVC.feedURL = API_PATH_PREDICT
        predictVC.title = "予想"
        predictVC.setTableView()
        
        var sponaviVC: WebViewController = WebViewController()
        sponaviVC.parentNavigationController = self.navigationController
        sponaviVC.pageUrl = URL_SPONAVI
        sponaviVC.pageTitle = "結果"
        sponaviVC.title = "結果"
        
        var movieVC: WebViewController = WebViewController()
        movieVC.parentNavigationController = self.navigationController
        movieVC.pageUrl = URL_MOVIE
        movieVC.pageTitle = "動画"
        movieVC.title = "動画"
        
        var realtimeVC: WebViewController = WebViewController()
        realtimeVC.parentNavigationController = self.navigationController
        realtimeVC.pageUrl = URL_REALTIME
        realtimeVC.pageTitle = "ツイート"
        realtimeVC.title = "ツイート"
        
        var newsVC: WebViewController = WebViewController()
        newsVC.parentNavigationController = self.navigationController
        newsVC.pageUrl = URL_NEWS
        newsVC.pageTitle = "ニュース"
        newsVC.title = "ニュース"
        
        controllerArray.append(sponaviVC)
        controllerArray.append(newsVC)
        controllerArray.append(movieVC)
        controllerArray.append(matomeVC)
        controllerArray.append(predictVC)
        controllerArray.append(realtimeVC)
 
        var parameters: [String: AnyObject] = [
            "scrollMenuBackgroundColor": UIColor.hexStr("d4f0fd", alpha: 1.0),
            "viewBackgroundColor": UIColor.hexStr("186d93", alpha: 1.0),
            "selectionIndicatorColor": UIColor.hexStr("F06292", alpha: 1.0),
            "bottomMenuHairlineColor": UIColor.hexStr("F06292", alpha: 1.0),
            "selectedMenuItemLabelColor": UIColor.hexStr("145b7b", alpha: 1.0),
            "unselectedMenuItemLabelColor": UIColor.hexStr("3ebdf6", alpha: 1.0),
            "selectionIndicatorHeight": 2.0,
            "menuItemFont": UIFont(name: "HiraKakuProN-W6", size: 15.0)!,
            "menuHeight": 34.0,
            "menuItemWidth": 80.0,
            "menuMargin": 0.0,
//            "useMenuLikeSegmentedControl": true,
            "menuItemSeparatorRoundEdges": true,
//            "enableHorizontalBounce": true,
//            "scrollAnimationDurationOnMenuItemTap": 300,
            "centerMenuItems": true]
        
        self.pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height), options: parameters)
        self.view.addSubview(self.pageMenu!.view)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

