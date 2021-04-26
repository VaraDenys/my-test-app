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
    private var content: [Content] = []
    private var tableViewModels: [MainTableViewModel] = []
    
    // MARK: - Public properties
    
    var onDidChange: (() -> Void)!
    var onDidError: ((ApiErrorType) -> Void)!
    var onDidSelectCell: ((DetailViewController, ConstantStyle) -> Void)!
    var onDidSelectCellText: ((UIViewController) -> Void)!
    
    // MARK: - Public func
    
    public func resumeFetch() {
        service.getContent { [weak self] result in
            switch result {
            case .success(let res):
                self?.content = res
                var imagesArray: [UIImage] = []
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
        let model = self.getStringAndStyle(from: indexPath)
        switch model.style {
        case .text:
            let vc = Screens.detail(string: model.string, style: .text)
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .partialCurl
            onDidSelectCell(vc, .text)
        case .image:
            let vc = Screens.detail(string: model.string, style: .image)
            onDidSelectCell(vc, .image)
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
    
//    MARK: - Private func
    
    private func getStringAndStyle(from indexPath: IndexPath) -> (string: String, style: ConstantStyle) {
        let cont = self.content[indexPath.section]
        guard let texts = cont.texts else {
            return (cont.images?[indexPath.row] ?? "", .image)
        }
        return (texts[indexPath.row], .text)
    }
}
