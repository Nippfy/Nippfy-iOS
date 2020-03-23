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

class Repository {
    
    let credentials = Credentials()
    
    private var accessTokenAPI: String = ""
    
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
                    
                    print(self.accessTokenAPI)
                    
                    completionHandler()

                } catch let jsonErr {
                    print("Failed to decode: \(jsonErr)")
                }
            }
            
        }.resume()
    }
    
    // MARK: Fetch States For Country when user is registering
    public func fetchStatesForCountry(countryCode: String, completionHandler: @escaping ((_ states: [State]) -> Void)) {
        
        let locale = Locale(identifier: "en")
        guard let localisedCountryName = locale.localizedString(forRegionCode: countryCode) else {
            let message = "Failed to localised country name for Country Code:- \("regionCode")"
            fatalError(message)
        }
        
        let sanitazedString = localisedCountryName.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
    
        let urlString = "https://www.universal-tutorial.com/api/states/\(sanitazedString)"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.setValue("Bearer " + accessTokenAPI, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                if let error = error {
                    print("Failed to get data from url \(error)")
                    return
                }
                
                guard let data = data else { return }
                
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
    
}
