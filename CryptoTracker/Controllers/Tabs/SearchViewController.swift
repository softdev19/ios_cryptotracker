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

    private let numberOfColumns: CGFloat = 2
    private let collectionInsets: CGFloat = 10
    private let collectionSideContraints: CGFloat = 20
    private var screenWidth: CGFloat = UIScreen.main.bounds.width
    private var coins: [Coin]! = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchField()
        setupCollectionView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.topViewController?.title = "Search a Coin"
        DispatchQueue.global(qos: .userInitiated).async {
            self.fetchCoins()
        }
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
        collectionView.register(UINib(nibName: CoinCollectionViewCell.identifier, bundle: nil),
                                forCellWithReuseIdentifier: CoinCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func fetchCoins() {
        CoinList.fetchCoins { response in
            guard let coinList = response else {
                return
            }

            if coinList.status != "success" {
                return
            }

            DispatchQueue.main.async {
                self.coins = coinList.data?.coins
                self.collectionView.reloadData()
            }
        }
    }
}

// MARK: - Extensions
extension SearchViewController: UICollectionViewDelegate,
                                    UICollectionViewDataSource,
                                    UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coins.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoinCollectionViewCell.identifier,
                                                      for: indexPath) as? CoinCollectionViewCell
        cell?.onClicked = {
            // TODO: Navigate to other view
        }
        return cell!
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = screenWidth - collectionSideContraints - (numberOfColumns - 1) * collectionInsets
        let cellWidth = (width / numberOfColumns)
        return CGSize(width: cellWidth, height: cellWidth)
    }

}
