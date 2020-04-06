//
//  ProfilePresenter.swift
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

protocol ProfilePresentationLogic
{
    func presentSomething(response: Profile.Something.Response)
    func presentLogoutButtonPressed(response: Profile.LogoutButtonPressed.Response)
}

class ProfilePresenter: ProfilePresentationLogic
{
    weak var viewController: ProfileDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: Profile.Something.Response)
    {
        let viewModel = Profile.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    func presentLogoutButtonPressed(response: Profile.LogoutButtonPressed.Response) {
        let viewModel = Profile.LogoutButtonPressed.ViewModel()
        viewController?.displayLogoutButtonPressed(viewModel: viewModel)
    }
}