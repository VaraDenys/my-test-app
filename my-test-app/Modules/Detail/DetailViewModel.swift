//
//  DetailViewModel.swift
//  my-test-app
//
//  Created by Deny Vorko on 22.04.2021.
//

import UIKit

class DetailViewModel: ViewModel {
    
    // MARK: - Private properties
    
    private let service = MyJsonService()
    private var stringValue: String = ""
    private var image: UIImage? = nil
    private var text: String? = nil
    private var style: ConstantStyle!
    
//    MARK: - Public properties
    
    var onDidChange: ((ConstantStyle) -> Void)!
    
    // MARK: - Init
    
    init(string: String, style: ConstantStyle) {
        super.init()

        self.stringValue = string
        self.style = style
    }
    
    // MARK: - Public func
    
    public func resumeFetch() {
        switch self.style {
        case .text:
            self.image = nil
            self.text = stringValue
            self.onDidChange(.text)
        case .image:
            self.text = nil
            service.getImage(url: stringValue) { (result) in
                switch result {
                case .success(let image):
                    self.image = image
                    self.onDidChange(.image)
                case .failure(_): break
//                    do something
                }
            }
        default:
            break
        }
    }
    
    public func getStyle() -> ConstantStyle {
        return self.style
    }
    
    public func getText() -> String {
        return self.text ?? ""
    }
    
    public func getImage() -> UIImage {
        return self.image ?? UIImage()
    }
}
