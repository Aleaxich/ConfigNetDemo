//
//  AppDelegate.swift
//  MyConfigNetDemo
//
//  Created by 匿名用户的笔记本 on 2023/7/10.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.frame = UIScreen.main.bounds
        let homeNav = UINavigationController.init(rootViewController: ViewController.init())
        window?.rootViewController = homeNav
        window?.makeKeyAndVisible()
        return true
    }

 


}

