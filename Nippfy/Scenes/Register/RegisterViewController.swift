//
//  RegisterViewController.swift
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
import SKCountryPicker

protocol RegisterDisplayLogic: class
{
    func displaySomething(viewModel: Register.Something.ViewModel)
    func displayStatesLoadedForCountry(viewModel: Register.FetchStatesForCountry.ViewModel)
}

class RegisterViewController: UIViewController, RegisterDisplayLogic
{
    var interactor: RegisterBusinessLogic?
    var router: (NSObjectProtocol & RegisterRoutingLogic & RegisterDataPassing)?
    
    var myView = RegisterView()
    
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
        let interactor = RegisterInteractor()
        let presenter = RegisterPresenter()
        let router = RegisterRouter()
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
        fetchJSON()
        doSomething()
    }
    
    func fetchJSON() {
        fetchStatesForCountry(countryCode: "US")
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func doSomething()
    {
        let request = Register.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: Register.Something.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
}

// MARK: User Responses

extension RegisterViewController {
    
    func displayStatesLoadedForCountry(viewModel: Register.FetchStatesForCountry.ViewModel) {
        
        let states = viewModel.states
        
        for state in states {
            print(state.name)
        }
        
    }
}

// MARK: User Interactions

extension RegisterViewController {
    
    @objc func countryButtonPressed() {
        
        let countryController = CountryPickerWithSectionViewController.presentController(on: self) { [weak self] (country: Country) in
            
            guard let self = self else { return }
            
            let regionCode = country.countryCode
            
            let selectedCountry = SelectedCountry(flag: country.flag, name: country.countryName, countryCode: country.countryCode, dialingCode: country.dialingCode)
            
            self.myView.selectedCountry = selectedCountry
            
            self.fetchStatesForCountry(countryCode: regionCode)
        }
        
        // can customize the countryPicker here e.g font and color
        countryController.detailColor = UIColor(named: "Normal Words")!
        countryController.labelColor = UIColor(named: "Small Titles")!
        countryController.flagStyle = .circular
    }
    
    fileprivate func fetchStatesForCountry(countryCode: String) {
        let request = Register.FetchStatesForCountry.Request(countryCode: countryCode)
        interactor?.loadStatesForCountry(request: request)
    }
    
}

// MARK: Prepare View
extension RegisterViewController {
    
    fileprivate func prepareView() {
        view = myView
        
        prepareNavBar()
        prepareGestureRecognizers()
    }
    
    fileprivate func prepareGestureRecognizers() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(countryButtonPressed))
        myView.selectCountryButton.addGestureRecognizer(tap)
    }
    
    fileprivate func prepareNavBar() {
        view.backgroundColor = UIColor(named: "Background")
        title = "Nippfy"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "Small Titles")]
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
    
}

