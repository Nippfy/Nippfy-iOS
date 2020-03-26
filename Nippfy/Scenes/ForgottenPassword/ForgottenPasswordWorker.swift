//
//  ForgottenPasswordWorker.swift
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

class ForgottenPasswordWorker
{
    
    var repository = Repository.getInstance()
    
    func doSomeWork()
    {
    }
    
    public func sendEmailToRecoverPassword(request: ForgottenPassword.SendForgottenPasswordEmail.Request, completionHandler: @escaping(_ error: Error?) -> Void) {
        
        repository.sendEmailToRecoverPassword(request: request) { (error) in
            completionHandler(error)
        }
        
    }
}
