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
    public func createWalletForUser(forUserID: String,  amount: String, completionHandler: @escaping ((_ error: Error?) -> Void)) {
        
        let newDocument = database.collection("wallets").document()
        let walletID = newDocument.documentID
        
        print("Amount to save in wallet when creating user \(amount)")
        
        newDocument.setData([
            "uid" : walletID,
            "balance" : amount
        ], merge: true) { (error) in
            
            if (error != nil) {
                print(error!)
                completionHandler(error)
                return
            }
            
            print("Wallet creado con éxito")
            
            // Update the user walletID
            
            // self.updateUserWalletID(forUserID: forUserID, withWalletID: walletID, completionHandler: completionHandler)
        }
    }
}
