//
//  AddCreditInteractor.swift
//  Nippfy
//
//  Created by Manuel Salvador del Águila on 20/03/2020.
//  Copyright (c) 2020 Manuel Salvador del Águila. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol AddCreditBusinessLogic
{
    func doSomething(request: AddCredit.Something.Request)
}

protocol AddCreditDataStore
{
    //var name: String { get set }
}

class AddCreditInteractor: AddCreditBusinessLogic, AddCreditDataStore
{
    var presenter: AddCreditPresentationLogic?
    var worker: AddCreditWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: AddCredit.Something.Request)
    {
        worker = AddCreditWorker()
        worker?.doSomeWork()
        
        let response = AddCredit.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
