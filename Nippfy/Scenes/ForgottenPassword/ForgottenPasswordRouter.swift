//
//  ForgottenPasswordRouter.swift
//  Nippfy
//
//  Created by Manuel Salvador del Águila on 29/02/2020.
//  Copyright (c) 2020 Manuel Salvador del Águila. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol ForgottenPasswordRoutingLogic
{
    //func routeToSomewhere(segue: UIStoryboardSegue?)
    func routeLoginScene()
}

protocol ForgottenPasswordDataPassing
{
    var dataStore: ForgottenPasswordDataStore? { get }
}

class ForgottenPasswordRouter: NSObject, ForgottenPasswordRoutingLogic, ForgottenPasswordDataPassing
{
    weak var viewController: ForgottenPasswordViewController?
    var dataStore: ForgottenPasswordDataStore?
    
    // MARK: Routing
    
    func routeLoginScene() {
        let destinationVC = LoginViewController()
        navigateToLoginScene(source: viewController!, destination: destinationVC)
    }
    
    // MARK: Navigation
    
    func navigateToLoginScene(source: ForgottenPasswordViewController, destination: LoginViewController)
    {
        // source.present(destination, animated: true, completion: nil)
        // source.show(destination, sender: self)
        source.navigationController?.popViewController(animated: true)
    }
}
