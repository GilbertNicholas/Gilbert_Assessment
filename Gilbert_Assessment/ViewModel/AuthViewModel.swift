//
//  AuthViewModel.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 12/03/22.
//

import Foundation

class AuthViewModel {
    private let apiCall = APIDataSource.singleton
    @Published var loadingStatus: Bool = false
    @Published var authSuccess: Bool = false
    @Published var authMessage: String = ""
    
    func authCall(type: APIRequestType, username: String, password: String, completion: @escaping() -> Void) {
        self.loadingStatus = true
        let body = apiCall.authBody(username: username, password: password)
        
        apiCall.postData(type: type, responseModel: Auth.self, body: body) { result in
            switch result {
            case .success(let dataAuth):
                if type == .login {
                    UserDefaults.standard.set(dataAuth.token, forKey: UserDefaultsType.token.rawValue)
                    UserDefaults.standard.set(dataAuth.username, forKey: UserDefaultsType.username.rawValue)
                    UserDefaults.standard.set(dataAuth.accountNo, forKey: UserDefaultsType.accNumber.rawValue)
                    
                    if let error = dataAuth.error {
                        self.authSuccess = false
                        self.authMessage = error
                    } else {
                        self.loadingStatus = false
                        self.authSuccess = true
                    }
                } else if type == .register {
                    completion()
                }
            case .failure(let error):
                print("DebugError: \(error.localizedDescription)")
                self.authSuccess = false
                self.authMessage = error.localizedDescription
            }
            self.loadingStatus = false
        }
    }
}
