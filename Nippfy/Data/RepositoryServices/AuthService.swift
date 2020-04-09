//
//  AuthService.swift
//  Nippfy
//
//  Created by Manuel Salvador del Águila on 08/04/2020.
//  Copyright © 2020 Manuel Salvador del Águila. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    
    private static var INSTANCE: AuthService?
    
    private init() {
        
    }
    
    public static func getInstance() -> AuthService {
        if INSTANCE == nil {
            INSTANCE = AuthService()
        }
        return INSTANCE!
    }
    
    // MARK: Login User
    func loginUser(request: Login.LoginButtonPressed.Request, completionHandler: @escaping(_ err: Error?) -> Void) {
        Auth.auth().signIn(withEmail: request.email, password: request.password) { (user, error) in
            
            if error != nil {
                completionHandler(error)
                return
            }
            completionHandler(nil)
        }
    }
    
    // MARK: Register User
    public func registerNewUser(_ request: Register.RegisterNewUser.Request, _ completionHandler: @escaping ((_ error: Error?) -> Void)) {
        
        let email = request.userToRegister.email
        let password = request.userToRegister.password
        
        // Create user with email and password
        Auth.auth().createUser(withEmail: email, password: password, completion: { (res, error) in
            
            if let error = error {
                print(error)
                completionHandler(error)
                return
            }
            
            completionHandler(nil)
        })
    }
    
    // MARK: Logout User
    func logoutUser(completionHandler: @escaping(() -> Void)) {
        do {
            try Auth.auth().signOut()
            completionHandler()
            return
        } catch let error {
            print(error)
        }
    }
    
    // MARK: Send Forgotten Password Email
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
    
    // MARK: Check if user is logged in
    func checkIfUserIsLoggedIn(completion: @escaping((_ isLoggedIn: Bool) -> Void)) {
        
        let uid = Auth.auth().currentUser?.uid
        
        if uid != nil {
            // User is logged in
            completion(true)
            return
        }
        completion(false)
    }
}
