//
//  JsonDecodeAccessToken.swift
//  Nippfy
//
//  Created by Manuel Salvador del Águila on 22/03/2020.
//  Copyright © 2020 Manuel Salvador del Águila. All rights reserved.
//

import Foundation
import UIKit

struct JsonDecodeTransactionReceipt: Decodable {
    let transaction: JsonDecodeTransaction
}
