//
//  MainTableViewCell.swift
//  my-test-app
//
//  Created by Deny Vorko on 22.04.2021.
//

import UIKit
import SnapKit

class MainTableViewCell: TableViewCell {
    
// MARK: - Private properties
    
    private lazy var myLabelView = UILabel()
    private lazy var myImageView = UIImageView()
    private var style: MainCellStyle?
    
// MARK: - Override func
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.contentView.addSubview(myLabelView)
        self.contentView.addSubview(myImageView)
        
        myLabelView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        myImageView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }
    
    override func setupView() {
        super.setupView()
        
        myLabelView.numberOfLines = 0
        
        myImageView.contentMode = .scaleAspectFit
    }
    
// MARK: - Public func
    
    public func configure(model: MainCellModel, style: MainCellStyle) {
        switch style {
        case .image:
            self.myLabelView.text = nil
            self.myImageView.image = model.image
        case .text:
            self.myImageView.image = nil
            self.myLabelView.text = model.text
        }
    }
}

enum MainCellStyle {
    case image
    case text
}
