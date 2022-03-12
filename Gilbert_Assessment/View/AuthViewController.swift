//
//  LoginViewController.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 11/03/22.
//

import UIKit
import Combine

class AuthViewController: UIViewController {
    
    private var subs = Set<AnyCancellable>()
    
    let emailTextField = TextFieldForm()
    let passwordTextField = TextFieldForm()
    let confirmPasswordTextField = TextFieldForm()
    let labelSwitch = UILabel()
    let viewModel = AuthViewModel()
    lazy var buttonLogin = ButtonForm(text: "Sign In")
    lazy var buttonRegister = ButtonForm(text: "Sign Up")
    
    var delegate: ContentCoordinatorDelegate?
    
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
        configureObserver()
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
        usedButton.addTarget(self, action: self.authType == .login ? #selector(handleLogin) : #selector(handleRegister), for: .touchUpInside)
        
        view.addSubview(indicator)
        indicator.center(inView: view)
    }
    
    private func configureObserver() {
        viewModel.$loadingStatus.sink { loadingStatus in
            if loadingStatus {
                self.indicator.startAnimating()
            } else {
                self.indicator.stopAnimating()
            }
        }.store(in: &subs)
        
        viewModel.$authSuccess.sink { authStatus in
            if authStatus {
                self.delegate?.didChangeContent()
            }
        }.store(in: &subs)
        
        viewModel.$authMessage.sink { errorMsg in
            if !errorMsg.isEmpty {
                self.showAlert(title: "Failed Login", message: errorMsg)
            }
        }.store(in: &subs)
    }
    
    public func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Close", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func handleLogin() {
        if let username = emailTextField.text, let password = passwordTextField.text {
            viewModel.authCall(type: .login, username: username, password: password)
        }
    }
    
    @objc func handleRegister() {
        
    }
}

extension AuthViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
