//
//  AppDelegate.swift
//  Nippfy
//
//  Created by Manuel Salvador del Águila on 29/02/2020.
//  Copyright © 2020 Manuel Salvador del Águila. All rights reserved.
//

import UIKit
import Firebase
import Braintree
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        
        // Braintree Paypal
        BTAppSwitch.setReturnURLScheme("es.nippfygestion.Nippfy.payments")
        
        // Firebase
        FirebaseApp.configure()
        
        // Google API
        GoogleApi.shared.initialiseWithKey("")
        
        // Enable the automatic hiding and showing keyboard
        IQKeyboardManager.shared.enable = true
        
        // When is tapped outside of the TextField/TextView, the keyboard dismisses
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        
        // Initial View Controller 
        let rootViewController = UINavigationController(rootViewController: LoginViewController())
        let rootViewController2 = TabBarViewController()
        window?.rootViewController = rootViewController2
        window?.makeKeyAndVisible()
        
        return true
    }
    
    
    // MARK: Braintree Paypal
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.scheme?.localizedCaseInsensitiveCompare("es.nippfygestion.Nippfy.payments") == .orderedSame {
            print("RETURN TRUE")
            return BTAppSwitch.handleOpen(url, options: options)
        }
        print("RETURN FALSE")
        return false
    }
    
}

