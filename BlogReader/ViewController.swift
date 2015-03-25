//
//  ViewController.swift
//  BlogReader
//
//  Created by naoyashiga on 2014/12/28.
//  Copyright (c) 2014年 naoyashiga. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    var pageMenu : CAPSPageMenu?
 

    override func viewDidLoad() {
        super.viewDidLoad()
        // Array to keep track of controllers in page menu
        var controllerArray : [UIViewController] = []
        
        // Create variables for all view controllers you want to put in the
        // page menu, initialize them, and add each to the controller array.
        // (Can be any UIViewController subclass)
        // Make sure the title property of all view controllers is set
        // Example:
        var controller : UIViewController = UIViewController(nibName: "MatomeViewController", bundle: nil)
        controller.title = "2chまとめ"
        controllerArray.append(controller)
        
        var predictController : UIViewController = UIViewController(nibName: "MatomeViewController", bundle: nil)
        predictController.title = "予想"
        controllerArray.append(predictController)
        
        // Customize page menu to your liking (optional) or use default settings by sending nil for 'options' in the init
        // Example:
        var parameters: [String: AnyObject] = [
            "viewBackgroundColor":UIColor.blueColor(),
            "menuItemSeparatorWidth": 4.3,
            "useMenuLikeSegmentedControl": true,
            "menuItemSeparatorPercentageHeight": 0.1]
        
        // Initialize page menu with controller array, frame, and optional parameters
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height), options: parameters)
        
        // Lastly add page menu as subview of base view controller view
        // or use pageMenu controller in you view hierachy as desired
        self.view.addSubview(pageMenu!.view)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

