//
//  ImageCache.swift
//  my-test-app
//
//  Created by Deny Vorko on 23.04.2021.
//

import Foundation
import UIKit

protocol ImageCacheProtocol {
    func image(for url: URL) -> UIImage?
    func insertImage(_ image: UIImage?, for url: URL)
    func removeImage(for url: URL)
    func removeAllImage()
    subscript(_ key: URL) -> UIImage? { get set }
}

final class ImageCache {
    
    static var shared: ImageCache = {
        let cache = ImageCache()
        return cache
    }()
    
    private lazy var imageCache: NSCache<AnyObject,AnyObject> = {
        let cache = NSCache<AnyObject,AnyObject>()
        return cache
    }()
    
    private let lock = NSLock()
    private let config: Config
    
    struct Config {
        var countLimit: Int
        
        static let defaultConfig = Config(countLimit: 100)
    }
    
    init(config: Config = Config.defaultConfig) {
        self.config = config
    }
}

extension ImageCache: ImageCacheProtocol {
    
    subscript(_ key: URL) -> UIImage? {
        get {
            return image(for: key)
        }
        set {
            return insertImage(newValue, for: key)
        }
    }
    
    func image(for url: URL) -> UIImage? {
        lock.lock(); defer { lock.unlock() }
        guard let image = imageCache.object(forKey: url as AnyObject) as? UIImage else { return nil }
        return image
    }
    
    func removeImage(for url: URL) {
        lock.lock(); defer { lock.unlock() }
        imageCache.removeObject(forKey: url as AnyObject)
    }
    
    func removeAllImage() {
        lock.lock(); defer { lock.unlock() }
        imageCache.removeAllObjects()
    }
    
    func insertImage(_ image: UIImage?, for url: URL) {
        guard let image = image else { return removeImage(for: url) }
        
        lock.lock(); defer { lock.unlock() }
        imageCache.setObject(image, forKey: url as AnyObject)
    }
    
}
