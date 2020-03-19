//
//  PaymentRouter.swift
//  Nippfy
//
//  Created by Manuel Salvador del Águila on 18/03/2020.
//  Copyright (c) 2020 Manuel Salvador del Águila. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol PaymentRoutingLogic
{
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol PaymentDataPassing
{
    var dataStore: PaymentDataStore? { get }
}

class PaymentRouter: NSObject, PaymentRoutingLogic, PaymentDataPassing
{
    weak var viewController: PaymentViewController?
    var dataStore: PaymentDataStore?
    
    // MARK: Routing
    
    //func routeToSomewhere(segue: UIStoryboardSegue?)
    //{
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}
    
    // MARK: Navigation
    
    //func navigateToSomewhere(source: PaymentViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: PaymentDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}
