//
//  ValueCollectionViewCell.swift
//  weather_app
//
//  Created by Deny Vorko on 28.08.2022.
//

import Foundation
import UIKit

class ValueCollectionViewCell: UICollectionViewCell {
    private let firstLabel = UILabel()
    private let secondLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(info: HeaderWeatherInfo) {
        self.firstLabel.text = info.title
        self.secondLabel.text = info.value
    }
    
    private func setupViews() {
        self.backgroundColor = .clear
        
        self.contentView.addSubview(self.firstLabel)
        self.firstLabel.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview().inset(5)
        }
        firstLabel.font = .systemFont(ofSize: 12)
        
        self.contentView.addSubview(self.secondLabel)
        self.secondLabel.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(5)
            $0.top.equalTo(firstLabel.snp.bottom).offset(5)
        }
        secondLabel.font = .systemFont(ofSize: 12, weight: .bold)
    }
}
