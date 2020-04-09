//
//  DatabaseService.swift
//  Nippfy
//
//  Created by Manuel Salvador del Águila on 08/04/2020.
//  Copyright © 2020 Manuel Salvador del Águila. All rights reserved.
//

import Foundation
import Firebase

class DatabaseService {
    
    private static var INSTANCE: DatabaseService?
    
    let database = Firestore.firestore()
    
    private var currentUser: CurrentUser?
    private var userTransactions: [Transaction] = [Transaction]()
    
    private init() {
        
    }
    
    public static func getInstance() -> DatabaseService {
        if INSTANCE == nil {
            INSTANCE = DatabaseService()
        }
        return INSTANCE!
    }
    
    // MARK: Save Transaction To Database
    public func saveTransactionToDatabase(transaction: Transaction, completionHandler: @escaping ((_ error: Error?) -> Void)) {
        
        let transactionRef = database.collection("transactions").document()
        let transactionFirestoreID = transactionRef.documentID
        
        print("Amount to save to database after token received \(transaction.amount)")
        
        transactionRef.setData([
            "uid" : transactionFirestoreID,
            "transactionID" : transaction.transactionID,
            "walletID_Rx" : transaction.walletID_Rx,
            "walletID_Tx" : transaction.walletID_Tx,
            "timestamp" : transaction.timestamp,
            "amount" : transaction.amount,
            "currencyCode" : transaction.currencyCode,
            "message" : ""
        ]) { (error) in
            
            if let error = error {
                completionHandler(error)
                return
            } else {
                completionHandler(nil)
            }
        }
    }
    
    // MARK: Create New User
    public func saveUserToDatabase(user: UserToRegister, completionHandler: @escaping ((_ error: Error?, _ userID: String) -> Void)) {
        
        let newDocument = database.collection("users").document()
        let userID = newDocument.documentID
        
        newDocument.setData([
            "uid" : userID,
            "name" : user.name,
            "surname" : user.surname,
            "telephone" : user.phoneNumber,
            "email" : user.email.lowercased(),
            "country" : user.country,
            "state" : user.state,
            "pictureURL" : "",
            "role" : "user",
            "walletID" : ""
        ], merge: true) { (error) in
            
            if (error != nil) {
                print(error!)
                completionHandler(error, "")
                return
            }
            
            print("Usuario guardado con éxito")
            
            // Crear el Wallet para el usuario
            completionHandler(nil, userID)
        }
    }
    
    // MARK: Create Wallet for User
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
            
            // Actualizar el Wallet del Usuario
            completionHandler(nil, walletID)
        }
    }
    
    // MARK: Update User Wallet ID After Creation
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
    
    // MARK: Add Money To User And Nippfy Wallet After Transaction
    public func addMoneyToUserAndNippfyWallet(currentUser: CurrentUser, transaction: Transaction, completionHandler: @escaping ((_ error: Error?) -> Void)) {
        
        let userWalletRef = database.collection("wallets").document(currentUser.wallet!.walletID)
        
        let transactionAmount = Float(transaction.amount)!
        let currentUserAmount = Float(currentUser.wallet!.amount)!
        
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
    
    // MARK: Get Current User
    
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
    
    // MARK: Get user with WalletID
    
    public func getUserWithEmail(walletID: String ,completionHandler: @escaping(_ currentUser: CurrentUser) -> Void) {
        
        let users = database.collection("users").whereField("walletID", isEqualTo: walletID).limit(to: 1)
        
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
                    
                    let currentUser = CurrentUser(uid: uid, name: name, surname: surname, email: email, country: country, telephone: telephone)
                    completionHandler(currentUser)
                }
            }
        }
    }
    
    // MARK: Get Transaction For User
    
    public func getTransactionsForUser(walletID: String, completionHandler: @escaping(_ error: Error?, _ userTransactions: [Transaction]?)-> Void) {
        
        self.userTransactions.removeAll()
        
        // 1. Cojo todas las transacciones donde el usuario ha enviado
        getSentTransactionsForUser(walletID: walletID) { [weak self] (error, transactions) in
            if (error != nil) {
                completionHandler(error, nil)
                return
            }
            
            // 2. Cojo todas las transacciones donde el usuario ha recibido
            self?.getReceivedTransactionsForUser(walletID: walletID) { (error, transactions) in
                if (error != nil) {
                    completionHandler(error, nil)
                    return
                }
                completionHandler(nil, self?.userTransactions)
            }
        }
    }
    
    // MARK: Get Sent Transactions For User
    private func getSentTransactionsForUser(walletID: String, completionHandler: @escaping(_ error: Error?, _ userTransactions: [Transaction]?)-> Void) {
        
        let transactionsRef = database.collection("transactions").whereField("walletID_Tx", isEqualTo: walletID)
        transactionsRef.getDocuments { (snapshot, error) in
            if let error = error {
                completionHandler(error, nil)
                return
            } else {
                // self.userTransactions.removeAll()
                
                for document in snapshot!.documents {
                    
                    // let uid = document.get("uid") as! String
                    let walletID_Rx = document.get("walletID_Rx") as! String
                    let walletID_Tx = document.get("walletID_Tx") as! String
                    let transactionID = document.get("transactionID") as! String
                    let amount = document.get("amount") as! String
                    let currencyCode = document.get("currencyCode") as! String
                    let timestamp = document.get("timestamp") as! String
                    
                    let currencySymbol = getSymbol(forCurrencyCode: currencyCode) == nil ? "$" : getSymbol(forCurrencyCode: currencyCode)
                    
                    var transaction = Transaction(transactionID: transactionID, walletID_Rx: walletID_Rx, walletID_Tx: walletID_Tx, timestamp: timestamp, amount: amount, currencyCode: currencyCode, currencySymbol: currencySymbol!, message: nil, userRx: nil, userTx: self.currentUser)
                    
                    
                    if (walletID_Tx == walletID_Rx) {
                        transaction.userRx = self.currentUser
                    } else {
                        self.findUserWithWalletID(walletID: walletID_Rx) { (error, userFound) in
                            if error != nil {
                                completionHandler(error, nil)
                                return
                            }
                            transaction.userRx = userFound
                        }
                    }
                    
                    print(transaction)
                    
                    if (!self.alreadyAdded(transactionID: transactionID)) {
                        self.userTransactions.append(transaction)
                    }
                }
                completionHandler(nil, self.userTransactions)
            }
        }
    }
    
    // MARK: Get Received Transactions For User
    private func getReceivedTransactionsForUser(walletID: String, completionHandler: @escaping(_ error: Error?, _ userTransactions: [Transaction]?)-> Void) {
        let transactionsRef = database.collection("transactions").whereField("walletID_Rx", isEqualTo: walletID)
        transactionsRef.getDocuments { (snapshot, error) in
            if let error = error {
                completionHandler(error, nil)
                return
            } else {
                // self.userTransactions.removeAll()
                
                for document in snapshot!.documents {
                    
                    // let uid = document.get("uid") as! String
                    let walletID_Rx = document.get("walletID_Rx") as! String
                    let walletID_Tx = document.get("walletID_Tx") as! String
                    let transactionID = document.get("transactionID") as! String
                    let amount = document.get("amount") as! String
                    let currencyCode = document.get("currencyCode") as! String
                    let timestamp = document.get("timestamp") as! String
                    
                    let currencySymbol = getSymbol(forCurrencyCode: currencyCode) == nil ? "$" : getSymbol(forCurrencyCode: currencyCode)
                    
                    var transaction = Transaction(transactionID: transactionID, walletID_Rx: walletID_Rx, walletID_Tx: walletID_Tx, timestamp: timestamp, amount: amount, currencyCode: currencyCode, currencySymbol: currencySymbol!, message: nil, userRx: self.currentUser, userTx: nil)
                    
                    if (walletID_Tx == walletID_Rx) {
                        transaction.userTx = self.currentUser
                    } else {
                        self.findUserWithWalletID(walletID: walletID_Tx) { (error, userFound) in
                            if error != nil {
                                completionHandler(error, nil)
                                return
                            }
                            transaction.userTx = userFound
                        }
                        
                    }
                    
                    print(transaction)
                    if (!self.alreadyAdded(transactionID: transactionID)) {
                        self.userTransactions.append(transaction)
                    }
                }
                completionHandler(nil, self.userTransactions)
            }
        }
    }
    
    // MARK: Find user with Wallet ID
    func findUserWithWalletID(walletID: String, completionHandler: @escaping(_ error: Error?, _ userFound: CurrentUser?) -> Void) {
        database.collection("users").whereField("walletID", isEqualTo: walletID).limit(to: 1).getDocuments { (snapshot, error) in
            
            if error != nil {
                completionHandler(error, nil)
                return
            }
            
            for document in snapshot!.documents {
                let uid = document.get("uid") as! String
                let name = document.get("name") as! String
                let country = document.get("country") as! String
                let email = document.get("email") as! String
                let surname = document.get("surname") as! String
                let telephone = document.get("telephone") as! String
                
                let userFound = CurrentUser(uid: uid, wallet: nil, name: name, surname: surname, email: email, country: country, telephone: telephone)
                completionHandler(nil, userFound)
            }
        }
    }
    
    // MARK: Helper Method
    func alreadyAdded(transactionID: String) -> Bool {
        for transaction in userTransactions {
            if (transaction.transactionID == transactionID) {
                return true
            }
        }
        return false
    }
    
}
