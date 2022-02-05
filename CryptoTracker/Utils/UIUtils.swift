//
//  UIUtils.swift
//  CryptoTracker
//
//  Created by Uriel Hernandez Gonzalez on 02/02/22.
//

import Foundation
import UIKit


final class UIUtils {
    let textAttributes: [NSAttributedString.Key : Any] = [.font :  UIFont(name: "RobotoMono-Medium", size: 12)]
    let largeTitlesAttributes: [NSAttributedString.Key : Any] = [.font : UIFont(name: "RobotoMono-Bold", size: 34), .foregroundColor : UIColor(named: "TextColor")]
    static let shared = UIUtils()
}

//MARK: - Navigation Configuration
extension UIUtils {

    public func setupNagivation() -> UINavigationController{
        let tabController = setupTabBar()
        let navController = UINavigationController(rootViewController: tabController)
        navController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navController.navigationBar.isTranslucent = true
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationBar.barStyle = .black
        navController.navigationBar.shadowImage = UIImage()
        navController.navigationBar.largeTitleTextAttributes = largeTitlesAttributes
        return navController
    }
    
    public func setupTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        
        tabBar.tabBar.backgroundImage = UIImage()
        tabBar.tabBar.isTranslucent = true
        tabBar.tabBar.backgroundColor = UIColor(named: "MainColor")
        tabBar.tabBar.tintColor = UIColor(named: "TextColor")
        tabBar.tabBar.unselectedItemTintColor = UIColor(named: "SecondaryColor")
        tabBar.tabBar.layer.cornerRadius = 30
        tabBar.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.tabBar.layer.masksToBounds = true
        
        let homeVc = HomeViewController()
        let searchVc = SearchViewController()
        let watchVc = WatchListViewController()
        
        let homeIcon = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        homeIcon.setTitleTextAttributes(textAttributes, for: .normal)
        let searchIcon = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        searchIcon.setTitleTextAttributes(textAttributes, for: .normal)
        let watchIcon = UITabBarItem(title: "Watchlist", image: UIImage(systemName: "heart"), tag: 2)
        watchIcon.setTitleTextAttributes(textAttributes, for: .normal)
        
        homeVc.tabBarItem = homeIcon
        searchVc.tabBarItem = searchIcon
        watchVc.tabBarItem = watchIcon
        
        tabBar.viewControllers = [homeVc, searchVc, watchVc]
        
        return tabBar
    }
}
