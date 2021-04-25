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
    
    static func mainNib() -> UIViewController {
        let vc = UINib(nibName: "MainViewControllerXib", bundle: nil).instantiate(withOwner: nil, options: nil).first as! MainViewController
        return vc
    }
    
    static func detail(string: String, style: ConstantStyle) -> DetailViewController {
        let vm = DetailViewModel(string: string, style: style)
        return DetailViewController(viewModel: vm)
    }
}
