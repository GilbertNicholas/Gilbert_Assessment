//
//  Payees.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 12/03/22.
//

import Foundation

struct Payees: Codable {
    let status: String
    let data: PayeesData?
    let error: Error?
}

struct PayeesData: Codable {
    let id: String
    let name: String
    let accountNo: String
}
