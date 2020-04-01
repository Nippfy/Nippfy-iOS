//
//  SearchModels.swift
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

enum Search
{
    // MARK: Use cases
    
    enum Something
    {
        struct Request
        {
        }
        struct Response
        {
        }
        struct ViewModel
        {
        }
    }
    
    enum IsUserLoggedIn
    {
        struct Request
        {
        }
        struct Response
        {
            var isLoggedIn: Bool
        }
        struct ViewModel
        {
            var isLoggedIn: Bool
        }
    }
}
