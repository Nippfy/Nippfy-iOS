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
import PhoneNumberKit

protocol RegisterDisplayLogic: class
{
    func displayStatesLoadedForCountry(viewModel: Register.FetchStatesForCountry.ViewModel)
    func displayUserRegistered(viewModel: Register.RegisterNewUser.ViewModel)
}

class RegisterViewController: UIViewController, RegisterDisplayLogic
{
    var interactor: RegisterBusinessLogic?
    var router: (NSObjectProtocol & RegisterRoutingLogic & RegisterDataPassing)?
    
    var myView = RegisterView()
    
    var states: [State] = [State]()
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("VIEW WILL APPEAR")
        
        fetchJSON()
    }
    
    func fetchJSON() {
        let countryCode = myView.phoneTextField.currentRegion
        fetchStatesForCountry(countryCode: countryCode)
    }
}

// MARK: User Responses

extension RegisterViewController {
    
    func displayStatesLoadedForCountry(viewModel: Register.FetchStatesForCountry.ViewModel) {
        states.removeAll()
        states = viewModel.states
        myView.statePickerView.reloadAllComponents()
    }
    
    func displayUserRegistered(viewModel: Register.RegisterNewUser.ViewModel) {
        
        let isThereError = viewModel.isThereError
        
        myView.hideActivityIndicator()
        
        if (!isThereError) {
            print("Usuario registrado con éxito")
            showRegistrationSuccesfulAlert()
            
        } else {
            
            let errorMessage = viewModel.errorMessage
            
            showErrorWhileRegisteringAlert(error: errorMessage!.localizedDescription)
            print("Ha habido un problema al registrar el usuario")
        }
        
    }
}

// MARK: User Interactions

extension RegisterViewController {
    
    @objc func registerButtonTapped() {
        print("REGISTER TAPPED")
        
        // Everything is ok
        if (checkRegisterParameters()) {
            myView.showActivityIndicator()
            registerUser()
        }
            // Display error (A field is not completed)
        else {
            showFieldsNotCompletedAlert()
        }
        
    }
    
    fileprivate func registerUser() {
        
        // TODO: Hay que corregir el error de la API
        
        let stateSelectedIndex = myView.statePickerView.selectedRow(inComponent: 0)
        guard let stateSelected = states[stateSelectedIndex].name else { return }
        
        // let stateSelected = "Andalucia"
        
        guard let name = myView.nameTextField.text else { return }
        guard let surname = myView.surnameTextField.text else { return }
        guard let phoneNumber = myView.phoneTextField.text else { return }
        let country = myView.phoneTextField.currentRegion
        guard let email = myView.emailTextField.text else { return }
        guard let password = myView.passwordTextField.text else { return }
        
        let userToRegister = UserToRegister(name: name, surname: surname, phoneNumber: phoneNumber, country: country, state: stateSelected, email: email, password: password)
        
        let request = Register.RegisterNewUser.Request(userToRegister: userToRegister)
        interactor?.registerNewUser(request: request)
    }
    
    @objc func countryButtonPressed() {
        
        let countryController = CountryPickerWithSectionViewController.presentController(on: self) { [weak self] (country: Country) in
            
            guard let self = self else { return }
            
            let regionCode = country.countryCode
            
            let selectedCountry = SelectedCountry(flag: country.flag, name: country.countryName, countryCode: country.countryCode, dialingCode: country.dialingCode)
            
            self.myView.selectedCountry = selectedCountry
            
            self.myView.phoneTextField.defaultRegion = regionCode
            self.myView.phoneTextField.updatePlaceholder()
            
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

// MARK: UIPickerView Methods

extension RegisterViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return states.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let state = states[row].name!
        return NSAttributedString(string: state, attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Small Titles")!])
    }
    
}

// MARK: Prepare View
extension RegisterViewController {
    
    fileprivate func prepareView() {
        view = myView
        
        prepareNavBar()
        preparePickerView()
        prepareGestureRecognizers()
    }
    
    fileprivate func prepareGestureRecognizers() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(countryButtonPressed))
        myView.selectCountryButton.addGestureRecognizer(tap)
        
        myView.registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
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
    
    fileprivate func preparePickerView() {
        myView.statePickerView.delegate = self
        
        myView.statePickerView.dataSource = self
    }
    
}

// MARK: Checking Registration Parameters

extension RegisterViewController {
    
    fileprivate func showFieldsNotCompletedAlert() {
        
        let alertController = UIAlertController(title: "Fields not complete", message: "Make sure that all fields are complete before registering", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "Dismiss", style: .default) { (a) in
            
        }
        
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    fileprivate func checkRegisterParameters() -> Bool {
        
        guard let name = myView.nameTextField.text else { return false }
        guard let surname = myView.surnameTextField.text else { return false }
        guard let phoneNumber = myView.phoneTextField.text else { return false }
        // guard let country = myView.selectedCountry.name else { return false }
        guard let email = myView.emailTextField.text else { return false }
        guard let password = myView.passwordTextField.text else { return false }
        guard let repeatPassword = myView.repeatPasswordTextField.text else { return false }
        
        if (!email.isEmail()) {
            showInvalidEmailAlert()
            return false
        }
        
        if (name.isEmpty || surname.isEmpty || phoneNumber.isEmpty || email.isEmpty || password.isEmpty || repeatPassword.isEmpty) {
            return false
        } else if (password != repeatPassword) {
            return false
        }
        return true
    }
    
    fileprivate func showRegistrationSuccesfulAlert() {
        
        let alertController = UIAlertController(title: "Registration Successful", message: "You have been registered successfully", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "Dismiss", style: .default) { [weak self] (a) in
            self?.router?.routeLoginScene()
        }
        
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    fileprivate func showErrorWhileRegisteringAlert(error: String) {
        
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
