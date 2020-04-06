//
//  WalletPresenter.swift
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

protocol WalletPresentationLogic
{
    func presentSomething(response: Wallet.Something.Response)
    func presentBraintreeToken(response: Wallet.GetBraintreeToken.Response)
    func presentPerformTransaction(response: Wallet.PerformTransaction.Response)
}

class WalletPresenter: WalletPresentationLogic
{
    weak var viewController: WalletDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: Wallet.Something.Response)
    {
        let viewModel = Wallet.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    func presentBraintreeToken(response: Wallet.GetBraintreeToken.Response) {
        let viewModel = Wallet.GetBraintreeToken.ViewModel(error: response.error, token: response.token)
        viewController?.displayBraintreeToken(viewModel: viewModel)
    }
    
    func presentPerformTransaction(response: Wallet.PerformTransaction.Response) {
        let viewModel = Wallet.PerformTransaction.ViewModel(error: response.error)
        viewController?.displayPerformTransaction(viewModel: viewModel)
    }
}
