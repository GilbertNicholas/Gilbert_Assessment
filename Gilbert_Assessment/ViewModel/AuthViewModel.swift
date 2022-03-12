//
//  AuthViewModel.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 12/03/22.
//

import Foundation

class AuthViewModel {
    private let apiCall = APIDataSource.singleton
    func authCall(type: APIRequestType, username: String, password: String) {
        let body = apiCall.authBody(username: username, password: password)
        apiCall.postData(type: type, responseModel: Auth.self, body: body)
    }
}
