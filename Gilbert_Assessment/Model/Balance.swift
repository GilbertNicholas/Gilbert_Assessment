//
//  Response.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 12/03/22.
//

import Foundation

struct Balance: Codable {
    var status: String
    var accountNo: String?
    var balance: Double?
    var error: ErrorResponse?
}
