//
//  WebViewController.swift
//  BlogReader
//
//  Created by naoyashiga on 2014/12/29.
//  Copyright (c) 2014年 naoyashiga. All rights reserved.
//

import UIKit
import WebKit
import Social
import GoogleMobileAds
import MessageUI

class WebViewController: UIViewController,WKUIDelegate,GADBannerViewDelegate,MFMailComposeViewControllerDelegate{
    var parentNavigationController : UINavigationController?
    var wkWebView: WKWebView?
    var progressBar: UIProgressView?
    var screenHeight: CGFloat?
    var screenWidth: CGFloat?
    
    var pageUrl: String?
    var pageTitle: String?
    
    let footerHeight:CGFloat = 50.0
    let progressBarHeight: CGFloat = 2.0
    
    var menuView = UIView()
    var goBackBtn = UIButton()
    var goForwardBtn = UIButton()
    
    var navigationBarHeight : CGFloat?
    
    var isViaTableView: Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenHeight = setScreenHeight()
        
        println(screenHeight)
        screenWidth = self.view.bounds.width
        initBackButton()
        setShareButton()
        initWebView()
        initProgressBar()
        
        initMenuViewAndButton()
        
        //広告表示
        settingAd()
        
    }
    
    func settingAd(){
//        let GAD_SIMULATOR_ID = "0b0df889514cace63baf0d3f248e5295"
        let MY_BANNER_UNIT_ID = "ca-app-pub-9360978553412745/7543765112"
        var origin:CGPoint?
        if self.navigationController == nil {
            origin = CGPointMake(
                0.0,
                screenHeight! - CGSizeFromGADAdSize(kGADAdSizeBanner).height - 35); // place at bottom of view
        }else{
            origin = CGPointMake(
                0.0,
                screenHeight! - CGSizeFromGADAdSize(kGADAdSizeBanner).height); // place at bottom of view
        }
        
        var size = GADAdSizeFullWidthPortraitWithHeight(50) // set size to 50
        var adB = GADBannerView(adSize: size, origin: origin!) // create the banner
        adB.adUnitID = MY_BANNER_UNIT_ID  //"ca-app-pub-XXXXXXXX/XXXXXXX"
        adB.delegate = self // ??
        adB.rootViewController = self // ??
        self.view.addSubview(adB) // ??
        var request = GADRequest() // create request
        //        request.testDevices = [GAD_SIMULATOR_ID]; // set it to "test" request
        request.testDevices = [kGADSimulatorID]; // set it to "test" request
        adB.loadRequest(request) // actually load it (?)
    }
    
    func setScreenHeight() -> CGFloat{
        var statusBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height
        
        if self.navigationController == nil {
            println("いきなりwebView")
            navigationBarHeight = parentNavigationController?.navigationBar.frame.size.height
        
            isViaTableView = false
        }else{
            println("table view からのwebView")
            navigationBarHeight = self.navigationController?.navigationBar.frame.size.height
            isViaTableView = true
        }
        
//        self.settingAd(offsetY: statusBarHeight + navigationBarHeight!)
        println(statusBarHeight + navigationBarHeight!)
        return self.view.bounds.height - statusBarHeight - navigationBarHeight!
    }
    
    func initMenuViewAndButton(){
        let btnSize : CGFloat = 50
        let btnFontSize : CGFloat = 50.0
        let menuLeftMargin : CGFloat = 5.0
        let btnLeftMargin : CGFloat = 40.0
        let goForwardBtnPosX = menuLeftMargin + btnFontSize + btnLeftMargin
        
        let menuViewWidth : CGFloat = 150
        let menuViewHeight: CGFloat = 60.0
        let menuBottomMargin: CGFloat = 10.0
        var menuViewPosX : CGFloat = (screenWidth! - menuViewWidth) / 2
        var menuViewPosY : CGFloat?
        
        if isViaTableView {
            menuViewPosY = screenHeight! - menuViewHeight - menuBottomMargin
        }else{
            menuViewPosY = screenHeight! - menuViewHeight * 1.5 - menuBottomMargin
        }
        
        menuView = UIView(frame: CGRectMake(menuViewPosX, menuViewPosY!, menuViewWidth, menuViewHeight))
        menuView.backgroundColor = UIColor.webViewMenuBackgroundColor()
        menuView.layer.cornerRadius = 10.0
        menuView.tag = 10
        
        goBackBtn = UIButton(frame: CGRectMake(menuLeftMargin, menuViewHeight / 2 - btnFontSize / 2, btnSize, btnSize))
        goBackBtn.setTitle("<", forState: UIControlState.Normal)
        goBackBtn.setTitleColor(UIColor.webViewMenuBtnEnabledColor(), forState: UIControlState.Normal)
        goBackBtn.titleLabel!.font = UIFont(name: "Helvetica-Bold",size: btnFontSize)
        goBackBtn.addTarget(self, action: "menuBtnTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        goBackBtn.tag = 1
        
        goForwardBtn = UIButton(frame: CGRectMake(goForwardBtnPosX, menuViewHeight / 2 - btnFontSize / 2, btnSize, btnSize))
        goForwardBtn.setTitle(">", forState: UIControlState.Normal)
        goForwardBtn.setTitleColor(UIColor.webViewMenuBtnDisabledColor(), forState: UIControlState.Normal)
        goForwardBtn.titleLabel!.font = UIFont(name: "Helvetica-Bold",size: btnFontSize)
        goForwardBtn.addTarget(self, action: "menuBtnTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        goForwardBtn.tag = 2
        
        menuView.addSubview(goBackBtn)
        menuView.addSubview(goForwardBtn)
    }
    
    
    func initProgressBar(){
        progressBar = UIProgressView(frame: CGRectMake(0, 0, screenWidth!, progressBarHeight))
        progressBar!.progressTintColor = UIColor.progressTintColor()
        progressBar!.trackTintColor = UIColor.whiteColor()
        progressBar!.setProgress(1.0, animated: true)
        progressBar!.transform = CGAffineTransformMakeScale(1.0, 2.0)
        self.view.addSubview(progressBar!)
    }
    
    func initWebView(){
        if pageTitle == "結果" || pageTitle == "動画" || pageTitle == "ニュース"{
            println("js execute")
            var contentController = WKUserContentController();
            if let path = NSBundle.mainBundle().pathForResource("script", ofType: "js") {
                if let source = NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil) {
                    var userScript = WKUserScript(source: source as String, injectionTime: WKUserScriptInjectionTime.AtDocumentEnd, forMainFrameOnly: true)
                    contentController.addUserScript(userScript)
//                    contentController.addScriptMessageHandler(
//                        self,
//                        name: "callbackHandler"
//                    )
                }
            }

            var config = WKWebViewConfiguration()
            config.userContentController = contentController
            wkWebView = WKWebView(frame: CGRectMake(0, 0, screenWidth!, screenHeight!), configuration: config)
            
        }else {
            wkWebView = WKWebView(frame: CGRectMake(0, 0, screenWidth!, screenHeight!))
        }
        
        wkWebView?.allowsBackForwardNavigationGestures = true
        
        //監視対象の登録
        wkWebView?.addObserver(self, forKeyPath:"estimatedProgress", options:.New, context:nil)
        
        wkWebView?.addObserver(self, forKeyPath:"canGoBack", options: .New, context: nil)
        wkWebView?.addObserver(self, forKeyPath:"canGoForward", options: .New, context: nil)
        
        if isViaTableView {
            wkWebView?.addObserver(self, forKeyPath:"title", options:.New, context:nil)
        }
        wkWebView?.UIDelegate = self
        
        
        println(pageUrl!)
        
        if let pageUrlNotOptional = pageUrl {
            println("not optional")
            var detailUrl = NSURL(string: pageUrlNotOptional)
            var detailUrlReq = NSURLRequest(URL: detailUrl!)
            wkWebView?.loadRequest(detailUrlReq)
        }
        
        
        self.view.addSubview(wkWebView!)
    }
    
    func initBackButton() {
        let backButton = UIBarButtonItem(title: "<", style: UIBarButtonItemStyle.Plain, target: self, action: "back")
        backButton.width = screenWidth! - 100
        backButton.tintColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "HiraKakuProN-W6", size: 12)!], forState: UIControlState.Normal)
    }
    
    func setShareButton(){
        let shareButton = UIBarButtonItem(title: "share", style: UIBarButtonItemStyle.Plain, target: self, action: "shareAlert")
        shareButton.width = screenWidth! - 100
        shareButton.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = shareButton
    }
    
    func back() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func shareAlert(){
        let actionSheet:UIAlertController = UIAlertController(
            title:"この記事をシェア",
            message: self.navigationItem.title,
            preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .Cancel) { (action) -> Void in
        }
        
        let twitter = UIAlertAction(title: "Twitter", style: .Default) { (action) -> Void in
            self.tweetBtnAction()
        }
        
        let fb = UIAlertAction(title: "Facebook", style: .Default) { (action) -> Void in
            self.fbBtnAction()
        }
        
        let line = UIAlertAction(title: "LINE", style: .Default) { (action) -> Void in
            self.lineBtnAction()
        }
        
        let report = UIAlertAction(title: "記事の問題を報告", style: .Default) { (action) -> Void in
            self.reportAlert()
        }
        
        actionSheet.addAction(cancelAction)
        actionSheet.addAction(twitter)
        actionSheet.addAction(fb)
        actionSheet.addAction(line)
        actionSheet.addAction(report)
        
        presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func fbBtnAction(){
        var vc:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        var shareText:String = self.navigationItem.title! + " " + self.pageUrl!
        //テキストを設定
        vc.setInitialText(shareText)
        self.presentViewController(vc,animated:true,completion:nil)
    }
    
    func tweetBtnAction(){
        var vc:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        var shareText:String = self.navigationItem.title! + " " + self.pageUrl!
        //テキストを設定
        vc.setInitialText(shareText)
        self.presentViewController(vc,animated:true,completion:nil)
    }
    
    func lineBtnAction(){
        var shareText:String = self.navigationItem.title! + " " + self.pageUrl!
        var encodeMessage: String! = shareText.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        var messageURL: NSURL! = NSURL( string: "line://msg/text/" + encodeMessage )
        
        if (UIApplication.sharedApplication().canOpenURL(messageURL)) {
            UIApplication.sharedApplication().openURL( messageURL )
        }
    }
    
    func reportAlert(){
        var ac = UIAlertController(title: self.navigationItem.title, message: "この記事を報告しますか", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .Cancel) { (action) -> Void in
            println("Cancel button tapped.")
        }
        
        let okAction = UIAlertAction(title: "はい", style: .Default) { (action) -> Void in
            self.reportResultAlert()
        }
        
        ac.addAction(cancelAction)
        ac.addAction(okAction)
        
        presentViewController(ac, animated: true, completion: nil)
        
    }
    
    func reportResultAlert(){
//        var ac = UIAlertController(title: "報告をしました", message: "", preferredStyle: .Alert)
//        
//        let okAction = UIAlertAction(title: "閉じる", style: .Default) { (action) -> Void in
//        }
//        
//        ac.addAction(okAction)
//        
//        presentViewController(ac, animated: true, completion: nil)
        var body = "不快なコンテンツを含む記事を通報します。\n\n" + self.pageTitle! + "\n\n" + self.pageUrl!
        
        var picker = MFMailComposeViewController()
        picker.mailComposeDelegate = self
        picker.setToRecipients(["naoyashiga0@gmail.com"])
        picker.setSubject("問題のある記事の報告")
        picker.setMessageBody(body, isHTML: true)
        presentViewController(picker, animated: true, completion: nil)
    }
    
    // ボタンを押したときの処理
    func menuBtnTapped(sender:UIButton){
        if sender.isEqual(goBackBtn){
            wkWebView?.goBack()
        }else if sender.isEqual(goForwardBtn){
            wkWebView?.goForward()
        }
    }
    
    func changeBtnStatus(btn:UIButton){
        if btn.enabled {
            btn.setTitleColor(UIColor.webViewMenuBtnEnabledColor(), forState: UIControlState.Normal)
        }else{
            btn.setTitleColor(UIColor.webViewMenuBtnDisabledColor(), forState: UIControlState.Normal)
        }
    }
    
    func fadeAnimation(duration:CFTimeInterval,fromValue:CGFloat,toValue:CGFloat,view:UIView?){
        var fadeAnimation:CABasicAnimation = CABasicAnimation(keyPath: "opacity")
        fadeAnimation.duration = duration
        fadeAnimation.fromValue = fromValue
        fadeAnimation.toValue = toValue
        fadeAnimation.removedOnCompletion = false
        fadeAnimation.fillMode = kCAFillModeForwards
        view?.layer.addAnimation(fadeAnimation, forKey: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func webView(webView: WKWebView, createWebViewWithConfiguration configuration: WKWebViewConfiguration, forNavigationAction navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        //別タブを開くリンク対策 再度ページの読み込みをする
        if(navigationAction.targetFrame == nil){
            webView.loadRequest(navigationAction.request)
        }
        return nil
    }
    
    func webView(webView: WKWebView, didCommitNavigation navigation: WKNavigation!) {
    }
    
    deinit {
        wkWebView?.removeObserver(self, forKeyPath: "estimatedProgress")
        wkWebView?.removeObserver(self, forKeyPath: "canGoForward")
        wkWebView?.removeObserver(self, forKeyPath: "canGoBack")
        
        if isViaTableView{
            wkWebView?.removeObserver(self, forKeyPath: "title")
        }
    }
    
    override func observeValueForKeyPath(keyPath:String, ofObject object:AnyObject, change:[NSObject:AnyObject], context:UnsafeMutablePointer<Void>) {
        switch keyPath {
        case "estimatedProgress":
            if let progress = change[NSKeyValueChangeNewKey] as? Float {
//                println("Progress:\(progress)")
                if progress == 1 {
                    fadeAnimation(0.3, fromValue: 1, toValue: 0, view: progressBar)
                }
            }
        case "title":
            if let title = change[NSKeyValueChangeNewKey] as? NSString {
                if isViaTableView {
                    //tableView経由のときはタイトルを表示
                    self.navigationItem.title = title as String
                }
            }
        case "canGoForward":
            println("canGoForward")
            println(wkWebView?.canGoForward)
            
            var _menuView = self.view.viewWithTag(10)
            var _forwardBtn = _menuView?.viewWithTag(2) as! UIButton
            _forwardBtn.enabled = wkWebView!.canGoForward as Bool
            changeBtnStatus(_forwardBtn)
            
        case "canGoBack":
            println("canGoBack")
            println(wkWebView?.canGoBack)
            if wkWebView!.canGoBack as Bool {
                if let _menuView = self.view.viewWithTag(10) {
                    //menuViewを追加済み
                    fadeAnimation(0.4, fromValue: 0, toValue: 1, view: self.view.viewWithTag(10))
                    
                }else{
                    var _forwardBtn = UIButton()
                    _forwardBtn = menuView.viewWithTag(2) as! UIButton
                    _forwardBtn.enabled = false
                    changeBtnStatus(_forwardBtn)
                    self.view.addSubview(menuView)
                }
            }else{
                fadeAnimation(0.4, fromValue: 1.0, toValue: 0, view: self.view.viewWithTag(10))
            }
        default:
            break
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        dismissViewControllerAnimated(true, completion: nil)
    }
//    func userContentController(userContentController: WKUserContentController!,didReceiveScriptMessage message: WKScriptMessage!) {
//        if(message.name == "callbackHandler") {
//            println("JavaScript is sending a message \(message.body)")
//        }
//    }
}
