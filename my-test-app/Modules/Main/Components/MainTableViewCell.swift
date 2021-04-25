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
    private var fromStoryboard: Bool = false
    private var style: ConstantStyle?
    
    //    MARK: - Properties nib

    @IBOutlet weak var imageViewFromNib: UIImageView!
    @IBOutlet weak var labelFromNib: UILabel!
    
    
    // MARK: - Override func
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.contentView.addSubview(myLabelView)
        self.contentView.addSubview(myImageView)
        
        myLabelView.snp.makeConstraints({
            $0.edges.equalToSuperview().inset(16)
        })
        myImageView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }
    
    override func setupView() {
        super.setupView()
        
        clipsToBounds = true
        selectionStyle = .none
        myLabelView.numberOfLines = 0
        myImageView.contentMode = .scaleAspectFill
    }
    
    override func setupViewNib() {
        super.setupViewNib()
        
        selectionStyle = .none
        self.fromStoryboard = true
    }
    
    // MARK: - Public func
    
    public func configure(model: MainCellModel, style: ConstantStyle) {
        switch style {
        case .image:
            if fromStoryboard {
                self.labelFromNib.text = nil
                self.imageViewFromNib.image = model.image
            } else {
                self.myLabelView.text = nil
                self.myImageView.image = model.image
            }
        case .text:
            if fromStoryboard {
                self.labelFromNib.text = model.text
                self.imageViewFromNib.image = nil
            } else {
                self.myLabelView.text = model.text
                self.myImageView.image = nil
            }
        }
    }
}
