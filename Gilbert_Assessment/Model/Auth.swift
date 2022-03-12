//
//  Auth.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 12/03/22.
//

import Foundation

struct Auth: Codable {
    let status: String
    let token: String?
    let username: String?
    let accountNo: String?
}
