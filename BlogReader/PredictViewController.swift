//
//  MatomeViewController.swift
//  BlogReader
//
//  Created by naoyashiga on 2015/03/26.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit

class PredictViewController: UITableViewController {
//    @IBOutlet weak var tableView: UITableView!
    
    var myEntries:NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myEntries = NSMutableArray()
        
        tableView.registerNib(UINib(nibName: "Cell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        tableView.estimatedRowHeight = 100
        //        tableView.rowHeight = UIScreen.mainScreen().bounds.height / 7
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.autoresizingMask = UIViewAutoresizing()
        
        let url:NSURL = NSURL(string: "https://keiba-news-api.herokuapp.com/predict")!
        loadRss(url)
    }
    
    func loadRss(data:NSURL){
        var myParser:JsonParserManager = JsonParserManager.alloc().initWithURL() as JsonParserManager
        myParser.startParse(data){
            () in
            self.myEntries = myParser.entries
            self.tableView.reloadData()
        }
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
        var webVC:WebViewController = self.storyboard?.instantiateViewControllerWithIdentifier("WebViewController") as WebViewController
        
        var entry:Entry = myEntries[indexPath.row] as Entry
        webVC.entry = entry
        self.navigationController?.pushViewController(webVC, animated: true)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
