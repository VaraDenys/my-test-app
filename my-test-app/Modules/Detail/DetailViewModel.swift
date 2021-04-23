//
//  DetailViewModel.swift
//  my-test-app
//
//  Created by Deny Vorko on 22.04.2021.
//

import UIKit

class DetailViewModel: ViewModel {
    
// MARK: - Private properties
    
    private var image: UIImage? = nil
    private var text: String? = nil
    private var style: DetailVCStyle!
    
// MARK: - Init
    
    init(model: MainCellModel, style: DetailVCStyle) {
        super.init()
        self.style = style
        switch style {
        case .image:
            self.image = model.image
        case .text:
            self.text = model.text
        }
    }
    
// MARK: - Public func
    
    public func getStyle() -> DetailVCStyle {
        return self.style
    }
    
    public func getText() -> String {
        return self.text ?? ""
    }
    
    public func getImage() -> UIImage {
        return self.image ?? UIImage()
    }
}

// MARK: - Style

enum DetailVCStyle {
    case image
    case text
}
