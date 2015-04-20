//
//  SettingCell.swift
//  BlogReader
//
//  Created by naoyashiga on 2015/04/14.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {
    @IBOutlet weak var siteNameLabel: UILabel!
    @IBOutlet weak var feedSwitch: UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func feedSwitchChanged(sender: UISwitch) {
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setObject(sender.on, forKey: siteNameLabel.text!)
        println(sender.on)
    }
    
}
