//
//  AppDelegate.swift
//  府河人家
//
//  Created by 诸葛俊伟 on 9/19/16.
//  Copyright © 2016 Sichuan Gourmet. All rights reserved.
//

// GitHub: https://github.com/zhugejunwei/100-Days-of-Swift
// Blog: https://kongming.io

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Set the global UINavigationBar property
        let bar = UINavigationBar.appearance()
        bar.tintColor = UIColor.black
        bar.titleTextAttributes = [NSFontAttributeName:UIFont.systemFont(ofSize: 15), NSForegroundColorAttributeName:UIColor.black]
        
        // 设置 window
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // 根据版本号，判断进入那个控制器
        if toNewFeature() {
            window?.rootViewController = NewFeatureViewController()
        } else {
            // for test, go to newFeatureView every time...
            window?.rootViewController = MainViewController()
//            window?.rootViewController = NewFeatureViewController()
        }
        window?.makeKeyAndVisible()
        return true
    }
    
    fileprivate let SLBundleShortVersionString = "SLBundleShortVersionString"
    
    fileprivate func toNewFeature() -> Bool
    {
        // Decide whether go to newFeature view according to the version number
        let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        let oldVersion = UserDefaults.standard.object(forKey: SLBundleShortVersionString) ?? ""
        
        // if currentVersion is higher than oldVersion, then store it.
        if (currentVersion.compare(oldVersion as! String)) == .orderedDescending {
            // store current
            UserDefaults.standard.set(currentVersion, forKey: SLBundleShortVersionString)
            return true
        }
        return false
    }
}

