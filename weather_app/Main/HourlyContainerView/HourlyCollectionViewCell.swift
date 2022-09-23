//
//  HourlyCollectionViewCell.swift
//  weather_app
//
//  Created by Deny Vorko on 23.09.2022.
//

import Foundation
import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    let timeLabel = UILabel()
    let imageView = UIImageView()
    let tempLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(timeLabel)
        timeLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        timeLabel.textAlignment = .center
        
        self.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(20)
        }
        imageView.contentMode = .scaleAspectFill
        
        self.addSubview(tempLabel)
        tempLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
        }
        tempLabel.textAlignment = .center
    }
    
    func configure(item: HourlyCellInfo) {
        self.timeLabel.text = item.time
        self.imageView.image = UIImage(named: item.imageName)
        self.tempLabel.text = "\(String(item.temp))°"
    }
}
