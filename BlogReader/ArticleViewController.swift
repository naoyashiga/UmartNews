//
//  ArticleViewController.swift
//  BlogReader
//
//  Created by naoyashiga on 2015/03/28.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit
import GoogleMobileAds

//class ArticleViewController: UITableViewController,GADBannerViewDelegate {
//    var parentNavigationController : UINavigationController?
//    var myEntries:NSMutableArray!
////    var myEntries = [String]()
//    var feedURL:String!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//    
//    func setTableView(){
//        
//        myEntries = NSMutableArray()
//        
//        tableView.registerNib(UINib(nibName: "Cell", bundle: nil), forCellReuseIdentifier: "Cell")
//        
//        tableView.estimatedRowHeight = 100
//        tableView.rowHeight = UITableViewAutomaticDimension
//        
//        tableView.autoresizingMask = UIViewAutoresizing()
//        
//        let refreshControl = UIRefreshControl()
//        refreshControl.addTarget(self, action: Selector("refreshInvoked"), forControlEvents: UIControlEvents.ValueChanged)
//        self.refreshControl = refreshControl
//        
//        reload()
//    }
//    
//    func checkFeedSite(siteNameArray:NSArray) -> String{
//        var param = "?"
//        var cnt = 1
//        //配信設定
//        let ud = NSUserDefaults.standardUserDefaults()
//        
//        for siteNameStr in siteNameArray {
//            param = param + "key" + String(cnt) + "="
//            if ud.boolForKey(siteNameStr as! String) {
//                param = param + "1"
//            }else{
//                //配信停止
//                param = param + "0"
//            }
//            
//            if cnt < siteNameArray.count {
//                param = param + "&"
//            }
//            cnt++
//        }
//        
//        return param
//    }
//    
//    func reload() {
//        let URL = NSURL(string: feedURL)
//        let Req = NSURLRequest(URL: URL!)
//        let connection: NSURLConnection = NSURLConnection(request: Req, delegate: self, startImmediately: false)!
//        
////        NSURLConnection.sendAsynchronousRequest(Req,
////            queue: NSOperationQueue.mainQueue(),
////            completionHandler: self.fetchResponse)
//    }
//    
//    func fetchResponse(res: NSURLResponse!, data: NSData!, error: NSError!) {
//        let json: NSArray = (try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments))as! NSArray
//        
////        myEntries = [String]()
//        myEntries = NSMutableArray()
//        var tmpEntry = Entry()
//        
//        
//        for j in json {
//            tmpEntry.title = j["title"] as! String
//            tmpEntry.source = j["source"] as! String
//            tmpEntry.link = j["link"] as! String
//            tmpEntry.date = j["pubDate"] as! String
//            
//            
//            myEntries.addObject(tmpEntry)
//            //初期化
//            tmpEntry = Entry()
//        }
//        
//        dispatch_async(dispatch_get_main_queue(), {
//            self.tableView.reloadData()
//        })
//    }
//    
////    func loadRss(){
////        let url:NSURL = NSURL(string: feedURL)!
////        var myParser:JsonParserManager = JsonParserManager.alloc().initWithURL() as JsonParserManager
////        myParser.startParse(url){
////            () in
////            var q_main : dispatch_queue_t = dispatch_get_main_queue()
////            
////            dispatch_async(q_main, {() in
////                self.myEntries = myParser.entries
//////                self.tableView.reloadData()
////            })
////        }
////        
//////        myParser.startParse(url){
//////            () in
//////            self.myEntries = myParser.entries
//////            self.tableView.reloadData()
//////        }
////    }
//    
//    func refreshInvoked() {
//        print("start refresh")
//        
//        //配信設定を考慮して再読み込み
//        if(self.title == "まとめ"){
//            feedURL = URL.MATOME.rawValue + checkFeedSite(myMatomes)
//        }else if(self.title == "予想"){
//            feedURL = URL.PREDICT.rawValue + checkFeedSite(myPredicts)
//        }
//        print(feedURL)
//        
//        reload()
//        self.refreshControl?.endRefreshing()
//        print("end refresh")
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//    
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return myEntries.count
//    }
//    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell: Cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! Cell
//        let entry : Entry = myEntries[indexPath.row] as! Entry
//        
//        //行間を調整
//        let attributedText = NSMutableAttributedString(string: entry.title)
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineHeightMultiple = 1.3
//        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
//        
////        cell.titleLabel.text = entry.title
//        cell.titleLabel.attributedText = attributedText
//        cell.titleLabel.sizeToFit()
//        
//        cell.dateLabel.text = entry.date
//        cell.siteLabel.text = entry.source
//        
//        //        println("***********")
//        //        println(entry)
//        //        println(entry.title)
//        //        println(entry.source)
//        //        println(entry.date)
//        
//        return cell
//    }
//    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let webVC = WebViewController()
//        
//        let entry:Entry = myEntries[indexPath.row] as! Entry
//        webVC.pageUrl = entry.link
//        webVC.pageTitle = entry.title
//        
//        parentNavigationController?.pushViewController(webVC, animated: true)
////        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//    }
//}
