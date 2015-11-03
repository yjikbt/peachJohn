//
//  AppDelegate.swift
//  peachJohn
//
//  Created by Yuji Ikebata on 10/7/14.
//  Copyright (c) 2014 abisetaoshi. All rights reserved.
//

import UIKit
//import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
//        Parse.setApplicationId("NVVnPgdApMSI5JCQRk8uOmVEu5g1SN4lbrPvp8Kz", clientKey: "GcYXle2akID6dVDXLzZxSTXgx7Uiod3XkrxHDtTl")
//        
//        let userNotificationTypes: UIUserNotificationType = ([UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound]);
//        
//        let settings = UIUserNotificationSettings(forTypes: userNotificationTypes, categories: nil)
//        application.registerUserNotificationSettings(settings)
//        application.registerForRemoteNotifications()
        
        //Badge reset
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        return true
    }

//    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
//        let installation = PFInstallation.currentInstallation()
//        installation.setDeviceTokenFromData(deviceToken)
//        //        installation.saveInBackground()
//        installation.save()
//        print("got device id! \(deviceToken)")
//    }
//    
//    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
//        PFPush.handlePush(userInfo)
//    }
    
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

