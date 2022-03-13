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
        label.font = UIFont.boldSystemFont(ofSize: 27)
        return label
    }()
    
    lazy var indicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.hidesWhenStopped = true
        return ai
    }()
    
    private let labelBalancePlaceholder = UILabel()
    private let labelBalance = UILabel()
    private let labelAccNumPlaceHolder = UILabel()
    private let labelAccNum = UILabel()
    private let containerInfoAcc = UIView()
    private let containerBalance = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Dashboard"
        
        viewModel.getBalance()
        configureUI()
        configureObserver()
    }
    
    private func configureUI() {
        self.setGradientBackground(colorTop: UIColor.white.cgColor, colorBottom: UIColor.systemBlue.cgColor)
        
        let menuButton = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .done, target: self, action: #selector(didTapMenuBtn))
        menuButton.tintColor = .black
        navigationItem.leftBarButtonItem = menuButton
        
        view.addSubview(containerInfoAcc)
        containerInfoAcc.layer.cornerRadius = 8
        containerInfoAcc.layer.backgroundColor = UIColor.white.cgColor
        containerInfoAcc.layer.shadowOpacity = 0.2
        containerInfoAcc.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 50, paddingLeft: 20, paddingRight: 20)
        
        containerInfoAcc.addSubview(labelName)
        if let name = UserDefaults.standard.string(forKey: UserDefaultsType.username.rawValue) {
            labelName.text = "Hello, \(name)"
        }
        labelName.anchor(top: containerInfoAcc.topAnchor, left: containerInfoAcc.leftAnchor, right: containerInfoAcc.rightAnchor, paddingTop: 20, paddingLeft: 20)
        
        containerInfoAcc.addSubview(labelAccNumPlaceHolder)
        labelAccNumPlaceHolder.text = "Account No:"
        labelAccNumPlaceHolder.textColor = .darkGray
        labelAccNumPlaceHolder.font = UIFont.systemFont(ofSize: 14)
        labelAccNumPlaceHolder.anchor(top: labelName.bottomAnchor, left: containerInfoAcc.leftAnchor, right: containerInfoAcc.rightAnchor, paddingTop: 20, paddingLeft: 20)
        
        containerInfoAcc.addSubview(labelAccNum)
        if let accNum = UserDefaults.standard.string(forKey: UserDefaultsType.accNumber.rawValue) {
            labelAccNum.text = accNum
        }
        
        labelAccNum.font = UIFont.boldSystemFont(ofSize: 16)
        labelAccNum.anchor(top: labelAccNumPlaceHolder.bottomAnchor, left: containerInfoAcc.leftAnchor, bottom: containerInfoAcc.bottomAnchor, right: containerInfoAcc.rightAnchor, paddingTop: 5, paddingLeft: 20, paddingBottom: 20)
        
        view.addSubview(labelBalancePlaceholder)
        labelBalancePlaceholder.text = "Your Balance:"
        labelBalancePlaceholder.font = UIFont.systemFont(ofSize: 22)
        labelBalancePlaceholder.centerX(inView: view, topAnchor: containerInfoAcc.bottomAnchor, paddingTop: 80)
        
        view.addSubview(labelBalance)
        labelBalance.font = UIFont.boldSystemFont(ofSize: 32)
        labelBalance.centerX(inView: view, topAnchor: labelBalancePlaceholder.bottomAnchor, paddingTop: 20)
        
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
