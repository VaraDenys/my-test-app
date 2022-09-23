//
//  MainViewController.swift
//  weather_app
//
//  Created by Deny Vorko on 20.07.2022.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    private let header = HeaderView()
    private let hourlyContainerView = HourlyContainerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        self.view.backgroundColor = .appBackground
        
        self.view.addSubview(header)
        self.header.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(35)
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.height.equalTo(250)
        }
        
        self.view.addSubview(hourlyContainerView)
        self.hourlyContainerView.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(35)
            $0.height.equalTo(100)
        }
    }
}
