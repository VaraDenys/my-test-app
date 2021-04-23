//
//  MainViewModel.swift
//  my-test-app
//
//  Created by Deny Vorko on 22.04.2021.
//

import UIKit

class MainViewModel: ViewModel {
    
    // MARK: - Private properties
    
    private let service = MyJsonService()
    private var tableViewModels: [MainTableViewModel] = []
    
    // MARK: - Public properties
    
    var onDidChange: (() -> Void)!
    var onDidError: ((ApiErrorType) -> Void)!
    var onDidSelectCellImage: ((UIViewController) -> Void)!
    var onDidSelectCellText: ((UIViewController) -> Void)!
    
    // MARK: - Public func
    
    public func resumeFetch() {
        service.getContent { [weak self] result in
            switch result {
            case .success(let res):
                var imagesArray: [UIImage]? = nil
                res.forEach { content in
                    if let images = content.images {
                        self?.service.getImages(for: images) { resultImages in
                            switch resultImages {
                            case .success(let images):
                                imagesArray = images
                                self?.tableViewModels.append(
                                    MainTableViewModel(
                                        sectionTitle: content.sectionTitle,
                                        images: imagesArray,
                                        texts: nil)
                                )
                                self?.onDidChange()
                            case .failure(let error):
                                debugPrint(error.localizedDescription)
                            }
                        }
                    } else {
                        self?.tableViewModels.append(
                            MainTableViewModel(
                                sectionTitle: content.sectionTitle,
                                images: nil,
                                texts: content.texts)
                        )
                        self?.onDidChange()
                    }
                }
            case .failure(let error):
                self?.onDidError(error)
            }
        }
    }
    
    public func didSelectCell(indexPath: IndexPath) {
        let model = self.getItem(for: indexPath)
        if model.image != nil {
            let vc = Screens.detail(model: model, style: .image)
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .coverVertical
            onDidSelectCellImage(vc)
        } else {
            let vc = Screens.detail(model: model, style: .text)
            onDidSelectCellImage(vc)
        }
    }
    
    public func getSection() -> Int {
        return tableViewModels.count
    }
    
    public func getSectionTitle(for section: Int) -> String {
        return tableViewModels[section].sectionTitle
    }
    
    public func getHeightCell(for section: Int) -> CGFloat {
        if tableViewModels[section].sectionTitle == "Texts" {
            return UITableView.automaticDimension
        } else {
            return 70
        }
    }
    
    public func getCount(for section: Int) -> Int {
        return (tableViewModels[section].images?.count ?? tableViewModels[section].texts?.count) ?? 0
    }
    
    public func getItem(for indexPath: IndexPath) -> MainCellModel {
        let model = self.tableViewModels[indexPath.section]
        guard model.images != nil else {
            return MainCellModel(text: model.texts?[indexPath.row], image: nil)
        }
        return MainCellModel(
            text: nil,
            image: model.images?[indexPath.row]
        )
    }
}
