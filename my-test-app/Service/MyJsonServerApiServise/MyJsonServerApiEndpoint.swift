//
//  MyJsonServerApiEndpoint.swift
//  my-test-app
//
//  Created by Deny Vorko on 22.04.2021.
//

import UIKit
import Moya
import Alamofire

struct ConstantsEndpoint {
    static let domainURL: URL? = URL(string: "https://my-json-server.typicode.com")
}

struct ParamsEndpoint {
}

enum  MyJsonServerEndPoint {
    case getContent
}

// MARK: - Extension

extension MyJsonServerEndPoint: TargetType {
    var baseURL: URL {
        guard let url = ConstantsEndpoint.domainURL else {
            fatalError("invalid domain URL")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getContent:
            return "/MaxTopDev/test-fake-json/db"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getContent:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
}

