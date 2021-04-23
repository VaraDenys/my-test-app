//
//  MainViewController.swift
//  my-test-app
//
//  Created by Deny Vorko on 22.04.2021.
//

import UIKit
import SnapKit

class MainViewController: ViewController<MainViewModel> {
    
    // MARK: - Private properties
    
    private lazy var tableView = UITableView(frame: .zero, style: .grouped)
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.resumeFetch()
    }
    
    // MARK: - Override func
    
    override func setupConstraints() {
        super.setupConstraints()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }
    
    override func setupView() {
        super.setupView()
        
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func setupNavigationController() {
        super.setupNavigationController()
        
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Main"
    }
    
    override func binding() {
        super.binding()
        
        viewModel.onDidChange = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.onDidError = { _ in
            // do something with error
        }
        
        viewModel.onDidSelectCellImage = { [weak self] vc in
            self?.navigationController?.present(vc, animated: true, completion: nil)
        }
        
        viewModel.onDidSelectCellText = { [weak self] vc in
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - Extension

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCount(for: section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.getSectionTitle(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: "cell",
                    for: indexPath) as? MainTableViewCell else {
            fatalError("No find cell with identifier - \"cell\"")
        }
        
        let item = viewModel.getItem(for: indexPath)
        
        if item.image != nil {
            cell.configure(model: item, style: .image)
        } else {
            cell.configure(model: item, style: .text)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.getHeightCell(for: indexPath.section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectCell(indexPath: indexPath)
    }
}
