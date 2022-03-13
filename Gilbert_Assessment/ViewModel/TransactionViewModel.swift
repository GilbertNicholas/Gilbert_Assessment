//
//  TransactionViewModel.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 12/03/22.
//

import Foundation

class TransactionViewModel {
    private let apiCall = APIDataSource.singleton
    
    @Published var transactionData: [[TranData]] = []
    @Published var loadingStatus: Bool = false
    @Published var error: String = ""
    
    func getTransactionData() {
        loadingStatus = true
        apiCall.requestData(type: .transactions, responseModel: Transaction.self) { result in
            print("DEBUGTRAN: \(result)")
            switch result {
            case .success(let tranData):
                if let tranData = tranData.data {
                    self.formattingDateTransaction(transactionData: tranData)
                }
                
                if let error = tranData.error {
                    self.error = error
                }
            case .failure(let error):
                print("DebugError: \(error.localizedDescription)")
                self.loadingStatus = false
            }
            
        }
    }
    
    private func formattingDateTransaction(transactionData: [TranData]) {
        let datesInData = transactionData.map { $0.transactionDate.iso8601withFractionalSeconds.removeTimeStamp() }
        let sortDate = Set(datesInData).sorted(by: { $0 > $1 })
        var data: [[TranData]] = []
        
        
        for sortDate in sortDate {
            let filter = transactionData.filter { tran in
                tran.transactionDate.iso8601withFractionalSeconds.removeTimeStamp() == sortDate
            }
            data.append(filter)
        }
        self.transactionData = data
        self.loadingStatus = false
//        for sortDate in sortDate {
//            var groupTranDate: [TranData] = []
//            for tranData in transactionData {
//                if tranData.transactionDate.iso8601withFractionalSeconds.removeTimeStamp() == sortDate {
//                    groupTranDate.append(tranData)
//                } else {
//                    break
//                }
//            }
//            print("DATE: \(groupTranDate)")
//            data.append(groupTranDate)
//        }
//        self.transactionData = data
//        self.loadingStatus = false
    }
}
