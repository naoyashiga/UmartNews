//
//  MatomeViewController.swift
//  BlogReader
//
//  Created by naoyashiga on 2015/03/26.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit

class MatomeViewController: UITableViewController {

//    @IBOutlet var tableView: UITableView!
    var myEntries:NSMutableArray!
    //    var ogpImage:[String] = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        self.addData()
        myEntries = NSMutableArray()
        
        tableView.registerNib(UINib(nibName: "Cell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        tableView.estimatedRowHeight = 100
        //        tableView.rowHeight = UIScreen.mainScreen().bounds.height / 7
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.autoresizingMask = UIViewAutoresizing()
        
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
        var myParser:JsonParserManager = JsonParserManager.alloc().initWithURL() as JsonParserManager
        myParser.startParse(data){
            () in
            println("finish")
            self.myEntries = myParser.entries
            self.tableView.reloadData()
        }
        //        myEntries = myParser.entries
        //
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myEntries.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: Cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as Cell
        let entry : Entry = myEntries[indexPath.row] as Entry
        //        cell.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height / 10)
        cell.titleLabel.text = entry.title
        //        cell.titleLabel.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width / 2, 0)
        //        cell.titleLabel.adjustsFontSizeToFitWidth = false
        cell.titleLabel.sizeToFit()
        
        cell.dateLabel.text = entry.date
        cell.siteLabel.text = entry.source
        
        println("***********")
        println(entry)
        println(entry.title)
        println(entry.source)
        println(entry.date)
      
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var webVC:WebViewController = self.storyboard?.instantiateViewControllerWithIdentifier("WebViewController") as WebViewController
        
        var entry:Entry = myEntries[indexPath.row] as Entry
        webVC.entry = entry
        self.navigationController?.pushViewController(webVC, animated: true)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
