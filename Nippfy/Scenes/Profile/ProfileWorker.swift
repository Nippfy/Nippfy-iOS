//
//  ProfileWorker.swift
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

class ProfileWorker
{
    
    var repository = Repository.getInstance()
    
    func doSomeWork()
    {
    }
    
    func logoutUser(completion: @escaping(() -> Void)) {
        repository.logoutUser {
            completion()
        }
    }
}
