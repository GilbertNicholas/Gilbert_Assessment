//
//  Transfer.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 12/03/22.
//

import Foundation

struct Transfer: Codable {
    let status: String
    let transactionId: String?
    let amount: Double
    let description: String?
    let reicipentAccount: String?
    let error: String?
}
