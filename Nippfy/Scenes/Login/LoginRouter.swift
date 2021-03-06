//
//  LoginRouter.swift
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

@objc protocol LoginRoutingLogic
{
    //func routeToSomewhere(segue: UIStoryboardSegue?)
    func routeForgotPasswordScene()
    func routeRegisterScene()
    func routeToSearchScene()
}

protocol LoginDataPassing
{
    var dataStore: LoginDataStore? { get }
}

class LoginRouter: NSObject, LoginRoutingLogic, LoginDataPassing
{
    
    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?
    
    func routeForgotPasswordScene() {
        let destinationVC = ForgottenPasswordViewController()
        navigateToForgotPasswordScene(source: viewController!, destination: destinationVC)
    }
    
    func routeToSearchScene() {
        let destinationVC = SearchViewController()
        navigateToSearchViewController(source: viewController!, destination: destinationVC)
    }
    
    func routeRegisterScene() {
        let destinationVC = RegisterViewController()
        navigateToRegisterScene(source: viewController!, destination: destinationVC)
    }
    
    // MARK: Navigation
    
    func navigateToForgotPasswordScene(source: LoginViewController, destination: ForgottenPasswordViewController)
    {
        // source.present(destination, animated: true, completion: nil)
        source.show(destination, sender: self)
    }
    
    func navigateToRegisterScene(source: LoginViewController, destination: RegisterViewController)
    {
        source.show(destination, sender: self)
        // source.show(destination, animated: true, completion: nil)
        // source.present(UINavigationController(rootViewController: destination), animated: true, completion: nil)
    }
    
    func navigateToSearchViewController(source: LoginViewController, destination: SearchViewController) {
        source.dismiss(animated: true, completion: nil)
    }
    
}
