//
//  LoginViewController.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 11/03/22.
//

import UIKit

class AuthViewController: UIViewController {
    
    let emailTextField = TextFieldForm()
    let passwordTextField = TextFieldForm()
    let confirmPasswordTextField = TextFieldForm()
    let labelSwitch = UILabel()
    lazy var buttonLogin = ButtonForm(text: "Sign In")
    lazy var buttonRegister = ButtonForm(text: "Sign Up")
    
    private var authType: AuthType = .login
    
    lazy var indicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.hidesWhenStopped = true
        return ai
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(emailTextField)
        emailTextField.delegate = self
        emailTextField.placeholder = "Email"
        emailTextField.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 30, paddingRight: 30, height: 40)
        
        view.addSubview(passwordTextField)
        passwordTextField.delegate = self
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.anchor(top: emailTextField.safeAreaLayoutGuide.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 30, paddingRight: 30, height: 40)
        
        if authType == .register {
            view.addSubview(confirmPasswordTextField)
            confirmPasswordTextField.delegate = self
            confirmPasswordTextField.placeholder = "Confirm Password"
            confirmPasswordTextField.isSecureTextEntry = true
            confirmPasswordTextField.anchor(top: passwordTextField.safeAreaLayoutGuide.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 30, paddingRight: 30, height: 40)
        }
        
        let usedButton = self.authType == .login ? buttonLogin : buttonRegister
        view.addSubview(usedButton)
        usedButton.anchor(top: self.authType == .login ? passwordTextField.bottomAnchor : confirmPasswordTextField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 20, paddingRight: 20, height: 40)
        
        view.addSubview(indicator)
        indicator.center(inView: view)
    }
}

extension AuthViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            print("email: \(textField.text)")
        } else {
            print("pass: \(textField.text)")
        }
    }
}
