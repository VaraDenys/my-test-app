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
    
    //    MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.resumeFetch()
    }
    
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
    
    override func binding() {
        super.binding()
        self.viewModel.onDidChange = { [weak self] style in
            switch style {
            case .text:
                self?.labelView.text = self?.viewModel.getText()
            case .image:
                DispatchQueue.main.async {
                    self?.scrollView.configure(image: self?.viewModel.getImage() ?? UIImage())
                }
            }
        }
    }
    
//    MARK: - User interaction
    
    @objc private func swipeDown() {
        self.dismiss(animated: true, completion: nil)
    }
}
