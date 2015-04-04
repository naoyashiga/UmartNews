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
    var launchView: UIView?
    var launchLabel: UILabel?
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.title = "Umart News"
        
        self.navigationController?.navigationBarHidden = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = UIColor.navigationBarTintColor()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = false
        
        // Array to keep track of controllers in page menu
        var controllerArray : [UIViewController] = []
  
//        var matomeVC : ArticleViewController  = ArticleViewController(nibName: "ArticleViewController", bundle: nil)
//        matomeVC.parentNavigationController = self.navigationController
//        matomeVC.feedURL = URL.MATOME.rawValue
//        matomeVC.title = "まとめ"
//        matomeVC.setTableView()
//        
//        var predictVC : ArticleViewController = ArticleViewController(nibName: "ArticleViewController", bundle: nil)
//        predictVC.parentNavigationController = self.navigationController
//        predictVC.feedURL = URL.PREDICT.rawValue
//        predictVC.title = "予想"
//        predictVC.setTableView()
//        
//        var sponaviVC: WebViewController = WebViewController()
//        sponaviVC.parentNavigationController = self.navigationController
//        sponaviVC.pageUrl = URL.SPONAVI.rawValue
//        sponaviVC.pageTitle = "結果"
//        sponaviVC.title = "結果"
//        
//        var movieVC: WebViewController = WebViewController()
//        movieVC.parentNavigationController = self.navigationController
//        movieVC.pageUrl = URL.MOVIE.rawValue
//        movieVC.pageTitle = "動画"
//        movieVC.title = "動画"
//        
//        var realtimeVC: WebViewController = WebViewController()
//        realtimeVC.parentNavigationController = self.navigationController
//        realtimeVC.pageUrl = URL.REALTIME.rawValue
//        realtimeVC.pageTitle = "ツイート"
//        realtimeVC.title = "ツイート"
//        
//        var newsVC: WebViewController = WebViewController()
//        newsVC.parentNavigationController = self.navigationController
//        newsVC.pageUrl = URL.NEWS.rawValue
//        newsVC.pageTitle = "ニュース"
//        newsVC.title = "ニュース"
//        
//        controllerArray.append(sponaviVC)
//        controllerArray.append(newsVC)
//        controllerArray.append(movieVC)
//        controllerArray.append(matomeVC)
//        controllerArray.append(predictVC)
//        controllerArray.append(realtimeVC)
// 
//        var parameters: [String: AnyObject] = [
//            "scrollMenuBackgroundColor": UIColor.scrollMenuBackgroundColor(),
//            "viewBackgroundColor": UIColor.viewBackgroundColor(),
//            "selectionIndicatorColor": UIColor.selectionIndicatorColor(),
//            "bottomMenuHairlineColor": UIColor.bottomMenuHairlineColor(),
//            "selectedMenuItemLabelColor": UIColor.selectedMenuItemLabelColor(),
//            "unselectedMenuItemLabelColor": UIColor.unselectedMenuItemLabelColor(),
//            "selectionIndicatorHeight": 2.0,
//            "menuItemFont": UIFont(name: "HiraKakuProN-W6", size: 15.0)!,
//            "menuHeight": 34.0,
//            "menuItemWidth": 80.0,
//            "menuMargin": 0.0,
////            "useMenuLikeSegmentedControl": true,
//            "menuItemSeparatorRoundEdges": true,
////            "enableHorizontalBounce": true,
////            "scrollAnimationDurationOnMenuItemTap": 300,
//            "centerMenuItems": true]
//        
//        self.pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height), options: parameters)
//        self.view.addSubview(self.pageMenu!.view)
        
        launchView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        launchView?.center = self.view.center
        launchView?.backgroundColor = UIColor.launchBackgroundColor()
        launchView?.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        
        launchLabel = UILabel(frame: CGRectMake(0, 0, 212, 46))
        launchLabel?.center = self.view.center
        launchLabel?.font = UIFont(name:"GillSans-Light",size:40)
        launchLabel?.textColor = UIColor.launchTextColor()
        launchLabel?.text = "Umart News"
        
        launchView?.addSubview(launchLabel!)
        self.view.addSubview(launchView!)
    }
    
    override func viewDidAppear(animated: Bool) {
        //少し縮小するアニメーション
//        UIView.animateWithDuration(0.3,
//            delay: 1.0,
//            options: UIViewAnimationOptions.CurveEaseOut,
//            animations: { () in
//                self.logoImageView.transform = CGAffineTransformMakeScale(0.9, 0.9)
//            }, completion: { (Bool) in
//                
//        })
        
        //拡大させて、消えるアニメーション
        UIView.animateWithDuration(0.8,
            delay: 0.3,
            options: UIViewAnimationOptions.CurveEaseOut,
            animations: { () in
                self.launchLabel?.transform = CGAffineTransformMakeScale(3.2, 3.2)
                self.launchLabel?.alpha = 0
                return
            }, completion: { (Bool) in
        })
        
        UIView.animateWithDuration(0.3,
            delay: 1.2,
            options: UIViewAnimationOptions.CurveEaseOut,
            animations: { () in
                self.launchView?.alpha = 0
                return
            }, completion: { (Bool) in
                self.launchView!.removeFromSuperview()
                self.navigationController?.navigationBarHidden = false
        })
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

