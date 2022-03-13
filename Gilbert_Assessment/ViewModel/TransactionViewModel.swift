//
//  TransactionViewModel.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 12/03/22.
//

import Foundation

class TransactionViewModel {
    private let apiCall = APIDataSource.singleton
    
    @Published var transactionData: [TranData] = []
    @Published var loadingStatus: Bool = false
    @Published var error: String = ""
    
    func getTransactionData() {
        loadingStatus = true
        apiCall.requestData(type: .transactions, responseModel: Transaction.self) { result in
            print("DEBUGTRAN: \(result)")
            switch result {
            case .success(let tranData):
                if let tranData = tranData.data {
                    self.transactionData = tranData
                }
                
                if let error = tranData.error {
                    self.error = error
                }
            case .failure(let error):
                print("DebugError: \(error.localizedDescription)")
            }
            self.loadingStatus = false
        }
    }
}
