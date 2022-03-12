//
//  DashboardViewModel.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 12/03/22.
//

import Foundation

class DashboardViewModel {
    private let apiCall = APIDataSource.singleton
    
    func getBalance() {
        apiCall.requestData(type: .balance, responseModel: Balance.self) { result in
            
        }
    }
}
