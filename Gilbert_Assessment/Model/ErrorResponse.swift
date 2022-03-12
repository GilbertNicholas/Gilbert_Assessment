//
//  ErrorResponse.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 12/03/22.
//

import Foundation

struct ErrorResponse: Codable {
    let name: String?
    let message: String?
    let expiredAt: String?
}
