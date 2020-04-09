//
//  StatesAndCountryService.swift
//  Nippfy
//
//  Created by Manuel Salvador del Águila on 08/04/2020.
//  Copyright © 2020 Manuel Salvador del Águila. All rights reserved.
//

import Foundation
class StatesAndCountryService {
    
    private static var INSTANCE: StatesAndCountryService?
    
    let credentials = Credentials()
    var states = [State]()
    
    private init() {
        
    }
    
    public static func getInstance() -> StatesAndCountryService {
        if INSTANCE == nil {
            INSTANCE = StatesAndCountryService()
        }
        return INSTANCE!
    }
    
    // MARK: Get JSON Access Token
    public func fetchJSONAccessToken(completionHandler: @escaping ((_ accessToken: String) -> Void)) {
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
                    
                    completionHandler(accessToken)
                    
                } catch let jsonErr {
                    print("Failed to decode: \(jsonErr)")
                }
            }
            
        }.resume()
    }
    
    // MARK: Fetch States For Country when user is registering
    public func fetchStatesForCountry(accessTokenAPI: String, countryCode: String, completionHandler: @escaping ((_ states: [State]) -> Void)) {
        
        print("Fetching states for country code \(countryCode) \(accessTokenAPI)")
        
        let locale = Locale(identifier: "en")
        guard let localisedCountryName = locale.localizedString(forRegionCode: countryCode) else {
            let message = "Failed to localised country name for Country Code:- \(countryCode)"
            fatalError(message)
        }
        
        let sanitazedString = localisedCountryName.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        
        let urlString = "https://www.universal-tutorial.com/api/states/\(sanitazedString)"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.setValue(UUID().uuidString + " " + accessTokenAPI, forHTTPHeaderField: "Authorization")
        
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
}
