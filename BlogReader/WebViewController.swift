//
//  WebViewController.swift
//  BlogReader
//
//  Created by naoyashiga on 2014/12/29.
//  Copyright (c) 2014年 naoyashiga. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    var wkWebView: WKWebView?
    var progressBar: UIProgressView?
    var screenHeight: CGFloat?
    var screenWidth: CGFloat?
    
    var pageUrl: String?
    var pageTitle: String?
    
    let footerHeight:CGFloat = 50.0
    let progressBarHeight: CGFloat = 2.0
    
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        screenHeight = self.view.bounds.height
        screenWidth = self.view.bounds.width
//        initBackButton()
        initProgressBar()
        initWebView()
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
        wkWebView = WKWebView(frame: CGRectMake(0, progressBarHeight, screenWidth!, screenHeight!))
        if let pageUrlNotOptional = pageUrl {
            var detailUrl = NSURL(string: pageUrlNotOptional)
            var detailUrlReq = NSURLRequest(URL: detailUrl!)
            wkWebView?.loadRequest(detailUrlReq)
        }
        self.view.addSubview(wkWebView!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
