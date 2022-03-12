//
//  TransferViewModel.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 12/03/22.
//

import Foundation

class TransferViewModel {
    private let apiCall = APIDataSource.singleton
    
    func transfer(receipientAccountNo: String, amount: Double, description: String) {
        let body = apiCall.transferBody(receipientAccountNo: receipientAccountNo, amount: amount, description: description)
        apiCall.postData(type: .transfer, responseModel: Transfer.self, body: body)
    }
    
    func getPayees() {
        apiCall.requestData(type: .payees, responseModel: Payees.self)
    }
}
