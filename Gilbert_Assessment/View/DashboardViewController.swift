//
//  DashboardViewController.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 11/03/22.
//

import UIKit
import Combine

class DashboardViewController: UIViewController {
    
    private var subs = Set<AnyCancellable>()
    
    var delegate: DashboardViewControllerDelegate?
    private let viewModel = DashboardViewModel()
    
    let labelName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    lazy var indicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.hidesWhenStopped = true
        return ai
    }()
    
    var labelBalancePlaceholder = UILabel()
    var labelBalance = UILabel()
    var labelAccNumPlaceHolder = UILabel()
    var labelAccNum = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Dashboard"
        
        viewModel.getBalance()
        configureUI()
        configureObserver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.getBalance()
    }
    
    private func configureUI() {
        let menuButton = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .done, target: self, action: #selector(didTapMenuBtn))
        menuButton.tintColor = .black
        navigationItem.leftBarButtonItem = menuButton
        
        view.addSubview(labelName)
        if let name = UserDefaults.standard.string(forKey: UserDefaultsType.username.rawValue) {
            labelName.text = "Hello, \(name)"
        }
        labelName.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 50, paddingLeft: 30)
        
        view.addSubview(labelAccNumPlaceHolder)
        labelAccNumPlaceHolder.text = "Account No:"
        labelAccNumPlaceHolder.textColor = .gray
        labelAccNumPlaceHolder.font = UIFont.systemFont(ofSize: 14)
        labelAccNumPlaceHolder.anchor(top: labelName.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 30)
        
        view.addSubview(labelAccNum)
        if let accNum = UserDefaults.standard.string(forKey: UserDefaultsType.accNumber.rawValue) {
            labelAccNum.text = accNum
        }
        labelAccNum.font = UIFont.boldSystemFont(ofSize: 16)
        labelAccNum.anchor(top: labelAccNumPlaceHolder.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 5, paddingLeft: 30)
        
        view.addSubview(labelBalancePlaceholder)
        labelBalancePlaceholder.text = "Your Balance:"
        labelBalancePlaceholder.font = UIFont.boldSystemFont(ofSize: 22)
        labelBalancePlaceholder.centerX(inView: view, topAnchor: labelAccNum.bottomAnchor, paddingTop: 80)
        
        view.addSubview(labelBalance)
        labelBalance.font = UIFont.boldSystemFont(ofSize: 30)
        labelBalance.centerX(inView: view, topAnchor: labelBalancePlaceholder.bottomAnchor, paddingTop: 10)
        
        view.addSubview(indicator)
        indicator.center(inView: view)
    }
    
    private func configureObserver() {
        viewModel.$balance.sink { balance in
            self.labelBalance.text = "SGD \(balance)"
        }.store(in: &subs)
        
        viewModel.$loadingStatus.sink { loadingStatus in
            if loadingStatus {
                self.indicator.startAnimating()
            } else {
                self.indicator.stopAnimating()
            }
        }.store(in: &subs)
    }
    
    @objc func didTapMenuBtn() {
        delegate?.didTapMenu()
    }
}
