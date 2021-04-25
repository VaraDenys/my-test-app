//
//  Button.swift
//  my-test-app
//
//  Created by Deny Vorko on 23.04.2021.
//

import UIKit

class QuizButton: Button {
    
// MARK: - Private properties
    
    var realization: ConstantRealization = .programmatically
    
    override func setupView() {
        super.setupView()
        layer.cornerRadius = 20
        layer.borderWidth = 2
        layer.borderColor = UIColor.gray.cgColor
        setTitleColor(.black, for: .normal)
    }
    
    public func configure(realization: ConstantRealization) {
        switch realization {
        case .storyboard:
            self.realization = realization
            self.setTitle("storyboard", for: .normal)
        case .programmatically:
            self.realization = realization
            self.setTitle("programmatically", for: .normal)
        }
    }
}
