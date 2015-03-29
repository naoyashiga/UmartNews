//
//  WebViewController.swift
//  BlogReader
//
//  Created by naoyashiga on 2014/12/29.
//  Copyright (c) 2014年 naoyashiga. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController,WKUIDelegate{
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
//        screenHeight = self.view.bounds.height - tabBar.frame.size.height
//        menuView = UINib(nibName: "WebViewMenu", bundle: nil).instantiateWithOwner(self, options: nil)[0] as UIView
//        menuView = NSBundle.mainBundle().loadNibNamed("WebViewMenu", owner: self, options: nil)[0] as UIView
//        menuView = WebViewBottomMenu.instance()
        
//        println(menuView.frame.size.height)
//        println(menuView.layer.position)
        screenHeight = setScreenHeight()
        
        println(screenHeight)
        screenWidth = self.view.bounds.width
        initBackButton()
        initProgressBar()
        initWebView()
        initMenuView()
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
        
        println(statusBarHeight + navigationBarHeight!)
        return self.view.bounds.height - statusBarHeight - navigationBarHeight!
    }
    
    func initMenuView(){
        let btnSize : CGFloat = 50
        let btnFontSize : CGFloat = 50.0
        let menuLeftMargin : CGFloat = 10.0
        let menuViewWidth : CGFloat = 150
        let menuViewHeight: CGFloat = 60.0
        let btnLeftMargin : CGFloat = 40.0
        let goForwardBtnPosX = menuLeftMargin + btnFontSize + btnLeftMargin
        
        var menuViewPosX : CGFloat = (screenWidth! - menuViewWidth) / 2
        var menuViewPosY : CGFloat?
        
        if isViaTableView {
            menuViewPosY = progressBarHeight + screenHeight! - menuViewHeight
        }else{
            menuViewPosY = progressBarHeight + screenHeight! - menuViewHeight * 1.5
        }
        
        menuView = UIView(frame: CGRectMake(menuViewPosX, menuViewPosY!, menuViewWidth, menuViewHeight))
        menuView.backgroundColor = UIColor.hexStr("000000", alpha: 0.6)
        
        goBackBtn = UIButton(frame: CGRectMake(menuLeftMargin, menuViewHeight / 2 - btnFontSize / 2, btnSize, btnSize))
        goBackBtn.setTitle("<", forState: UIControlState.Normal)
        goBackBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        goBackBtn.titleLabel!.font = UIFont(name: "Helvetica-Bold",size: btnFontSize)
        goBackBtn.addTarget(self, action: "menuBtnTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        goForwardBtn = UIButton(frame: CGRectMake(goForwardBtnPosX, menuViewHeight / 2 - btnFontSize / 2, btnSize, btnSize))
        goForwardBtn.setTitle(">", forState: UIControlState.Normal)
        goForwardBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        goForwardBtn.titleLabel!.font = UIFont(name: "Helvetica-Bold",size: btnFontSize)
        goForwardBtn.addTarget(self, action: "menuBtnTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        menuView.addSubview(goBackBtn)
        menuView.addSubview(goForwardBtn)
        
        self.view.addSubview(menuView)
    }
    
    func initProgressBar(){
        progressBar = UIProgressView(frame: CGRectMake(0, 0, screenWidth!, progressBarHeight))
        progressBar!.progressTintColor = UIColor.blueColor()
        progressBar!.trackTintColor = UIColor.whiteColor()
        progressBar!.setProgress(1.0, animated: true)
        progressBar!.transform = CGAffineTransformMakeScale(1.0, 2.0)
        self.view.addSubview(progressBar!)
    }
    
    func initWebView(){
        
        if pageTitle == "動画" {
            println("js execute")
            var contentController = WKUserContentController();
            if let path = NSBundle.mainBundle().pathForResource("script", ofType: "js") {
                if let source = NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil) {
                    var userScript = WKUserScript(source: source, injectionTime: WKUserScriptInjectionTime.AtDocumentEnd, forMainFrameOnly: true)
                    contentController.addUserScript(userScript)
//                    contentController.addScriptMessageHandler(
//                        self,
//                        name: "callbackHandler"
//                    )
                }
            }

            var config = WKWebViewConfiguration()
            config.userContentController = contentController
            wkWebView = WKWebView(frame: CGRectMake(0, progressBarHeight, screenWidth!, screenHeight!), configuration: config)
            
        }else {
            wkWebView = WKWebView(frame: CGRectMake(0, progressBarHeight, screenWidth!, screenHeight!))
        }
//        wkWebView?.allowsBackForwardNavigationGestures = true
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
    
    func back() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    // ボタンを押したときの処理
    func menuBtnTapped(sender:UIButton){
        if sender.isEqual(goBackBtn){
            wkWebView?.goBack()
        }else if sender.isEqual(goForwardBtn){
            wkWebView?.goForward()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(webView: WKWebView!, createWebViewWithConfiguration configuration: WKWebViewConfiguration!, forNavigationAction navigationAction: WKNavigationAction!, windowFeatures: WKWindowFeatures!) -> WKWebView! {
        //別タブを開くリンク対策 再度ページの読み込みをする
        if(navigationAction.targetFrame == nil){
            webView.loadRequest(navigationAction.request)
        }
        return nil
    }
    
    func webView(webView: WKWebView, didCommitNavigation navigation: WKNavigation!) {
    }
    
//    func userContentController(userContentController: WKUserContentController!,didReceiveScriptMessage message: WKScriptMessage!) {
//        if(message.name == "callbackHandler") {
//            println("JavaScript is sending a message \(message.body)")
//        }
//    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
