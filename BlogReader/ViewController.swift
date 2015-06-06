//
//  ViewController.swift
//  BlogReader
//
//  Created by naoyashiga on 2014/12/28.
//  Copyright (c) 2014年 naoyashiga. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController,GADBannerViewDelegate {
    var pageMenu : CAPSPageMenu?
    var launchView: UIView?
    var launchLabel: UILabel?
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Umart News"
        
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = UIColor.navigationBarTintColor()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = false
        
        // Array to keep track of controllers in page menu
        var controllerArray : [UIViewController] = []
  
//        var matomeVC : ArticleViewController  = ArticleViewController(nibName: "ArticleViewController", bundle: nil)
//        matomeVC.parentNavigationController = self.navigationController
//        matomeVC.feedURL = URL.MATOME.rawValue + matomeVC.checkFeedSite(myMatomes)
//        matomeVC.title = "まとめ"
//        matomeVC.setTableView()
        
//        var predictVC : ArticleViewController = ArticleViewController(nibName: "ArticleViewController", bundle: nil)
//        predictVC.parentNavigationController = self.navigationController
//        predictVC.feedURL = URL.PREDICT.rawValue + predictVC.checkFeedSite(myPredicts)
//        predictVC.title = "予想"
//        predictVC.setTableView()
        
        var sponaviVC: WebViewController = WebViewController()
        sponaviVC.parentNavigationController = self.navigationController
        sponaviVC.pageUrl = URL.SPONAVI.rawValue
        sponaviVC.pageTitle = "結果"
        sponaviVC.title = "結果"
        
        var movieVC: WebViewController = WebViewController()
        movieVC.parentNavigationController = self.navigationController
        movieVC.pageUrl = URL.MOVIE.rawValue
        movieVC.pageTitle = "動画"
        movieVC.title = "動画"
        
        var realtimeVC: WebViewController = WebViewController()
        realtimeVC.parentNavigationController = self.navigationController
        realtimeVC.pageUrl = URL.REALTIME.rawValue
        realtimeVC.pageTitle = "ツイート"
        realtimeVC.title = "ツイート"
        
        var newsVC: WebViewController = WebViewController()
        newsVC.parentNavigationController = self.navigationController
        newsVC.pageUrl = URL.NEWS.rawValue
        newsVC.pageTitle = "ニュース"
        newsVC.title = "ニュース"
        
//        var settingVC: SettingViewController = SettingViewController(nibName: "SettingViewController", bundle: nil)
//        settingVC.parentNavigationController = self.navigationController
//        settingVC.title = "設定"
        
//        println(matomeVC.feedURL)
//        println(predictVC.feedURL)
        
        controllerArray.append(sponaviVC)
        controllerArray.append(newsVC)
        controllerArray.append(movieVC)
//        controllerArray.append(matomeVC)
//        controllerArray.append(predictVC)
        controllerArray.append(realtimeVC)
//        controllerArray.append(settingVC)
        
        var parameters: [CAPSPageMenuOption] = [
            .ScrollMenuBackgroundColor(UIColor.scrollMenuBackgroundColor()),
            .ViewBackgroundColor(UIColor.viewBackgroundColor()),
            .SelectionIndicatorColor(UIColor.selectionIndicatorColor()),
            .BottomMenuHairlineColor(UIColor.bottomMenuHairlineColor()),
            .SelectedMenuItemLabelColor(UIColor.selectedMenuItemLabelColor()),
            .UnselectedMenuItemLabelColor(UIColor.unselectedMenuItemLabelColor()),
            .SelectionIndicatorHeight(2.0),
            .MenuItemFont(UIFont(name: "HiraKakuProN-W6", size: 15.0)!),
            .MenuHeight(34.0),
            .MenuItemWidth(80.0),
            .MenuMargin(0.0),
//            "useMenuLikeSegmentedControl": true,
            .MenuItemSeparatorRoundEdges(true),
//            "enableHorizontalBounce": true,
//            "scrollAnimationDurationOnMenuItemTap": 300,
            .CenterMenuItems(true)]
        
        self.pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
        
        let ud = NSUserDefaults.standardUserDefaults()
        if(ud.objectForKey("eula") == nil){
            eula()
        }else{
            println("add")
            self.view.addSubview(self.pageMenu!.view)
        }
    }
    
    func eula(){
//        var eulaText = "ニュース、2chまとめサイト記事に不適切な投稿内容が一部含まれる可能性があることを承諾します。"
        var eulaText = "ニュース、動画に不適切な投稿内容が一部含まれる可能性があることを承諾します。"
        var ac = UIAlertController(title: "使用許諾契約", message: eulaText, preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "同意しない", style: .Cancel) { (action) -> Void in
            println("Cancel button tapped.")
            self.alert()
        }
        
        let okAction = UIAlertAction(title: "同意する", style: .Default) { (action) -> Void in
            let ud = NSUserDefaults.standardUserDefaults()
            ud.setObject(true, forKey: "eula")
            println("OK button tapped.")
            self.view.addSubview(self.pageMenu!.view)
        }
        
        ac.addAction(cancelAction)
        ac.addAction(okAction)
        
        presentViewController(ac, animated: true, completion: nil)
    }
    
    func alert(){
        let text = "使用許諾契約に同意しないと閲覧できません"
        var ac = UIAlertController(title: "Alert", message: text, preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in
        }
        
        ac.addAction(okAction)
        
        presentViewController(ac, animated: true, completion: nil)
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
//        UIView.animateWithDuration(0.8,
//            delay: 0.3,
//            options: UIViewAnimationOptions.CurveEaseOut,
//            animations: { () in
//                self.launchLabel?.transform = CGAffineTransformMakeScale(3.2, 3.2)
//                self.launchLabel?.alpha = 0
//                return
//            }, completion: { (Bool) in
//        })
//        
//        UIView.animateWithDuration(0.3,
//            delay: 1.2,
//            options: UIViewAnimationOptions.CurveEaseOut,
//            animations: { () in
//                self.launchView?.alpha = 0
//                return
//            }, completion: { (Bool) in
//                self.launchView!.removeFromSuperview()
//                self.navigationController?.navigationBarHidden = false
//        })
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

