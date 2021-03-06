//
//  State.swift
//  Nippfy
//
//  Created by Manuel Salvador del Águila on 22/03/2020.
//  Copyright © 2020 Manuel Salvador del Águila. All rights reserved.
//

import Foundation
import UIKit

struct Transaction {
    
    var transactionID: String
    var walletID_Rx: String
    var walletID_Tx: String
    var timestamp: String
    var amount: String
    var currencyCode: String
    var currencySymbol: String
    var message: String?
    var userRx: CurrentUser?
    var userTx: CurrentUser?
    
}
