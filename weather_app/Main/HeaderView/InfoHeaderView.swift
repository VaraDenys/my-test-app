//
//  InfoHeaderView.swift
//  weather_app
//
//  Created by Deny Vorko on 28.08.2022.
//

import Foundation
import UIKit

class InfoHeaderView: UIView {
    private let cityLabel = UILabel()
    private let locationImageView = UIImageView(image: UIImage(named: "locationIcon"))
    private let tempLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.cityLabel.text = "Gdansk"
        self.tempLabel.text = "22°"
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(cityLabel)
        cityLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
        cityLabel.font = .systemFont(ofSize: 16, weight: .bold)

        self.addSubview(locationImageView)
        locationImageView.snp.makeConstraints {
            $0.leading.equalTo(cityLabel.snp.trailing).offset(5)
            $0.centerY.equalTo(cityLabel.snp.centerY)
            $0.height.width.equalTo(14)
            $0.trailing.equalToSuperview().inset(5)
        }
        locationImageView.contentMode = .scaleAspectFill
        locationImageView.tintColor = .gray
        
        self.addSubview(tempLabel)
        self.tempLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(cityLabel.snp.bottom).offset(8)
            $0.bottom.equalToSuperview()
        }
        tempLabel.font = .systemFont(ofSize: 56, weight: .bold)
    }
}
