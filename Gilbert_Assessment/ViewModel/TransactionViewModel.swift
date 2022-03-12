//
//  TransactionViewModel.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 12/03/22.
//

import Foundation

class TransactionViewModel {
    private let apiCall = APIDataSource.singleton
    
    func getTransactionData() {
        apiCall.requestData(type: .transactions, responseModel: Transaction.self) { result in
            
        }
    }
}
