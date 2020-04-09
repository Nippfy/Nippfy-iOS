//
//  Current User.swift
//  Nippfy
//
//  Created by Manuel Salvador del Águila on 06/04/2020.
//  Copyright © 2020 Manuel Salvador del Águila. All rights reserved.
//

import Foundation
import UIKit

struct CurrentUser {
    
    var uid: String
    var wallet: UserWallet
    var name: String
    var surname: String
    var email: String
    var country: String
    var telephone: String
    var currencySymbol = Locale.current.currencySymbol
    
}
