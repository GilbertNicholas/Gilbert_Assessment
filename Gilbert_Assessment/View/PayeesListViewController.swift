//
//  PayeesListViewController.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 13/03/22.
//

import UIKit
import Combine

class PayeesListViewController: UIViewController {
    
    private var subs = Set<AnyCancellable>()
    private var listPayees: [PayeesData] = []
    private let viewModel = PayeesViewModel()
    
    var delegate: PayeesViewControllerDelegate?
    
    let tableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    private let indicatorLoading = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getPayeesData()
        tableView.delegate = self
        tableView.dataSource = self
        
        configureUI()
        configureObservers()
    }
    
    private func configureUI() {
        self.title = "Payees List"
        self.navigationController?.navigationBar.tintColor = .black
        
        view.addSubview(tableView)
        tableView.addConstraintsToFillView(view)
        
        view.addSubview(indicatorLoading)
        indicatorLoading.hidesWhenStopped = true
        indicatorLoading.center(inView: view)
    }
    
    private func configureObservers() {
        viewModel.$payeesData.sink { payeesDatas in
            self.listPayees = payeesDatas
            self.tableView.reloadData()
        }.store(in: &subs)
        
        viewModel.$loadingStatus.sink { loadingStatus in
            if loadingStatus {
                self.indicatorLoading.startAnimating()
            } else {
                self.indicatorLoading.stopAnimating()
            }
        }.store(in: &subs)
    }
}

extension PayeesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPayees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = self.listPayees[indexPath.row].name
        content.secondaryText = self.listPayees[indexPath.row].accountNo
        content.secondaryTextProperties.color = .gray
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectPayee(selectedPayee: self.listPayees[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
}
