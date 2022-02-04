//
//  WatchListViewController.swift
//  CryptoTracker
//
//  Created by Uriel Hernandez Gonzalez on 02/02/22.
//

import UIKit

class WatchListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.topViewController?.title = "Watchlist";
    }


}
