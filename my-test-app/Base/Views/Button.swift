//
//  Button.swift
//  my-test-app
//
//  Created by Deny Vorko on 23.04.2021.
//

import UIKit

class Button: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupConstraints() {}
    public func setupView() {}
}
