//
//  TransferViewController.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 11/03/22.
//

import UIKit
import Combine

class TransferViewController: UIViewController {
    
    private var subs = Set<AnyCancellable>()
    
    private var selectedPayee: PayeesData?
    private let choosePayeesView = ChoosePayeesUIView()
    private let textFieldAmount = TextFieldForm()
    private let textAreaDescription = UITextView()
    
    private let labelErrorAmount = LabelErrorForm()
    private let labelErrorPayees = LabelErrorForm()
    
    private let labelFromPlaceHolder = LabelPlaceholder(placeholder: "From")
    private let labelAmountPlaceholder = LabelPlaceholder(placeholder: "Amount")
    private let labelDescriptionPlaceholder = LabelPlaceholder(placeholder: "Description")
    
    private let buttonTransfer = ButtonForm(text: "Transfer")
    
    private let viewModel = TransferViewModel()
    
    var delegate: MenuViewControllerDelegate?
    
    private let labelFrom: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 24)
        if let accNum = UserDefaults.standard.string(forKey: UserDefaultsType.accNumber.rawValue) {
            lbl.text = accNum
        }
        return lbl
    }()
    
    lazy var indicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.hidesWhenStopped = true
        return ai
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Transfer"
        view.backgroundColor = .systemBackground
        configureObservers()
        configureUI()
    }

    private func configureUI() {
        self.hideKeyboardWhenTapOutside()
        
        view.addSubview(labelFromPlaceHolder)
        labelFromPlaceHolder.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 30, paddingLeft: 20)
        
        view.addSubview(labelFrom)
        labelFrom.anchor(top: labelFromPlaceHolder.bottomAnchor, left: labelFromPlaceHolder.leftAnchor, paddingTop: 10)
        
        view.addSubview(choosePayeesView)
        choosePayeesView.anchor(top: labelFrom.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 20, paddingRight: 20, height: 80)
        
        view.addSubview(labelErrorPayees)
        labelErrorPayees.text = "Choose transfer receipient first"
        labelErrorPayees.anchor(top: choosePayeesView.bottomAnchor, left: choosePayeesView.leftAnchor, paddingTop: 5)
        
        view.addSubview(labelAmountPlaceholder)
        labelAmountPlaceholder.anchor(top: labelErrorPayees.bottomAnchor, left: choosePayeesView.leftAnchor, paddingTop: 10)
        
        view.addSubview(textFieldAmount)
        textFieldAmount.delegate = self
        textFieldAmount.placeholder = "Amount (SGD)"
        textFieldAmount.keyboardType = .numberPad
        textFieldAmount.anchor(top: labelAmountPlaceholder.bottomAnchor, left: choosePayeesView.leftAnchor, right: choosePayeesView.rightAnchor, paddingTop: 10, height: 40)
        
        view.addSubview(labelErrorAmount)
        labelErrorAmount.text = "Transfer amount can't be empty"
        labelErrorAmount.anchor(top: textFieldAmount.bottomAnchor, left: choosePayeesView.leftAnchor, paddingTop: 5)
        
        view.addSubview(labelDescriptionPlaceholder)
        labelDescriptionPlaceholder.anchor(top: labelErrorAmount.bottomAnchor, left: choosePayeesView.leftAnchor, paddingTop: 10)
        
        view.addSubview(textAreaDescription)
        textAreaDescription.text = "Enter Transfer Description"
        textAreaDescription.font = UIFont.systemFont(ofSize: 17)
        textAreaDescription.textColor = .lightGray
        textAreaDescription.layer.borderColor = UIColor.gray.cgColor
        textAreaDescription.layer.borderWidth = 1
        textAreaDescription.layer.cornerRadius = 8
        textAreaDescription.delegate = self
        textAreaDescription.anchor(top: labelDescriptionPlaceholder.bottomAnchor, left: choosePayeesView.leftAnchor, right: choosePayeesView.rightAnchor, paddingTop: 10, height: 100)
        
        view.addSubview(buttonTransfer)
        buttonTransfer.addTarget(self, action: #selector(tapTransfer), for: .touchUpInside)
        buttonTransfer.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 20, paddingBottom: 40, paddingRight: 20, height: 40)
        
        view.addSubview(indicator)
        indicator.hidesWhenStopped = true
        indicator.center(inView: view)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectPayees))
        choosePayeesView.addGestureRecognizer(tap)
    }
    
    private func configureObservers() {
        viewModel.$loadingStatus.sink { loadingStatus in
            if loadingStatus {
                self.indicator.startAnimating()
            } else {
                self.indicator.stopAnimating()
            }
        }.store(in: &subs)
        
        viewModel.$transferSuccess.sink { transferStatus in
            if transferStatus {
                self.showAlert(title: "Success", message: "", type: .success)
            }
        }.store(in: &subs)
        
        viewModel.$errorMessage.sink { errorMessage in
            if !errorMessage.isEmpty {
                self.showAlert(title: "Transfer Failed", message: errorMessage, type: .failed)
            }
        }.store(in: &subs)
    }
    
    @objc func tapTransfer() {
        if let amount = textFieldAmount.text {
            labelErrorAmount.isHidden = !amount.isEmpty
        }
        
        if self.selectedPayee == nil {
            labelErrorPayees.isHidden = false
        }
        
        if let amount = textFieldAmount.text, let selectedPayee = self.selectedPayee {
            var description = ""
            if self.textAreaDescription.textColor == .lightGray {
                description = "-"
            } else {
                description = self.textAreaDescription.text
            }
            
            if let amount = Double(amount) {
                viewModel.transfer(receipientAccNo: selectedPayee.accountNo, amount: amount, desc: description)
            } else {
                print("Error Input Data!")
            }
        }
    }
    
    private func showAlert(title: String, message: String, type: AlertType) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if type == .failed {
            let action = UIAlertAction(title: "Close", style: .default, handler: nil)
            alertController.addAction(action)
        } else {
            let action = UIAlertAction(title: "Close", style: .default) { _ in
                self.delegate?.didSelectOption(menuOption: .dashboard)
            }
            alertController.addAction(action)
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func selectPayees() {
        let vc = PayeesListViewController()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension TransferViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let amount = textField.text {
            self.labelErrorAmount.isHidden = !amount.isEmpty
        }
    }
}

extension TransferViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter transfer description"
            textView.textColor = .lightGray
        }
    }
}

extension TransferViewController: PayeesViewControllerDelegate {
    func didSelectPayee(selectedPayee: PayeesData) {
        self.choosePayeesView.labelName.text = selectedPayee.name
        self.choosePayeesView.labelAccNum.text = selectedPayee.accountNo
        self.selectedPayee = selectedPayee
        self.labelErrorPayees.isHidden = true
    }
}
