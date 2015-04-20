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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib(nibName: "SettingCell", bundle: nil), forCellReuseIdentifier: "SettingCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return mySections.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mySections[section] as String
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return myMatomes.count
            
        }else if section == 1{
            return myPredicts.count
        }else{
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("SettingCell", forIndexPath: indexPath) as SettingCell
        var siteName:String?
        let ud = NSUserDefaults.standardUserDefaults()
        
        if indexPath.section == 0{
            siteName = myMatomes[indexPath.row]
        }else if indexPath.section == 1 {
            siteName = myPredicts[indexPath.row]
        }
        
        //行間を調整
        let attributedText = NSMutableAttributedString(string: siteName!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.3
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        
        cell.siteNameLabel.attributedText = attributedText
        cell.siteNameLabel.sizeToFit()
        cell.feedSwitch.on = ud.boolForKey(cell.siteNameLabel.text!)
        
        return cell
    }
}
    
