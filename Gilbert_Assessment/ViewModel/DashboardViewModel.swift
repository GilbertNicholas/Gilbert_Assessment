//
//  DashboardViewModel.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 12/03/22.
//

import Foundation

class DashboardViewModel {
    private let apiCall = APIDataSource.singleton
    @Published var balance: Double = 0
    @Published var loadingStatus: Bool = false
    @Published var errorMsg: String = ""
    
    func getBalance() {
        loadingStatus = true
        apiCall.requestData(type: .balance, responseModel: Balance.self) { result in
            switch result {
            case .success(let balanceData):
                if let error = balanceData.error?.message {
                    self.errorMsg = error
                } else if let balance = balanceData.balance {
                    self.balance = balance
                }
            case .failure(let error):
                print("DebugError: \(error.localizedDescription)")
                self.errorMsg = error.localizedDescription
            }
            self.loadingStatus = false
        }
    }
}
