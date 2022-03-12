//
//  Constants.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 11/03/22.
//

import Foundation

enum StateMenu {
    case opened
    case closed
}

enum MenuOptions: String, CaseIterable {
    case dashboard = "Dashboard"
    case transaction = "Your Transaction"
    case transfer = "Transfer"
    case logout = "Logout"

    var imageName: String {
        switch self {
        case .dashboard:
            return "house"
        case .transaction:
            return "list.bullet.rectangle.portrait"
        case .transfer:
            return "tray.and.arrow.up"
        case .logout:
            return "arrowshape.turn.up.left.2"
        }
    }
}

enum AuthType {
    case login
    case register
}

enum APIRequestType: String {
    case login = "login"
    case register = "register"
    case balance = "balance"
    case transactions = "transactions"
    case payees = "payees"
    case transfer = "transfer"
}

enum UserDefaultsType: String {
    case token = "token"
    case username = "username"
    case accNumber = "accNumber"
}

enum TransactionType: String {
    case transfer = "transfer"
    case received = "received"
}
