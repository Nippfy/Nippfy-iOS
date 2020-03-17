//
//  AppDelegate.swift
//  Nippfy
//
//  Created by Manuel Salvador del Águila on 29/02/2020.
//  Copyright © 2020 Manuel Salvador del Águila. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        
        // Initial View Controller 
        let rootViewController = UINavigationController(rootViewController: ForgottenPasswordViewController())
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
        return true
    }

}

