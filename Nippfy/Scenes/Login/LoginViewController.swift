//
//  LoginViewController.swift
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

protocol LoginDisplayLogic: class
{
    func displaySomething(viewModel: Login.Something.ViewModel)
    func displayLoginButtonPressed(viewModel: Login.LoginButtonPressed.ViewModel)
}

class LoginViewController: UIViewController, LoginDisplayLogic
{
    var interactor: LoginBusinessLogic?
    var router: (NSObjectProtocol & LoginRoutingLogic & LoginDataPassing)?
    
    var myView = LoginView()
    
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
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
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
        prepareView()
        doSomething()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        // Personalize the back button between scenes
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = UIColor(named: "Small Titles")
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func doSomething()
    {
        let request = Login.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: Login.Something.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
}

extension LoginViewController {
    
    func prepareView() {
        view.backgroundColor = UIColor(named: "Background")
        title = "Nippfy"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if #available(iOS 13.0, *) {
            isModalInPresentation = true
        } else {
            // Fallback on earlier versions
        }
        
        // self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "Small Titles")!]
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        
        self.navigationController?.navigationBar.backItem?.title = "Custom"
        
        prepareButtonsActions()
    }
    
    func prepareButtonsActions() {
        myView.createAccountButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        myView.forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
        myView.signInButton.addTarget(self, action: #selector(sigInButtonTapped), for: .touchUpInside)
    }
    
}

// MARK: User Interactions
extension LoginViewController {
    
    @objc func registerButtonTapped() {
        print("REGISTER TAPPED")
        router?.routeRegisterScene()
    }
    
    @objc func forgotPasswordButtonTapped() {
        print("FORGOT PASSWORD TAPPED")
        router?.routeForgotPasswordScene()
    }
    
    @objc func sigInButtonTapped() {
        print("SIGN IN TAPPED")
        
        guard let email = myView.emailTextField.text else { return }
        guard let password = myView.passwordTextField.text else { return }
        
        myView.showActivityIndicator()
        
        let request = Login.LoginButtonPressed.Request(email: email, password: password)
        interactor?.loginUser(request: request)
    }
}

// MARK: User Responses

extension LoginViewController {
    
    func displayLoginButtonPressed(viewModel: Login.LoginButtonPressed.ViewModel) {
        
        myView.hideActivityIndicator()
        
        let error = viewModel.error
        
        // There is an error
        if let error = error {
            let errorString = error.localizedDescription
            showErrorAlert(error: errorString)
            return
        }
        
        // Go to main
        
        print("Acceso garantizado con éxito")
        router?.routeToSearchScene()
        
        //dismiss(animated: true, completion: nil)
    }
    
    
    fileprivate func showErrorAlert(error: String) {
        
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "Dismiss", style: .default) { (a) in
            
        }
        
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
