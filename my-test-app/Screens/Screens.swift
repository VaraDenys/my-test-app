//
//  File.swift
//  my-test-app
//
//  Created by Deny Vorko on 22.04.2021.
//

import Foundation
import UIKit

struct Screens {

// MARK: - Func
    
    
    static func quiz() -> UIViewController {
        let vm = QuizViewModel()
        return QuizViewController(viewModel: vm)
    }
    
    static func main() -> UIViewController {
        let vm = MainViewModel()
        return MainViewController(viewModel: vm)
    }
    
    static func detail(model: MainCellModel, style: DetailVCStyle) -> UIViewController {
        let vm = DetailViewModel(model: model, style: style)
        let vc = DetailViewController(viewModel: vm)
        return vc
    }
}
