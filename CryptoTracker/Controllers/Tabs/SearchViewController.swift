//
//  SearchViewController.swift
//  CryptoTracker
//
//  Created by Uriel Hernandez Gonzalez on 02/02/22.
//

import UIKit
import MaterialComponents.MDCOutlinedTextField

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTextField: MDCOutlinedTextField!
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchField()
        setupCollectionView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.topViewController?.title = "Search a Coin"
    }

    private func setupSearchField() {
        searchTextField.label.text = "Search"
        searchTextField.setOutlineColor(UIColor(named: "MainColor")!, for: .normal)
        searchTextField.setOutlineColor(UIColor(named: "MainColor")!, for: .editing)
        searchTextField.setNormalLabelColor(UIColor(named: "MainColor")!, for: .normal)
        searchTextField.setFloatingLabelColor(UIColor(named: "MainColor")!, for: .editing)
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.tintColor = UIColor(named: "MainColor")
        searchTextField.leadingView = imageView
        searchTextField.leadingViewMode = .always
    }

    private func setupCollectionView() {
        // TODO: collection view delegate and data source
    }
}
