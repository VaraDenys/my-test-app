//
//  LaunchViewController.swift
//  weather_app
//
//  Created by Deny Vorko on 20.07.2022.
//

import Foundation
import UIKit
import SnapKit

class LaunchViewController: UIViewController {
    private lazy var startButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        self.view.backgroundColor = .lightGray
        
        self.view.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(200)
        }

        self.startButton.layer.cornerRadius = 10
        self.startButton.layer.borderWidth = 3
        self.startButton.layer.borderColor = UIColor.black.cgColor
        self.startButton.setTitle("START", for: .normal)
        self.startButton.setTitleColor(.black, for: .normal)
        self.startButton.addTarget(self, action: #selector(goToMainViewController(sender:)), for: .touchUpInside)
    }
    
    @objc private func goToMainViewController(sender: AnyObject) {
        let vc = Screens.mainViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
