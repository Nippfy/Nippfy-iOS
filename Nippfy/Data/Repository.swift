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
    
    let database = Firestore.firestore()
    let credentials = Credentials()
    
    private var accessTokenAPI: String = ""
    
    private var currentUser: CurrentUser?
    
    private static var INSTANCE: Repository?
    
    var states: [State] = [State]()
    
    private init() {
        
    }
    
    public static func getInstance() -> Repository {
        if INSTANCE == nil {
            INSTANCE = Repository()
        }
        return INSTANCE!
    }
    
    // MARK: Fetch JSON Access Token to fetch countries from API
    
    public func fetchJSONAccessToken(completionHandler: @escaping (() -> Void)) {
        let urlString = "https://www.universal-tutorial.com/api/getaccesstoken"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(credentials.cityStateCountryAPIToken, forHTTPHeaderField: "api-token")
        request.setValue(credentials.emailAPI, forHTTPHeaderField: "user-email")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                if let error = error {
                    print("Failed to get data from url \(error)")
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    
                    let webResponse = try decoder.decode(JsonDecodeAccessToken.self, from: data)
                    guard let accessToken = webResponse.auth_token else { return }
                    self.accessTokenAPI = accessToken
                    
                    // print("Auth Token " + self.accessTokenAPI)
                    
                    completionHandler()
                    
                } catch let jsonErr {
                    print("Failed to decode: \(jsonErr)")
                }
            }
            
        }.resume()
    }
    
    // MARK: Get Braintree Token for transaction
    
    public func getBraintreeToken(completionHandler:  @escaping ((_ error: Error? ,_ braintreeToken: String) -> Void)) {
        
        let urlString = "https://nippfyserver.herokuapp.com/get_token"
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                if let error = error {
                    print("Failed to get data from url \(error)")
                    return
                }
                
                guard let data = data else { return }
                
                print(data)
                
                do {
                    let decoder = JSONDecoder()
                    
                    let webResponse = try decoder.decode(JsonDecodeClientTokenBraintree.self, from: data)
                    
                    let clientToken = webResponse.clientToken
                    
                    print("CLIENT TOKEN \(clientToken)")
                    
                    completionHandler(nil, clientToken)
                    
                } catch let jsonErr {
                    print("Failed to decode: \(jsonErr)")
                    
                    completionHandler(error, "")
                }
            }
        }.resume()
    }
    
    // MARK: Add Money to Wallet
    public func performTransactionToWallet(nonce: String, amount: String, completionHandler: @escaping ((_ error: Error?, _ transaction: Transaction?) -> Void)) {
        let parameters: [String: Any] = [
            "payment_method_nonce" : nonce,
            "amount" : amount,
        ]
        
        let urlString = "https://nippfyserver.herokuapp.com/pay"
        
        AF.request(urlString, method: .post, parameters: parameters).responseData { (response) in
            print("Transaction completed")
            print(response)
            
            guard let data = response.data else { return }
            
            do {
                let decoder = JSONDecoder()
                
                let webResponse = try decoder.decode(JsonDecodeTransactionReceipt.self, from: data)
                
                print(webResponse)
                
                let transactionID = webResponse.transaction.id
                let currencyIsoCode = webResponse.transaction.currencyIsoCode
                let amount = webResponse.transaction.amount
                let timestamp = webResponse.transaction.createdAt
                
                let transaction = Transaction(transactionID: transactionID, walletID_Rx: (self.currentUser!.wallet.walletID), walletID_Tx: self.currentUser!.wallet.walletID, timestamp: timestamp, amount: amount, currencyCode: currencyIsoCode, message: nil)
                
                completionHandler(nil, transaction)
                return 
            } catch let jsonErr {
                print("Failed to decode: \(jsonErr)")
                completionHandler(jsonErr, nil)
                return
            }
        }
    }
    
    public func saveTransactionToDatabase(transaction: Transaction, completionHandler: @escaping ((_ error: Error?) -> Void)) {
        
        let transactionRef = database.collection("transactions").document()
        let transactionFirestoreID = transactionRef.documentID
        
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
    
    public func addMoneyToUserAndNippfyWallet(transaction: Transaction, completionHandler: @escaping ((_ error: Error?) -> Void)) {
        
        let userWalletRef = database.collection("wallets").document(currentUser!.wallet.walletID)
        
        let transactionAmount = Float(transaction.amount)!
        let currentUserAmount = Float(currentUser!.wallet.amount)
        
        let userBalanceAfterMoneyAdded = transactionAmount + currentUserAmount
        
        // Update user Wallet
        userWalletRef.setData([
            "balance" : userBalanceAfterMoneyAdded
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
                        
                        let nippfyAmount = document?.get("balance") as! Float
                        let nippfyAmountAfterMoneyAdded = nippfyAmount + transactionAmount
                        
                        nippfyWalletRef.setData([
                            "balance" : nippfyAmountAfterMoneyAdded
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
    
    // MARK: Fetch States For Country when user is registering
    public func fetchStatesForCountry(countryCode: String, completionHandler: @escaping ((_ states: [State]) -> Void)) {
        
        let locale = Locale(identifier: "en")
        guard let localisedCountryName = locale.localizedString(forRegionCode: countryCode) else {
            let message = "Failed to localised country name for Country Code:- \(countryCode)"
            fatalError(message)
        }
        
        let sanitazedString = localisedCountryName.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        
        // print("Country \(sanitazedString)")
        let urlString = "https://www.universal-tutorial.com/api/states/\(sanitazedString)"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.setValue(UUID().uuidString + " " + self.accessTokenAPI, forHTTPHeaderField: "Authorization")
        // request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                if let error = error {
                    print("Failed to get data from url \(error)")
                    return
                }
                
                guard let data = data else { return }
                
                print(data)
                do {
                    let decoder = JSONDecoder()
                    
                    let cities = try decoder.decode(Array<JsonDecodeCity>.self, from: data)
                    
                    self.states.removeAll()
                    
                    for city in cities {
                        let state = State(name: city.state_name)
                        self.states.append(state)
                    }
                    
                    completionHandler(self.states)
                } catch let jsonErr {
                    print("Failed to decode: \(jsonErr)")
                }
            }
            
        }.resume()
    }
    
    
    // MARK: Create New User
    
    public func saveUserToDatabase(user: UserToRegister, completionHandler: @escaping ((_ error: Error?, _ isThereError: Bool) -> Void)) {
        
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
                completionHandler(error, true)
                return
            }
            
            print("Usuario guardado con éxito")
            // Crear el Wallet para el usuario
            
            self.createWalletForUser(forUserID: userID, amount: 0, completionHandler: completionHandler)
        }
    }
    
    private func createWalletForUser(forUserID: String,  amount: Int, completionHandler: @escaping ((_ error: Error?, _ isThereError: Bool) -> Void)) {
        
        let newDocument = database.collection("wallets").document()
        let walletID = newDocument.documentID
        
        newDocument.setData([
            "uid" : walletID,
            "balance" : amount
        ], merge: true) { (error) in
            
            if (error != nil) {
                print(error!)
                completionHandler(error, true)
                return
            }
            
            print("Wallet creado con éxito")
            
            // Update the user walletID
            
            self.updateUserWalletID(forUserID: forUserID, withWalletID: walletID, completionHandler: completionHandler)
        }
    }
    
    private func updateUserWalletID(forUserID: String, withWalletID: String, completionHandler: @escaping ((_ error: Error?, _ isThereError: Bool) -> Void)) {
        
        let user1 = database.collection("users").document(forUserID)
        
        user1.setData([
            "walletID" : withWalletID
        ], merge: true) { (error) in
            if let error = error {
                completionHandler(error, true)
                return
            }
            
            completionHandler(nil, false)
        }
    }
    
    public func registerNewUser(_ request: Register.RegisterNewUser.Request, _ completionHandler: @escaping ((_ error: Bool, _ errorMessage: Error?) -> Void)) {
        
        let email = request.userToRegister.email
        let password = request.userToRegister.password
        
        // 1. Create user with email and password
        Auth.auth().createUser(withEmail: email, password: password, completion: { (res, error) in
            
            if let error = error {
                print(error)
                completionHandler(true, error)
                return
            }
            
            completionHandler(false, nil)
        })
    }
    
    // MARK: Forgotten Password Email
    public func sendEmailToRecoverPassword(request: ForgottenPassword.SendForgottenPasswordEmail.Request, completionHandler: @escaping(_ error: Error?) -> Void) {
        
        let email = request.email
        
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            
            if let error = error {
                completionHandler(error)
                return
            }
            
            completionHandler(nil)
        }
    }
    
    // MARK: Login User
    
    func loginUser(request: Login.LoginButtonPressed.Request, error completion: @escaping(_ err: Error?) -> Void) {
        
        Auth.auth().signIn(withEmail: request.email, password: request.password) { (user, error) in
            
            if error != nil {
                completion(error)
                return
            }
            
            self.getCurrentUser(userEmail: user!.user.email!)
            // User Signed In Succesfully
            completion(nil)
        }
    }
    
    func checkIfUserIsLoggedIn(completion: @escaping((_ isLoggedIn: Bool) -> Void)) {
        
        let uid = Auth.auth().currentUser?.uid
        
        if uid != nil {
            // User is logged in
            self.getCurrentUser(userEmail: Auth.auth().currentUser!.email!)
            completion(true)
            return
        }
        completion(false)
    }
    
    func logoutUser(completion: @escaping(() -> Void)) {
        do {
            try Auth.auth().signOut()
            completion()
            return
        } catch let error {
            print(error)
        }
    }
    
    private func getCurrentUser(userEmail: String) {
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
                            
                            let amount = document.get("balance") as! Int
                            let userWallet = UserWallet(walletID: walletID, amount: Float(amount))
                            
                            self.currentUser = CurrentUser(uid: uid, wallet: userWallet, name: name, surname: surname, email: email, country: country, telephone: telephone)
                            print(self.currentUser!)
                        } else {
                            print("Document does not exist")
                        }
                    }
                }
            }
        }
    }
}
