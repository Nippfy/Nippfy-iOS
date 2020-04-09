//
//  Repository.swift
//  Sexual Yathzee
//
//  Created by Manuel Salvador del Águila on 19/01/2020.
//  Copyright © 2020 Manuel Salvador del Águila. All rights reserved.
//

import Foundation

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}

import Firebase
import Alamofire

class Repository {
    
    // Services
    let authService = AuthService.getInstance()
    let statesAndCountryService = StatesAndCountryService.getInstance()
    let braintreeService = BraintreeService.getInstance()
    let databaseService = DatabaseService.getInstance()
    
    let database = Firestore.firestore()
    let credentials = Credentials()
    
    private var accessTokenAPI: String = ""
    
    private var currentUser: CurrentUser?
    
    
    private static var INSTANCE: Repository?
    private init() {
        
    }
    
    public static func getInstance() -> Repository {
        if INSTANCE == nil {
            INSTANCE = Repository()
        }
        return INSTANCE!
    }
    
    // ------------------------------------------------------------ //
    // ------------------------------------------------------------ //
    // ------------------------------------------------------------ //
    
    // MARK: Auth Service
    func loginUser(request: Login.LoginButtonPressed.Request, error completion: @escaping(_ err: Error?) -> Void) {
        authService.loginUser(request: request) { (error) in
            completion(error)
        }
    }
    
    func logoutUser(completion: @escaping(() -> Void)) {
        authService.logoutUser {
            completion()
        }
    }
    
    public func sendEmailToRecoverPassword(request: ForgottenPassword.SendForgottenPasswordEmail.Request, completionHandler: @escaping(_ error: Error?) -> Void) {
        authService.sendEmailToRecoverPassword(request: request) { (error) in
            completionHandler(error)
        }
    }
    
    func checkIfUserIsLoggedIn(completion: @escaping((_ isLoggedIn: Bool) -> Void)) {
        authService.checkIfUserIsLoggedIn { (isLoggedIn) in
            completion(isLoggedIn)
        }
    }
    
    public func registerNewUser(_ request: Register.RegisterNewUser.Request, _ completionHandler: @escaping ((_ error: Error?) -> Void)) {
        authService.registerNewUser(request) { (error) in
            completionHandler(error)
        }
    }
    
    // ------------------------------------------------------------ //
    // ------------------------------------------------------------ //
    // ------------------------------------------------------------ //
    
    // MARK: States And Country Service
    public func fetchJSONAccessToken(completionHandler: @escaping (() -> Void)) {
        statesAndCountryService.fetchJSONAccessToken { (accessToken) in
            self.accessTokenAPI = accessToken
            completionHandler()
            print(accessToken)
        }
    }
    
    public func fetchStatesForCountry(countryCode: String, completionHandler: @escaping ((_ states: [State]) -> Void)) {
        statesAndCountryService.fetchStatesForCountry(accessTokenAPI: self.accessTokenAPI, countryCode: countryCode) { (states) in
            completionHandler(states)
            print(states.count)
        }
    }
    
    // ------------------------------------------------------------ //
    // ------------------------------------------------------------ //
    // ------------------------------------------------------------ //
    
    // MARK: Braintree Service
    public func getBraintreeToken(completionHandler:  @escaping ((_ error: Error? ,_ braintreeToken: String) -> Void)) {
        braintreeService.getBraintreeToken { (error, braintreeToken) in
            completionHandler(error, braintreeToken)
        }
    }
    
    public func performTransactionToWallet(nonce: String, amount: String, completionHandler: @escaping ((_ error: Error?, _ transaction: Transaction?) -> Void)) {
        braintreeService.performTransactionToWallet(currentUserWalletID: currentUser!.wallet!.walletID, nonce: nonce, amount: amount) { (error, transaction) in
            completionHandler(error, transaction)
        }
    }
    
    // ------------------------------------------------------------ //
    // ------------------------------------------------------------ //
    // ------------------------------------------------------------ //
    
    // MARK: Database Service
    public func saveTransactionToDatabase(transaction: Transaction, completionHandler: @escaping ((_ error: Error?) -> Void)) {
        databaseService.saveTransactionToDatabase(transaction: transaction) { (error) in
            completionHandler(error)
        }
    }
    
    public func updateUserWalletID(forUserID: String, withWalletID: String, completionHandler: @escaping ((_ error: Error?) -> Void)) {
        databaseService.updateUserWalletID(forUserID: forUserID, withWalletID: withWalletID) { (error) in
            completionHandler(error)
        }
    }
    
    public func saveUserToDatabase(user: UserToRegister, completionHandler: @escaping ((_ error: Error?, _ userID: String) -> Void)) {
        databaseService.saveUserToDatabase(user: user) { (error, userID) in
            completionHandler(error, userID)
        }
    }
    
    public func createWalletForUser(forUserID: String,  amount: String, completionHandler: @escaping ((_ error: Error?, _ walletID: String) -> Void)) {
        databaseService.createWalletForUser(forUserID: forUserID, amount: amount) { (error, walletID) in
            completionHandler(error, walletID)
        }
    }
    
    public func addMoneyToUserAndNippfyWallet(transaction: Transaction, completionHandler: @escaping ((_ error: Error?) -> Void)) {
        databaseService.addMoneyToUserAndNippfyWallet(currentUser: self.currentUser!, transaction: transaction) { (error) in
            completionHandler(error)
        }
    }
    
    public func getCurrentUser(completionHandler: @escaping(_ currentUser: CurrentUser) -> Void) {
        databaseService.getCurrentUser { (currentUser) in
            self.currentUser = currentUser
            completionHandler(currentUser)
        }
    }
    
    public func getTransactionsForUser(walletID: String, completionHandler: @escaping(_ error: Error?, _ userTransactions: [Transaction]?)-> Void) {
        databaseService.getTransactionsForUser(walletID: walletID) { (error, transactions) in
            completionHandler(error, transactions)
        }
    }
    
}
