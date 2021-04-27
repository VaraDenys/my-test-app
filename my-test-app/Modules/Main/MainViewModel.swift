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
                res.forEach { content in
                    if let images = content.images {
                        self?.service.getImages(for: images) { (result) in
                            switch result {
                            case .success(let images):
                                var resultModels: [MainCellModel] = []
                                images.forEach { (image) in
                                    resultModels.append(MainCellModel(text: nil, image: image))
                                }
                                let model = MainTableViewModel(sectionTitle: content.sectionTitle, cellModel: resultModels)
                                self?.tableViewModels.append(model)
                                self?.onDidChange()
                            case .failure(_): break
//                                to do something with error
                            }
                        }
                    } else {
                        var cellModels: [MainCellModel] = []
                        content.texts?.forEach({ (string) in
                            cellModels.append(MainCellModel(text: string, image: nil))
                        })
                        let model = MainTableViewModel(sectionTitle: content.sectionTitle, cellModel: cellModels)
                        self?.tableViewModels.append(model)
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
            onDidSelectCell(vc, .text)
        case .image:
            let vc = Screens.detail(string: model.string, style: .image)
            vc.modalPresentationStyle = .fullScreen
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
        return tableViewModels[section].cellModel.count
    }
    
    public func getItem(for indexPath: IndexPath) -> MainCellModel {
        let model = self.tableViewModels[indexPath.section]
        guard let image = model.cellModel[indexPath.row].image else {
            return MainCellModel(text: model.cellModel[indexPath.row].text, image: nil)
        }
        return MainCellModel(text: nil, image: image)
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
