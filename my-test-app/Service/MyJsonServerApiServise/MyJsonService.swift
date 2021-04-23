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
    private let cache = ImageCache.shared
    
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
                    completion(.failure(.invalidParsing))
                }
            case .failure(_):
                completion(.failure(.invalidRequest))
            }
        }
    }
    
    public func getImage(url: String, completion: @escaping ((Result<UIImage,ApiErrorType>) -> Void)) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        if let image = cache.image(for: url) {
            completion(.success(image))
            debugPrint("cache")
        } else {
            provider.request(.downloadImage(url)) { (result) in
                switch result {
                case .success(let response):
                        guard let image = UIImage(data: response.data) else {
                            completion(.failure(.invalidParsing))
                            return
                        }
                    self.cache.insertImage(image, for: url)
                        completion(.success(image))
                case .failure(_):
                    completion(.failure(.invalidRequest))
                }
            }
        }
    }
    
    public func getImages(for url: [String], completion: @escaping ((Result<[UIImage],ApiErrorType>) -> Void)) {
        var imagesArray: [UIImage] = []
        let group = DispatchGroup()
        url.forEach { string in
            group.enter()

            self.getImage(url: string) { result in
                switch result {
                case .success(let image):
                    imagesArray.append(image)
                case .failure(let error):
                    debugPrint(error)
                }
                group.leave()
            }
        }
        group.notify(queue: .main) {
            completion(.success(imagesArray))
        }
    }
    
}

// MARK: - Error type

enum ApiErrorType: String, Error {
    case invalidUrl = "invalid url"
    case invalidRequest = "invalid request"
    case invalidParsing = "invalid parsing"
}
