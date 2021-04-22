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
    
    static func main() -> UIViewController {
        let vm = MainViewModel()
        return MainViewController(viewModel: vm)
    }
}
