//
//  SettingViewController.swift
//  BlogReader
//
//  Created by naoyashiga on 2015/04/14.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//


import UIKit

class SettingViewController: UITableViewController {
    var parentNavigationController : UINavigationController?
    var mySettings = [
        "AAA",
        "BBB",
        "CCC",
        "DDD",
        "FFF"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib(nibName: "SettingCell", bundle: nil), forCellReuseIdentifier: "SettingCell")
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.autoresizingMask = UIViewAutoresizing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mySettings.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("SettingCell", forIndexPath: indexPath) as SettingCell
        var siteName = mySettings[indexPath.row]
        
        //行間を調整
        let attributedText = NSMutableAttributedString(string: siteName)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.3
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        
        cell.siteNameLabel.attributedText = attributedText
        cell.siteNameLabel.sizeToFit()
        
        return cell
    }
}
    
