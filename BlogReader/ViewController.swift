//
//  ViewController.swift
//  BlogReader
//
//  Created by naoyashiga on 2014/12/28.
//  Copyright (c) 2014年 naoyashiga. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet var tableView: UITableView!
    var myEntries:NSMutableArray!
//    var ogpImage:[String] = [""]

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.addData()
        myEntries = NSMutableArray()
        
        tableView.registerNib(UINib(nibName: "Cell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.rowHeight = UIScreen.mainScreen().bounds.height / 7
        
//        var websiteURL: String = "http://rssblog.ameba.jp/ebizo-ichikawa/rss20.xml"
//        var websiteURL: String = "http://keiba.jp/rss/news.xml"
//        var websiteURL: String = "http://feed.rssad.jp/rss/nikkansports/race/atom.xml"
//        var websiteURL: String = "http://api.plaza.rakuten.ne.jp/dailykeiba/rss/"
//        var websiteURL: String = "http://www.jra.go.jp/rss/jra-info.rdf"
//        var websiteURL: String = "http://umasoku.doorblog.jp/index.rdf"
        var websiteURLs: [String] = [
            "https://keiba-news-api.herokuapp.com/feed"
//            "http://blog.livedoor.jp/demuchi/index.rdf"
            ]
        
        for websiteURL in websiteURLs{
            let url:NSURL = NSURL(string: websiteURL)!
            loadRss(url)
        }
        
//        getData()
//        getOGPImage()
    }
    
    func loadRss(data:NSURL){
//        var myParser:XmlParserManager = XmlParserManager.alloc().initWithURL(data) as XmlParserManager
        var myParser:JsonParserManager = JsonParserManager.alloc().initWithURL(data) as JsonParserManager
        myEntries = myParser.entries
//
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myEntries.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: Cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as Cell
        let entry : Entry = myEntries[indexPath.row] as Entry
        cell.titleLabel.text = entry.title
        cell.titleLabel.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width / 2, 0)
//        cell.titleLabel.adjustsFontSizeToFitWidth = false
        cell.titleLabel.sizeToFit()
        
        cell.dateLabel.text = entry.date
        cell.siteLabel.text = entry.source
        
//        var q_global: dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
//        var q_main: dispatch_queue_t  = dispatch_get_main_queue()
        
//        getData(entry.url)
//        println(self.ogpImage.count)
//        println(indexPath.row)
//        println(entry.ogpImageUrl)
//        println(self.ogpImage[0])
        
//        dispatch_async(q_global, {
//            println("cc")
//            println(indexPath.row)
//            var imageURL: NSURL!
//            if (self.ogpImage.count == 0) {
//                imageURL = NSURL(string: self.ogpImage[indexPath.row])!
//            }else{
//                println(self.ogpImage.count)
//            }
////            var imageURL: NSURL = NSURL(string: self.ogpImage[indexPath.row])!
//            var imageData: NSData = NSData(contentsOfURL: imageURL)!
//            
//            var image: UIImage = UIImage(data: imageData)!
//            
//            dispatch_async(q_main, {
//                cell.cellImageView.image = image
//                cell.cellImageView.frame = CGRectMake(0, 0, 50, 50)
//                cell.layoutSubviews()
//                
//            })
//        })
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var webVC:WebViewController = self.storyboard?.instantiateViewControllerWithIdentifier("WebViewController") as WebViewController
        
        var entry:Entry = myEntries[indexPath.row] as Entry
        webVC.entry = entry
        self.navigationController?.pushViewController(webVC, animated: true)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
//    func getData(ogpUrl:String){
//        let apiUrl = "http://api.hitonobetsu.com/ogp/analysis?url="
//        let url = NSURL(string: apiUrl + ogpUrl)
//        let req = NSURLRequest(URL: url!)
//        let connection: NSURLConnection = NSURLConnection(request: req, delegate: self,startImmediately: false)!
//        
//        NSURLConnection.sendAsynchronousRequest(req, queue: NSOperationQueue.mainQueue(), completionHandler: response)
//    }
    
    
//    func response(res: NSURLResponse!, data: NSData!, error: NSError!){
//        let json:NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as NSDictionary
//        
//        let imgUrl:String = json["image"] as String
//        
//        
//        
//        dispatch_async(dispatch_get_main_queue(), { () -> Void in
//            self.ogpImage.append(imgUrl)
//            println("bb")
//            println(self.ogpImage)
//            self.tableView.reloadData()
//        })
//        
//    }
    
//    func addData(entry:Entry){
//        let newData = PFObject(className: "Entry")
//        newData.setObject(entry.title, forKey: "title")
//        newData.setObject(entry.date, forKey: "date")
//        newData.setObject(entry.source, forKey: "siteName")
//        
//        newData.saveInBackgroundWithBlock({ (isSuccess,error) -> Void in
////            self.loadData()
//            
//        })
//    }
//    
//    func loadData(){
//        var query:PFQuery = PFQuery(className: "Entry")
//        query.orderByAscending("createdAt")
//        query.findObjectsInBackgroundWithBlock{(objects: [AnyObject]!, error: NSError!) -> Void in
//            if (error != nil){
//                
//            }
//            
//            for object in objects {
//                println(object["title"] as String)
//            }
//        }
//    }
//    func getOGPImage(){
//        let manager = AFHTTPRequestOperationManager()
//        
//        let headerSet = NSSet(object: "text/html")
//        manager.responseSerializer.acceptableContentTypes = headerSet
//        manager.GET(
//            "http://api.hitonobetsu.com/ogp/analysis?url=http://ameblo.jp/ebizo-ichikawa/entry-11970372613.html",
//            parameters: nil,
//            success: {
//                (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
//                println(responseObject)
//                
//                if let dict = responseObject as? NSDictionary{
//                    println(dict["url"])
//                }
//            },
//            failure: {
//                (operation: AFHTTPRequestOperation!, error: NSError!) in
//                println(error.localizedDescription)
//        })
//        
//    }


}

