//
//  AddCreditViewController.swift
//  Nippfy
//
//  Created by Manuel Salvador del Águila on 20/03/2020.
//  Copyright (c) 2020 Manuel Salvador del Águila. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol AddCreditDisplayLogic: class
{
    func displaySomething(viewModel: AddCredit.Something.ViewModel)
}

class AddCreditViewController: UIViewController, AddCreditDisplayLogic
{
    var interactor: AddCreditBusinessLogic?
    var router: (NSObjectProtocol & AddCreditRoutingLogic & AddCreditDataPassing)?
    
    var myView = AddCreditView()
    
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
        let interactor = AddCreditInteractor()
        let presenter = AddCreditPresenter()
        let router = AddCreditRouter()
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
        prepareView()
        doSomething()
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func doSomething()
    {
        let request = AddCredit.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: AddCredit.Something.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
}

// MARK: Prepare View
extension AddCreditViewController {
    
    func prepareView() {
        view = myView
        
        view.backgroundColor = UIColor(named: "Background")
        title = "Current Balance"
        
        prepareNavBar()
    }
    
    func prepareNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "Small Titles")]
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
    
    
}
