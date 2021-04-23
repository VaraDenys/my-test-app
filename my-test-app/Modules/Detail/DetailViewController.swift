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
    
    // MARK: - Override func
    
    override func setupConstraints() {
        super.setupConstraints()
        switch viewModel.getStyle() {
        case .image:
            view.addSubview(scrollView)
            scrollView.snp.makeConstraints({
                $0.top.equalTo(view.snp.top)
                $0.leading.trailing.bottom.equalToSuperview()
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
}
