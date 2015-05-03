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
        
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let viewController = ViewController()
        myNavigationController = UINavigationController(rootViewController: viewController)
        self.window!.rootViewController = myNavigationController
        self.window!.makeKeyAndVisible()
        
        
        Parse.setApplicationId("HMtylaPpY3kbnyc69w4xpToOVEYdyVIzS4tN7Bst", clientKey: "qlbsTVGpuCWdfSY8X6oTkD0MGBoj86ChJGUTRlTa")
        
        let userNotificationTypes = (UIUserNotificationType.Alert |
            UIUserNotificationType.Badge |
            UIUserNotificationType.Sound);
        
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
//        installation.saveInBackground()
        installation.save()
        println("got device id! \(deviceToken)")
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        PFPush.handlePush(userInfo)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

