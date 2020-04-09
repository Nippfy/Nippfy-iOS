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
    private var userTransactions: [Transaction] = [Transaction]()
    
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
        braintreeService.performTransactionToWallet(currentUserWalletID: currentUser!.wallet.walletID, nonce: nonce, amount: amount) { (error, transaction) in
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
    
    public func addMoneyToUserAndNippfyWallet(transaction: Transaction, completionHandler: @escaping ((_ error: Error?) -> Void)) {
        
        let userWalletRef = database.collection("wallets").document(currentUser!.wallet.walletID)
        
        let transactionAmount = Float(transaction.amount)!
        let currentUserAmount = Float(currentUser!.wallet.amount)!
        
        let userBalanceAfterMoneyAdded = Float(transactionAmount + currentUserAmount)
        print("User Balance after money added \(userBalanceAfterMoneyAdded)")
        
        // Update user Wallet
        userWalletRef.setData([
            "balance" : String(format: "%.2f", userBalanceAfterMoneyAdded)
            ], merge: true, completion: { (error) in
                
                // Si hay error
                if let error = error {
                    completionHandler(error)
                    return
                } else {
                    
                    // Get Nippfy Current Wallet Amount of Money
                    let nippfyWalletRef = self.database.collection("wallets").document("0")
                    nippfyWalletRef.getDocument { (document, error) in
                        if let error = error {
                            completionHandler(error)
                            return
                        }
                        
                        let nippfyAmount = document?.get("balance") as! String
                        let nippfyAmountFloat = Float(nippfyAmount)!
                        let nippfyAmountAfterMoneyAdded = Float(nippfyAmountFloat + transactionAmount)
                        
                        nippfyWalletRef.setData([
                            "balance" : String(format: "%.2f", nippfyAmountAfterMoneyAdded)
                        ]) { (error) in
                            if let error = error {
                                completionHandler(error)
                            } else {
                                completionHandler(nil)
                            }
                        }
                    }
                }
        })
    }
    
    // MARK: Create New User
    
    public func saveUserToDatabase(user: UserToRegister, completionHandler: @escaping ((_ error: Error?, _ userID: String) -> Void)) {
        databaseService.saveUserToDatabase(user: user) { (error, userID) in
            completionHandler(error, userID)
        }
    }
    
    
    public func createWalletForUser(forUserID: String,  amount: String, completionHandler: @escaping ((_ error: Error?, _ walletID: String) -> Void)) {
        
        let newDocument = database.collection("wallets").document()
        let walletID = newDocument.documentID
        
        print("Amount to save in wallet when creating user \(amount)")
        
        newDocument.setData([
            "uid" : walletID,
            "balance" : amount
        ], merge: true) { (error) in
            
            if (error != nil) {
                print(error!)
                completionHandler(error, "")
                return
            }
            
            print("Wallet creado con éxito")
            completionHandler(nil, walletID)
            // Update the user walletID
            
            // self.updateUserWalletID(forUserID: forUserID, withWalletID: walletID, completionHandler: completionHandler)
        }
    }
    
    public func updateUserWalletID(forUserID: String, withWalletID: String, completionHandler: @escaping ((_ error: Error?) -> Void)) {
        
        let user1 = database.collection("users").document(forUserID)
        
        user1.setData([
            "walletID" : withWalletID
        ], merge: true) { (error) in
            if let error = error {
                completionHandler(error)
                return
            }
            
            completionHandler(nil)
        }
    }
    
    
    
    
    
    
    
    
    public func getCurrentUser(completionHandler: @escaping(_ currentUser: CurrentUser) -> Void) {
        
        let userEmail = Auth.auth().currentUser!.email!
        print("User Email " + userEmail)
        
        let users = database.collection("users").whereField("email", isEqualTo: userEmail).limit(to: 1)
        
        users.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    let uid = document.get("uid") as! String
                    let walletID = document.get("walletID") as! String
                    let name = document.get("name") as! String
                    let country = document.get("country") as! String
                    let email = document.get("email") as! String
                    let surname = document.get("surname") as! String
                    let telephone = document.get("telephone") as! String
                    
                    let wallet = self.database.collection("wallets").document(walletID)
                    
                    wallet.getDocument { (document, error) in
                        if let document = document, document.exists {
                            
                            let amount = document.get("balance") as! String
                            let userWallet = UserWallet(walletID: walletID, amount: String(amount))
                            
                            self.currentUser = CurrentUser(uid: uid, wallet: userWallet, name: name, surname: surname, email: email, country: country, telephone: telephone)
                            print(self.currentUser!)
                            completionHandler(self.currentUser!)
                        } else {
                            print("Document does not exist")
                        }
                    }
                }
            }
        }
    }
    
    public func getTransactionsForUser(userUID: String, completionHandler: @escaping(_ error: Error?, _ userTransactions: [Transaction]?)-> Void) {
        
        let transactionsRef = database.collection("transactions").whereField("walletID_Tx", isEqualTo: userUID)
        transactionsRef.getDocuments { (snapshot, error) in
            if let error = error {
                completionHandler(error, nil)
                return
            } else {
                self.userTransactions.removeAll()
                
                for document in snapshot!.documents {
                    
                    // let uid = document.get("uid") as! String
                    let walletID_Rx = document.get("walletID_Rx") as! String
                    let walletID_Tx = document.get("walletID_Tx") as! String
                    let transactionID = document.get("transactionID") as! String
                    let amount = document.get("amount") as! String
                    let currencyCode = document.get("currencyCode") as! String
                    let timestamp = document.get("timestamp") as! String
                    
                    let transaction = Transaction(transactionID: transactionID, walletID_Rx: walletID_Rx, walletID_Tx: walletID_Tx, timestamp: timestamp, amount: amount, currencyCode: currencyCode, message: nil)
                    self.userTransactions.append(transaction)
                }
                
                completionHandler(nil, self.userTransactions)
                
            }
        }
    }
    
}
