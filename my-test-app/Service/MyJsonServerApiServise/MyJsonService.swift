//
//  MyJsonService.swift
//  my-test-app
//
//  Created by Deny Vorko on 22.04.2021.
//

import UIKit
import Alamofire
import Moya

class MyJsonService {
    
// MARK: - Private properties
    
    private let provider = MoyaProvider<MyJsonServerEndPoint>()
    
// MARK: - Public func
    
    public func getContent(completion: @escaping (Result<[Content], ApiErrorType>) -> Void) {
        provider.request(.getContent) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try response.map(ContentsResponse.self)
                    let res = result.content
                    completion(.success(res))
                } catch {
                    completion(.failure(.InvalidParsing))
                }
            case .failure(_):
                completion(.failure(.invalidRequest))
            }
        }
    }
}

// MARK: - Error type

enum ApiErrorType: String, Error {
    case invalidRequest = "invalid request"
    case InvalidParsing = "invalid parsing"
}
