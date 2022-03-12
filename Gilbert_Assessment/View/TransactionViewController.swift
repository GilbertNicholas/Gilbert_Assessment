//
//  TransactionViewController.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 11/03/22.
//

import UIKit

class TransactionViewController: UIViewController {
    
    private var transaction: [[TranData]] = [[TranData]]()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(TransactionViewCell.self, forCellReuseIdentifier: TransactionViewCell.id)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Transaction"
        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.addConstraintsToFillView(view)
    }
}

extension TransactionViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return transaction.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transaction[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if indexPath.row == 0 {
            var content = cell.defaultContentConfiguration()
            
            cell.contentConfiguration = content
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: TransactionViewCell.id, for: indexPath) as! TransactionViewCell
        }
        
        return cell
    }
}
