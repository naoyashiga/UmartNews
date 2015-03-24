//
//  Cell.swift
//  BlogReader
//
//  Created by naoyashiga on 2014/12/28.
//  Copyright (c) 2014年 naoyashiga. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var siteLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
