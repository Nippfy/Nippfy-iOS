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
    func displayForgottenPasswordEmailSent(viewModel: ForgottenPassword.SendForgottenPasswordEmail.ViewModel)
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

// MARK: Prepare View
extension ForgottenPasswordViewController {
    
    fileprivate func prepareNavBar() {
        view.backgroundColor = UIColor(named: "Background")
        title = "Nippfy"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "Small Titles")!]
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        
        prepareGestureRecognizers()
    }
    
    fileprivate func prepareGestureRecognizers() {
        myView.sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
    }
    
}

// MARK: User Interactions

extension ForgottenPasswordViewController {
    
    
    @objc func sendButtonTapped() {
        
        if (checkForgottenPasswordParameters()) {
            sendResetEmail()
        } else {
            showInvalidEmailAlert()
        }
    }
    
    private func sendResetEmail() {
        
        myView.showActivityIndicator()
        
        guard let email = myView.emailTextField.text else { return }
        
        let request = ForgottenPassword.SendForgottenPasswordEmail.Request(email: email)
        interactor?.sendResetPasswordEmail(request: request)
    }
    
    fileprivate func checkForgottenPasswordParameters() -> Bool {
        
        guard let email = myView.emailTextField.text else { return false }
        
        if (!email.isEmail()) {
            showInvalidEmailAlert()
            return false
        }
        
        if (email.isEmpty) {
            return false
        }
        return true
    }
}


// MARK: User Response

extension ForgottenPasswordViewController {
    
    func displayForgottenPasswordEmailSent(viewModel: ForgottenPassword.SendForgottenPasswordEmail.ViewModel) {
        
        myView.hideActivityIndicator()
        
        let error = viewModel.error
        
        if let error = error {
            showErrorWhileSendingEmailAlert(error: error.localizedDescription)
        } else {
            showEmailSuccessfulySentAlert()
        }
    }
    
    fileprivate func showEmailSuccessfulySentAlert() {
        
        let alertController = UIAlertController(title: "Email sent succesfully", message: "Please check your email to reset your password", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "Dismiss", style: .default) { (a) in
            
        }
        
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    fileprivate func showErrorWhileSendingEmailAlert(error: String) {
        
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "Dismiss", style: .default) { (a) in
            
        }
        
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    fileprivate func showInvalidEmailAlert() {
        
        let alertController = UIAlertController(title: "Invalid Email", message: "Please type a valid email address", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "Dismiss", style: .default) { (a) in
            
        }
        
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
