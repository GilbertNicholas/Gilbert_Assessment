//
//  TransferViewModel.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 12/03/22.
//

import Foundation

class TransferViewModel {
    private let apiCall = APIDataSource.singleton
    @Published var loadingStatus: Bool = false
    @Published var transferSuccess: Bool = false
    @Published var errorMessage: String = ""
    
    func transfer(receipientAccNo: String, amount: Double, desc: String) {
        self.loadingStatus = true
        let body = apiCall.transferBody(receipientAccountNo: receipientAccNo, amount: amount, description: desc)
        
        apiCall.postData(type: .transfer, responseModel: Transfer.self, body: body) { result in
            print("DebugTransfer: \(result)")
            switch result {
            case .success(let transferResp):
                if let error = transferResp.error {
                    self.transferSuccess = false
                    self.errorMessage = error
                } else {
                    self.transferSuccess = true
                }
            case .failure(let error):
                print("DebugError: \(error.localizedDescription)")
                self.transferSuccess = false
                self.errorMessage = error.localizedDescription
            }
            self.loadingStatus = false
        }
    }
}
