//
//  QuizViewController.swift
//  my-test-app
//
//  Created by Deny Vorko on 23.04.2021.
//

import UIKit
import SnapKit

class QuizViewController: ViewController<QuizViewModel> {
    
// MARK: - Private properties
    
    private lazy var buttonProgr = QuizButton()
    private lazy var buttonStory = QuizButton()
    
// MARK: - Override func
    
    override func setupConstraints() {
        super.setupConstraints()
        
        view.addSubview(buttonProgr)
        view.addSubview(buttonStory)
        
        buttonProgr.snp.makeConstraints({
            $0.bottom.equalTo(view.snp.centerY).offset(-17)
            $0.leading.trailing.equalToSuperview().inset(17)
            $0.height.equalTo(70)
        })
        
        buttonStory.snp.makeConstraints({
            $0.top.equalTo(view.snp.centerY).offset(17)
            $0.leading.trailing.equalToSuperview().inset(17)
            $0.height.equalTo(70)
        })
    }

    override func setupView() {
        super.setupView()
        
        
        buttonProgr.configure(realization: .programmatically)
        buttonStory.configure(realization: .storyboard)
    }
    
    override func binding() {
        super.binding()
        
        buttonProgr.addTarget(self, action: #selector(tapButton(sender:)), for: .touchUpInside)
        buttonStory.addTarget(self, action: #selector(tapButton(sender:)), for: .touchUpInside)
    }
    
    override func setupNavigationController() {
        navigationItem.title = "Welcome"
    }
    
    @objc private func tapButton(sender: QuizButton) {
        switch sender.realization {
        case .storyboard:
            navigationController?.pushViewController(Screens.mainNib(), animated: true)
        case .programmatically:
            navigationController?.pushViewController(Screens.main(), animated: true)
        }
    }
}
