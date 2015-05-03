//
//  WebViewBottomMenu.swift
//  BlogReader
//
//  Created by naoyashiga on 2015/03/28.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit

class WebViewBottomMenu : UIView {
    
    class func instance() -> WebViewBottomMenu {
        return UINib(nibName: "WebViewBottomMenu", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! WebViewBottomMenu
    }
}