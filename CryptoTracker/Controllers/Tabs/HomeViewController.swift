//
//  HomeViewController.swift
//  CryptoTracker
//
//  Created by Uriel Hernandez Gonzalez on 31/01/22.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.topViewController?.title = "Home";
    }


}
