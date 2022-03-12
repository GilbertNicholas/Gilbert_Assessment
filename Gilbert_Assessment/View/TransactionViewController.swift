//
//  TransactionViewController.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 11/03/22.
//

import UIKit
import Combine

class TransactionViewController: UIViewController {
    
    private var subs = Set<AnyCancellable>()
    private var transaction: [TranData] = []
    private let viewModel = TransactionViewModel()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(TransactionViewCell.self, forCellReuseIdentifier: TransactionViewCell.id)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Transaction"
        view.backgroundColor = .systemBackground
        configureUI()
        configureObserver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.getTransactionData()
    }
    
    private func configureUI() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.addConstraintsToFillView(view)
    }
    
    private func configureObserver() {
        viewModel.$transactionData.sink { tranData in
            self.transaction = tranData
            self.tableView.reloadData()
        }.store(in: &subs)
    }
}

extension TransactionViewController: UITableViewDelegate, UITableViewDataSource {

//    func numberOfSections(in tableView: UITableView) -> Int {
//        return transaction.count
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(transaction.count)
        return transaction.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionViewCell.id, for: indexPath) as! TransactionViewCell
        
        cell.configureContent(data: transaction[indexPath.row])
        return cell
//        if indexPath.row == 0 {
//            let cell = UITableViewCell()
//            var content = cell.defaultContentConfiguration()
//            content.text = "SECTION"
//            cell.contentConfiguration = content
//        } else {
//
//        }
    }
}
