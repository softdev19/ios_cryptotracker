//
//  AppDelegate.swift
//  CryptoTracker
//
//  Created by Uriel Hernandez Gonzalez on 31/01/22.
//

import UIKit
import SDWebImage
import SDWebImageSVGCoder

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Adding svg support for SDWebImage
        let SVGCoder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(SVGCoder)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIUtils.shared.setupNagivation()
        window?.makeKeyAndVisible()
        return true
    }

}
