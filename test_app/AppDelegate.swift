//
//  AppDelegate.swift
//  test_app
//
//  Created by Deny Vorko on 19.06.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() else {
            return false
        }
        let navigationController = UINavigationController(rootViewController: vc)
        
        let frame = UIScreen.main.bounds
        let window = UIWindow(frame: frame)
        self.window = window
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        return true
    }
}

