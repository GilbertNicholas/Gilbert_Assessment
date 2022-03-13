//
//  APIDataSource.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 12/03/22.
//

import Foundation
import Alamofire

class APIDataSource {
    
    static let singleton = APIDataSource()
    static let api_url = "https://green-thumb-64168.uc.r.appspot.com/"
    
    func requestData<T:Codable>(type: APIRequestType, responseModel: T.Type, completion: @escaping(Result<T, Error>) -> Void) {
        let urls = APIDataSource.api_url + type.rawValue
        guard let url = URL(string: urls) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(UserDefaults.standard.string(forKey: UserDefaultsType.token.rawValue), forHTTPHeaderField: "Authorization")
        
        AF.request(request).responseDecodable(of: responseModel) { response in
            switch response.result {
            case .success(let response):
                completion(.success(response))
                break
            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
    }
    
    func postData<T:Codable>(type: APIRequestType, responseModel: T.Type, body: Data?, completion: @escaping(Result<T, Error>) -> Void) {
        let urls = APIDataSource.api_url + type.rawValue
        guard let url = URL(string: urls) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        if type == .transfer {
            request.setValue(UserDefaults.standard.string(forKey: UserDefaultsType.token.rawValue), forHTTPHeaderField: "Authorization")
        }
        
        if let body = body {
            request.httpBody = body
        }
        
        AF.request(request).responseDecodable(of: responseModel) { response in
            switch response.result {
            case .success(let response):
                completion(.success(response))
                break
            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
    }
    
    func authBody(username: String, password: String) -> Data? {
        let data = "{\n    \"username\": \"\(username)\",\n    \"password\": \"\(password)\"\n}".data(using: .utf8)
        
        return data
    }
    
    func transferBody(receipientAccountNo: String, amount: Double, description: String) -> Data? {
        let data = "{\n    \"receipientAccountNo\": \"\(receipientAccountNo)\",\n    \"amount\": \(amount),\n    \"description\": \"\(description)\"\n}".data(using: .utf8)
        
        return data
    }
}
