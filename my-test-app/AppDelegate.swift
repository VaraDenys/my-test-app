//
//  AppDelegate.swift
//  my-test-app
//
//  Created by Deny Vorko on 22.04.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
// MARK: - Properties
        
        var window: UIWindow?

// MARK: - Life cycle
        
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            
            buildview()
            
            return true
        }
        
// MARK: - Func
        
        private func buildview() {
            let mainView = Screens.quiz()
            let navigationController = UINavigationController(
                rootViewController: mainView
            )
            let frame = UIScreen.main.bounds
            let window = UIWindow(frame: frame)
            self.window = window
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
}

