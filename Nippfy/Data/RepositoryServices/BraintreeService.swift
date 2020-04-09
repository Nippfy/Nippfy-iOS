//
//  BraintreeService.swift
//  Nippfy
//
//  Created by Manuel Salvador del Águila on 08/04/2020.
//  Copyright © 2020 Manuel Salvador del Águila. All rights reserved.
//

import Foundation
import Alamofire
class BraintreeService {
    
    private static var INSTANCE: BraintreeService?
    
    private init() {
        
    }
    
    public static func getInstance() -> BraintreeService {
        if INSTANCE == nil {
            INSTANCE = BraintreeService()
        }
        return INSTANCE!
    }
    
    // MARK: Get Braintree Token
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
    
    // MARK: Perform Transaction
    public func performTransactionToWallet(currentUserWalletID: String, nonce: String, amount: String, completionHandler: @escaping ((_ error: Error?, _ transaction: Transaction?) -> Void)) {
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
                
                let transaction = Transaction(transactionID: transactionID, walletID_Rx: currentUserWalletID, walletID_Tx: currentUserWalletID, timestamp: timestamp, amount: amount, currencyCode: currencyIsoCode, message: nil)
                
                completionHandler(nil, transaction)
                return
            } catch let jsonErr {
                print("Failed to decode: \(jsonErr)")
                completionHandler(jsonErr, nil)
                return
            }
        }
    }
}
