//
//  AppDelegate.swift
//  WhatEat
//
//  Created by 周子龙 on 2019/12/17.
//  Copyright © 2019 zhouzilong. All rights reserved.
//

import UIKit
import GoogleMobileAds
import Bugly

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = getRootVC()
        window?.makeKeyAndVisible()
        initAdvertising()
//        loadAdTimer()
        ZLDataBase.shared.createDB()
        #if DEBUG
        Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle")?.load()
        #else
        setBugly()
        #endif
        // 版本更新
//        updateApp()
        return true
    }
    
    func getRootVC() -> UIViewController{
        return ZLBaseNavigationController(rootViewController: ZLHomeViewController())
    }
    
    // 初始化广告
    func initAdvertising() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    // 正式环境才使用Bugly
    func setBugly() {
        Bugly.start(withAppId: ZLAppConfigKey.buglyID)
    }
    
    func updateApp() {
        ZLVersionUpdate.shared.updateVersion()
    }
    
    func loadAdTimer() {
        ZLGlobalTimer.shared.initClick()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}
