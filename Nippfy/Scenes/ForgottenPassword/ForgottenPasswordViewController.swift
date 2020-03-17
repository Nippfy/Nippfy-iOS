//
//  ForgottenPasswordViewController.swift
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

protocol ForgottenPasswordDisplayLogic: class
{
    func displaySomething(viewModel: ForgottenPassword.Something.ViewModel)
}

class ForgottenPasswordViewController: UIViewController, ForgottenPasswordDisplayLogic
{
    var interactor: ForgottenPasswordBusinessLogic?
    var router: (NSObjectProtocol & ForgottenPasswordRoutingLogic & ForgottenPasswordDataPassing)?
    
    var myView = ForgottenPasswordView()
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = ForgottenPasswordInteractor()
        let presenter = ForgottenPasswordPresenter()
        let router = ForgottenPasswordRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view = myView
        prepareNavBar()
        doSomething()
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func doSomething()
    {
        let request = ForgottenPassword.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: ForgottenPassword.Something.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
}

// Prepare NavBar
extension ForgottenPasswordViewController {
    
    fileprivate func prepareNavBar() {
        view.backgroundColor = UIColor(named: "Background")
        title = "Nippfy"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "Small Titles")]
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
    
}

