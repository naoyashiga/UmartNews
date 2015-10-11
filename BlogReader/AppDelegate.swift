//
//  AppDelegate.swift
//  BlogReader
//
//  Created by naoyashiga on 2014/12/28.
//  Copyright (c) 2014年 naoyashiga. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var myNavigationController: UINavigationController?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let viewController = ViewController()
        myNavigationController = UINavigationController(rootViewController: viewController)
        self.window!.rootViewController = myNavigationController
        self.window!.makeKeyAndVisible()
        
        Parse.setApplicationId("HMtylaPpY3kbnyc69w4xpToOVEYdyVIzS4tN7Bst", clientKey: "qlbsTVGpuCWdfSY8X6oTkD0MGBoj86ChJGUTRlTa")
        
        let userNotificationTypes: UIUserNotificationType = ([UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound]);
        
        let settings = UIUserNotificationSettings(forTypes: userNotificationTypes, categories: nil)
        application.registerUserNotificationSettings(settings)
        application.registerForRemoteNotifications()
        
        //Badge reset
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        
        //配信設定
        let ud = NSUserDefaults.standardUserDefaults()
        if(ud.objectForKey("神競馬2nd") == nil){
            for siteNameStr in myMatomes {
                ud.setObject(true, forKey: siteNameStr)
            }
            
            for siteNameStr in myPredicts {
                ud.setObject(true, forKey: siteNameStr)
            }
        }
        
        return true
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let installation = PFInstallation.currentInstallation()
        installation.setDeviceTokenFromData(deviceToken)
        installation.saveInBackgroundWithBlock { succeeded, error in
            if error != nil {
                print("parsePushUserAssign save error.")
            }else {
                print("success")
            }
        }
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        PFPush.handlePush(userInfo)
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }
}