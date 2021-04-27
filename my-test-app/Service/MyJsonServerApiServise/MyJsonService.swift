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
    
    public func getImageWithCount(url: String, count: Int, completion: @escaping ((Result<(count: Int, image: UIImage),ApiErrorType>) -> Void)) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        if let image = cache.image(for: url) {
            completion(.success((count: count, image: image)))
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
                        completion(.success((count: count, image: image)))
                case .failure(_):
                    completion(.failure(.invalidRequest))
                }
            }
        }
    }
    
    public func getImages(for url: [String], completion: @escaping ((Result<[UIImage],ApiErrorType>) -> Void)) {
        var imagesWithCount: [(count: Int, image: UIImage)] = []
        var resultImages: [UIImage] = []
        var count: Int = 0
        let group = DispatchGroup()
        url.forEach { string in
            group.enter()
            self.getImageWithCount(url: string, count: count) { (result) in
                switch result {
                case .success((let count, let image)):
                    imagesWithCount.append((count: count, image: image))
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                }
                group.leave()
            }
            count += 1
        }
        group.notify(queue: .main) {
            imagesWithCount.sort(by: { $0.count < $1.count })
            imagesWithCount.forEach { (_, image) in
                resultImages.append(image)
            }
            completion(.success(resultImages))
        }
    }
}

// MARK: - Error type

enum ApiErrorType: String, Error {
    case invalidUrl = "invalid url"
    case invalidRequest = "invalid request"
    case invalidParsing = "invalid parsing"
}
