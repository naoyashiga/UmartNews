//
//  HexColor.swift
//  BlogReader
//
//  Created by naoyashiga on 2015/03/29.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit

extension UIColor {
    class func hexStr (var hexStr : NSString, var alpha : CGFloat) -> UIColor {
        hexStr = hexStr.stringByReplacingOccurrencesOfString("#", withString: "")
        let scanner = NSScanner(string: hexStr)
        var color: UInt32 = 0
        if scanner.scanHexInt(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r,green:g,blue:b,alpha:alpha)
        } else {
            print("invalid hex string")
            return UIColor.whiteColor();
        }
    }
    
    class func webViewMenuBackgroundColor() -> UIColor {
        return UIColor.hexStr("000000", alpha: 0.6)
    }
    
    class func webViewMenuBtnEnabledColor() -> UIColor {
        return UIColor.hexStr("ffffff", alpha: 1)
    }
    
    class func webViewMenuBtnDisabledColor() -> UIColor {
        return UIColor.hexStr("000000", alpha: 0.8)
    }
    
    class func navigationBarTintColor() -> UIColor {
        return UIColor.hexStr("29B6F6", alpha: 1)
    }
    
    class func progressTintColor() -> UIColor {
        return UIColor.hexStr("A8F1FF", alpha: 1)
    }
    
    class func scrollMenuBackgroundColor() -> UIColor {
        return UIColor.hexStr("d4f0fd", alpha: 1)
    }
    
    class func viewBackgroundColor() -> UIColor {
        return UIColor.hexStr("186d93", alpha: 1)
    }
    
    class func selectionIndicatorColor() -> UIColor {
        return UIColor.hexStr("F06292", alpha: 1)
    }
    
    class func bottomMenuHairlineColor() -> UIColor {
        return UIColor.hexStr("F06292", alpha: 1)
    }
    
    class func selectedMenuItemLabelColor() -> UIColor {
        return UIColor.hexStr("145b7b", alpha: 1)
    }
    
    class func unselectedMenuItemLabelColor() -> UIColor {
        return UIColor.hexStr("3ebdf6", alpha: 1)
    }
}