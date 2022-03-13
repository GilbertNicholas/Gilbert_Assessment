//
//  Gilbert_AssessmentUnitTests.swift
//  Gilbert_AssessmentUnitTests
//
//  Created by Gilbert Nicholas on 13/03/22.
//

import XCTest
@testable import Gilbert_Assessment

class Gilbert_AssessmentUnitTests: XCTestCase {
    
    var transactionViewModel = TransactionViewModel()
    
    let tranData1 = TranData(transactionId: "1", amount: 100, transactionDate: "2022-01-19T04:39:38.596Z", description: "test1", transactionType: "transfer", receipient: Stakeholder(accountNo: "2833-703-6351", accountHolder: "Mohammed"), sender: nil)
    
    let tranData2 = TranData(transactionId: "2", amount: 150, transactionDate: "2022-03-17T04:39:38.596Z", description: "test2", transactionType: "transfer", receipient: Stakeholder(accountNo: "7174-429-2937", accountHolder: "Emmie"), sender: nil)
    
    let tranData3 = TranData(transactionId: "3", amount: 250, transactionDate: "2022-02-02T04:39:38.596Z", description: "test3", transactionType: "transfer", receipient: Stakeholder(accountNo: "6554-630-9653", accountHolder: "Andy"), sender: nil)
    
    func test_sorting_data_transaction_based_on_newest_date() {
        let dataTransaction: [TranData] = [tranData1, tranData2, tranData3]
        
        let sortedData = transactionViewModel.formattingDateTransaction(transactionData: dataTransaction)
        XCTAssertEqual("Emmie", sortedData[0][0].receipient?.accountHolder)
        XCTAssertEqual("2833-703-6351", sortedData[2][0].receipient?.accountNo)
    }
    
    

}
