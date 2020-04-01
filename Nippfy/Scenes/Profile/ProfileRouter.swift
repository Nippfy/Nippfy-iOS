//
//  ProfileRouter.swift
//  Nippfy
//
//  Created by Manuel Salvador del Águila on 01/04/2020.
//  Copyright (c) 2020 Manuel Salvador del Águila. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol ProfileRoutingLogic
{
    //func routeToSomewhere(segue: UIStoryboardSegue?)
    
    func routeToLogin()
}

protocol ProfileDataPassing
{
    var dataStore: ProfileDataStore? { get }
}

class ProfileRouter: NSObject, ProfileRoutingLogic, ProfileDataPassing
{
    weak var viewController: ProfileViewController?
    var dataStore: ProfileDataStore?
    
    // MARK: Routing
    
    func routeToLogin() {
        let destinationVC = LoginViewController()
        navigateToLogin(source: viewController!, destination: destinationVC)
    }
    
    // MARK: Navigation
    
    func navigateToLogin(source: ProfileViewController, destination: LoginViewController)
    {
        let destinationVC = UINavigationController(rootViewController: destination)
        source.present(destinationVC, animated: true, completion: nil)
    }
    
}
