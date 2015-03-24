//
//  WebViewController.swift
//  BlogReader
//
//  Created by naoyashiga on 2014/12/29.
//  Copyright (c) 2014年 naoyashiga. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    var entry: Entry!
    
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenWidth: CGFloat = UIScreen.mainScreen().bounds.width
        let screenHeight: CGFloat = UIScreen.mainScreen().bounds.height
        //        webView.frame = CGRect(x: 0, y: 0,width: screenWidth,height: screenHeight)
        
        // Do any additional setup after loading the view.
        var request: NSURLRequest = NSURLRequest(URL:NSURL(string: entry.link)!)
        println(entry.link)
        webView.loadRequest(request)
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
