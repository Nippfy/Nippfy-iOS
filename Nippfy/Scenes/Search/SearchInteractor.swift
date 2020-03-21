//
//  SearchInteractor.swift
//  Nippfy
//
//  Created by Manuel Salvador del Águila on 21/03/2020.
//  Copyright (c) 2020 Manuel Salvador del Águila. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SearchBusinessLogic
{
    func doSomething(request: Search.Something.Request)
}

protocol SearchDataStore
{
    //var name: String { get set }
}

class SearchInteractor: SearchBusinessLogic, SearchDataStore
{
    var presenter: SearchPresentationLogic?
    var worker: SearchWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: Search.Something.Request)
    {
        worker = SearchWorker()
        worker?.doSomeWork()
        
        let response = Search.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
