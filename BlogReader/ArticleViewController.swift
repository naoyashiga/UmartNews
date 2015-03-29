//
//  ArticleViewController.swift
//  BlogReader
//
//  Created by naoyashiga on 2015/03/28.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit

class ArticleViewController: UITableViewController {
    var parentNavigationController : UINavigationController?
    var myEntries:NSMutableArray!
    var feedURL:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myEntries = NSMutableArray()
        
        tableView.registerNib(UINib(nibName: "Cell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        tableView.estimatedRowHeight = 100
        //        tableView.rowHeight = UIScreen.mainScreen().bounds.height / 7
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.autoresizingMask = UIViewAutoresizing()
        
        var refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: Selector("refreshInvoked"), forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
        
        loadRss()
    }
    
    func loadRss(){
        let url:NSURL = NSURL(string: feedURL)!
        var myParser:JsonParserManager = JsonParserManager.alloc().initWithURL() as JsonParserManager
        myParser.startParse(url){
            () in
            var q_main : dispatch_queue_t = dispatch_get_main_queue()
            
            dispatch_async(q_main, {() in
                self.myEntries = myParser.entries
//                self.tableView.reloadData()
            })
        }
        
//        myParser.startParse(url){
//            () in
//            self.myEntries = myParser.entries
//            self.tableView.reloadData()
//        }
    }
    
    func refreshInvoked() {
        println("start refresh")
        loadRss()
        self.refreshControl?.endRefreshing()
        println("end refresh")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        cell.titleLabel.text = entry.title
        cell.titleLabel.sizeToFit()
        
        cell.dateLabel.text = entry.date
        cell.siteLabel.text = entry.source
        
        //        println("***********")
        //        println(entry)
        //        println(entry.title)
        //        println(entry.source)
        //        println(entry.date)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var webVC = WebViewController()
        
        var entry:Entry = myEntries[indexPath.row] as Entry
        webVC.pageUrl = entry.link
        webVC.pageTitle = entry.title
        
        parentNavigationController?.pushViewController(webVC, animated: true)
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
