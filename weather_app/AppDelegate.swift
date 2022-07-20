//
//  AppDelegate.swift
//  weather_app
//
//  Created by Deny Vorko on 20.07.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let frame = UIScreen.main.bounds
        let vc = ViewController()
        let navVC = UINavigationController(rootViewController: vc)
        self.window = UIWindow(frame: frame)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        return true
    }
}

