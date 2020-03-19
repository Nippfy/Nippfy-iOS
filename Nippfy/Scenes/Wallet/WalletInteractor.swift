//
//  WalletInteractor.swift
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

protocol WalletBusinessLogic
{
    func doSomething(request: Wallet.Something.Request)
}

protocol WalletDataStore
{
    //var name: String { get set }
}

class WalletInteractor: WalletBusinessLogic, WalletDataStore
{
    var presenter: WalletPresentationLogic?
    var worker: WalletWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: Wallet.Something.Request)
    {
        worker = WalletWorker()
        worker?.doSomeWork()
        
        let response = Wallet.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
