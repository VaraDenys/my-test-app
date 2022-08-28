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
    }
}
