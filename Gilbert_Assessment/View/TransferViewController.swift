//
//  TransferViewController.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 11/03/22.
//

import UIKit

class TransferViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Transfer"
        view.backgroundColor = .systemBackground
        configureUI()
    }
    
    let textField = TextFieldForm()

    func configureUI() {
//        view.addSubview(textField)
//        textField.delegate = self
//        textField.placeholder = "Tulis!"
//        textField.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 30)
//        textField.anchor(width: view.bounds.width / 1.2, height: 40)
        
        view.addSubview(textField)
        textField.delegate = self
        textField.placeholder = "EMAIL"
        textField.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20, height: 40)
    }
}

extension TransferViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("HASIL: \(textField.text)")
    }
}
