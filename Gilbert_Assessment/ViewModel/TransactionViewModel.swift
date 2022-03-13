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
            switch result {
            case .success(let tranData):
                if let tranData = tranData.data {
                    self.transactionData = self.formattingDateTransaction(transactionData: tranData)
                }
                
                if let error = tranData.error?.message {
                    self.error = error
                }
            case .failure(let error):
                print("DebugError: \(error.localizedDescription)")
            }
            self.loadingStatus = false
        }
    }
    
    func formattingDateTransaction(transactionData: [TranData]) -> [[TranData]] {
        var dateFormatted: [Date] = []
        for tran in transactionData {
            let date = tran.transactionDate.formattingIso8601.removeDateTimestamp()
            dateFormatted.append(date)
        }
        let sortedDate = Set(dateFormatted).sorted(by: { $0 > $1 })
    
        var data: [[TranData]] = []
        
        for sortDate in sortedDate {
            let filter = transactionData.filter { tran in
                tran.transactionDate.formattingIso8601.removeDateTimestamp() == sortDate
            }
            data.append(filter)
        }
        return data
    }
}
