//
//  DetailViewController.swift
//  my-test-app
//
//  Created by Deny Vorko on 22.04.2021.
//

import UIKit
import SnapKit

class DetailViewController: ViewController<DetailViewModel> {
    
    // MARK: - Private properties
    
    private lazy var labelView = UILabel()
    private lazy var scrollView = DetailScrollView()
    
    private lazy var swipe: UISwipeGestureRecognizer = {
       let ges = UISwipeGestureRecognizer()
        ges.direction = .down
        ges.addTarget(self, action: #selector(swipeDown))
        return ges
    }()
    
    // MARK: - Override func
    
    override func setupConstraints() {
        super.setupConstraints()
        switch viewModel.getStyle() {
        case .image:
            view.addSubview(scrollView)
            view.addGestureRecognizer(swipe)
            scrollView.snp.makeConstraints({
                $0.edges.equalToSuperview()
            })
        case .text:
            view.addSubview(labelView)
            labelView.snp.makeConstraints({
                $0.edges.equalToSuperview()
            })
        }
    }
    override func setupView() {
        super.setupView()
        switch viewModel.getStyle() {
        case .image:
            view.backgroundColor = .black
            scrollView.configure(image: viewModel.getImage())
        case .text:
            labelView.numberOfLines = 0
            labelView.textAlignment = .center
            labelView.text = viewModel.getText()
        }
    }
    
    override func setupNavigationController() {
        super.setupNavigationController()
        switch viewModel.getStyle() {
        case .image:
            navigationController?.navigationBar.isHidden = true
        case .text:
            navigationController?.navigationBar.isHidden = false
        }
    }
    
    @objc private func swipeDown() {
        self.dismiss(animated: true, completion: nil)
    }
}
