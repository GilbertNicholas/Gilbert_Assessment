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
    
    private let usernameTextField = TextFieldForm()
    private let passwordTextField = TextFieldForm()
    private let confirmPasswordTextField = TextFieldForm()
    private let labelSwitch = UILabel()
    private let labelSwitchLink = UILabel()
    private let viewModel = AuthViewModel()
    private let logoText = UIImageView()
    
    lazy var buttonLogin = ButtonForm(text: "Sign in")
    lazy var buttonRegister = ButtonForm(text: "Sign up")
    
    lazy var labelErrorConfirm = LabelErrorForm()
    private let labelErrorUsername = LabelErrorForm()
    private let labelErrorPassword = LabelErrorForm()
    
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
        self.hideKeyboardWhenTapOutside()
        self.setGradientBackground(colorTop: UIColor.white.cgColor, colorBottom: UIColor.systemBlue.cgColor)
        
        view.addSubview(logoText)
        logoText.image = UIImage(named: "logoText")
        logoText.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 100)
        
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        usernameTextField.placeholder = "Username"
        usernameTextField.anchor(top: logoText.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 60, paddingLeft: 30, paddingRight: 30, height: 40)
        
        view.addSubview(labelErrorUsername)
        labelErrorUsername.text = "Username can't be empty"
        labelErrorUsername.anchor(top: usernameTextField.bottomAnchor, left: view.leftAnchor, paddingTop: 10, paddingLeft: 30)
        
        view.addSubview(passwordTextField)
        passwordTextField.delegate = self
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.anchor(top: labelErrorUsername.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 30, paddingRight: 30, height: 40)
        
        view.addSubview(labelErrorPassword)
        labelErrorPassword.text = "Password can't be empty"
        labelErrorPassword.anchor(top: passwordTextField.bottomAnchor, left: view.leftAnchor, paddingTop: 10, paddingLeft: 30)
        
        if authType == .register {
            view.addSubview(confirmPasswordTextField)
            confirmPasswordTextField.delegate = self
            confirmPasswordTextField.placeholder = "Confirm Password"
            confirmPasswordTextField.isSecureTextEntry = true
            confirmPasswordTextField.anchor(top: labelErrorPassword.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 30, paddingRight: 30, height: 40)
            
            view.addSubview(labelErrorConfirm)
            labelErrorConfirm.anchor(top: confirmPasswordTextField.bottomAnchor, left: view.leftAnchor, paddingTop: 10, paddingLeft: 30)
        }
        
        let usedButton = self.authType == .login ? buttonLogin : buttonRegister
        view.addSubview(usedButton)
        usedButton.anchor(top: self.authType == .login ? labelErrorPassword.bottomAnchor : labelErrorConfirm.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 20, paddingRight: 20, height: 40)
        usedButton.addTarget(self, action: self.authType == .login ? #selector(handleLogin) : #selector(handleRegister), for: .touchUpInside)
        
        view.addSubview(labelSwitch)
        labelSwitch.text = self.authType == .login ? "Don't have an account? Sign up" : "Already have an account? Sign in"
        labelSwitch.textColor = .white
        labelSwitch.font = UIFont.boldSystemFont(ofSize: 14)
        labelSwitch.isUserInteractionEnabled = true
        labelSwitch.centerX(inView: view, topAnchor: usedButton.bottomAnchor, paddingTop: 22)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapSwitchType))
        labelSwitch.addGestureRecognizer(tap)
        
        view.addSubview(indicator)
        indicator.center(inView: view)
    }
    
    @objc func tapSwitchType() {
        if authType == .login {
            let vc = AuthViewController()
            vc.authType = .register
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
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
                if self.authType == .login {
                    self.delegate?.didChangeContent()
                } else {
                    self.showAlert(title: "Success!", message: "Register Success", type: .success)
                }
                
            }
        }.store(in: &subs)
        
        viewModel.$authMessage.sink { errorMsg in
            
            if !errorMsg.isEmpty {
                self.showAlert(title: "Failed Login", message: errorMsg, type: .failed)
            }
        }.store(in: &subs)
    }
    
    private func showAlert(title: String, message: String, type: AlertType) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if type == .failed {
            let action = UIAlertAction(title: "Close", style: .default, handler: nil)
            alertController.addAction(action)
        } else {
            let action = UIAlertAction(title: "Close", style: .default) { _ in
                self.dismiss(animated: true, completion: nil)
            }
            alertController.addAction(action)
        }
        
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func handleLogin() {
        if let username = usernameTextField.text, let password = passwordTextField.text {
            if username.isEmpty || password.isEmpty {
                labelErrorUsername.isHidden = !username.isEmpty
                labelErrorPassword.isHidden = !password.isEmpty
            } else {
                viewModel.authCall(type: .login, username: username, password: password)
            }
        }
    }
    
    @objc func handleRegister() {
        if let username = usernameTextField.text, let password = passwordTextField.text, let confirm = confirmPasswordTextField.text {
            if username.isEmpty || password.isEmpty || confirm.isEmpty {
                labelErrorUsername.isHidden = !username.isEmpty
                labelErrorPassword.isHidden = !password.isEmpty
                labelErrorConfirm.text = "Confirm password can't be empty"
                labelErrorConfirm.isHidden = !confirm.isEmpty
            } else if password != confirm {
                labelErrorConfirm.text = "Confirm password doesn't match"
                labelErrorConfirm.isHidden = false
            } else {
                viewModel.authCall(type: .register, username: username, password: password)
            }
        }
    }
}

extension AuthViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == usernameTextField {
            if let username = usernameTextField.text {
                labelErrorUsername.isHidden = !username.isEmpty
            }
        } else if textField == passwordTextField {
            if let password = passwordTextField.text {
                labelErrorPassword.isHidden = !password.isEmpty
            }
        } else if textField == confirmPasswordTextField {
            if let confirm = confirmPasswordTextField.text {
                labelErrorConfirm.isHidden = !confirm.isEmpty
            }
        }
    }
}
