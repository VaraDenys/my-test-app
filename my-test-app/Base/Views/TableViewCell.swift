//
//  TableViewCell.swift
//  my-test-app
//
//  Created by Deny Vorko on 22.04.2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConstraints()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViewNib()
    }
    
    public func setupConstraints() {}
    public func setupView() {}
    public func setupViewNib() {}
}
