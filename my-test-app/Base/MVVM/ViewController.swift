//
//  ViewController.swift
//  my-test-app
//
//  Created by Deny Vorko on 22.04.2021.
//

import UIKit

class ViewController<VM: ViewModel>: UIViewController {
    
// MARK: - Properties
    
    public var viewModel: VM
    public var fromStoryboard: Bool = false
    
// MARK: - Constructor
    
    public init(viewModel: VM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.fromStoryboard = true
        self.viewModel = MainViewModel() as! VM
        super.init(coder: coder)
    }
    
// MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard fromStoryboard else {
            setupConstraints()
            setupView()
            setupNavigationController()
            binding()
            return
        }

        setupNavigationController()
        setupViewFromNib()
        binding()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        setupNavigationController()
    }
// MARK: - Public func
    
    public func setupConstraints() {}
    public func setupView() {
        self.view.backgroundColor = .white
    }
    public func setupNavigationController() {}
    public func binding() {}
    public func setupViewFromNib() {}
}
