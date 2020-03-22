//
//  RegisterInteractor.swift
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

protocol RegisterBusinessLogic
{
    func doSomething(request: Register.Something.Request)
    func loadStatesForCountry(request: Register.FetchStatesForCountry.Request)
}

protocol RegisterDataStore
{
    //var name: String { get set }
}

class RegisterInteractor: RegisterBusinessLogic, RegisterDataStore
{
    
    var presenter: RegisterPresentationLogic?
    var worker: RegisterWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: Register.Something.Request)
    {
        worker = RegisterWorker()
        worker?.doSomeWork()
        
        let response = Register.Something.Response()
        presenter?.presentSomething(response: response)
    }
    
    func loadStatesForCountry(request: Register.FetchStatesForCountry.Request) {
        worker = RegisterWorker()
        worker?.fetchStatesForCountry(request: request, completionHandler: { [weak self] (states) in
            
            let response = Register.FetchStatesForCountry.Response(states: states)
            self?.presenter?.presentLoadedStatesForCountry(response: response)
            
        })
        
    }
}
