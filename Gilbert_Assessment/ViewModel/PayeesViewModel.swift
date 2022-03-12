//
//  PayeesViewModel.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 13/03/22.
//

import Foundation

class PayeesViewModel {
    private let apiCall = APIDataSource.singleton
    
    @Published var payeesData: [PayeesData] = []
    @Published var loadingStatus: Bool = false
    @Published var error: String = ""
    
    func getPayeesData() {
        self.loadingStatus = true
        apiCall.requestData(type: .payees, responseModel: Payees.self) { result in
            switch result {
            case .success(let payeesData):
                if let payeesData = payeesData.data {
                    self.payeesData = payeesData
                }
                
                if let error = payeesData.error?.message {
                    self.error = error
                }
            case .failure(let error):
                print("DebugError: \(error.localizedDescription)")
            }
            self.loadingStatus = false
        }
    }
}
