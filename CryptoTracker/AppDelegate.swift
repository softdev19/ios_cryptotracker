//
//  AppDelegate.swift
//  CryptoTracker
//
//  Created by Uriel Hernandez Gonzalez on 31/01/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIUtils.shared.setupNagivation()
        window?.makeKeyAndVisible()
        return true
    }
    



}

