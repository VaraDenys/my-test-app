//
//  ViewController.swift
//  my-test-app
//
//  Created by Deny Vorko on 22.04.2021.
//

import UIKit

class ViewController<VM: ViewModel>: UIViewController {
    
// MARK: - Properties
    
    public let viewModel: VM
    
// MARK: - Constructor
    
    public init(viewModel: VM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
        setupView()
    }
// MARK: - Public func
    
    public func setupConstraints() {}
    public func setupView() {}
}
