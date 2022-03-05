//
//  SearchViewController.swift
//  CryptoTracker
//
//  Created by Uriel Hernandez Gonzalez on 02/02/22.
//

import UIKit
import MaterialComponents.MDCOutlinedTextField
import SkeletonView

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTextField: MDCOutlinedTextField!
    @IBOutlet weak var collectionView: UICollectionView!

    private let numberOfColumns: CGFloat = 2
    private let collectionInsets: CGFloat = 10
    private let collectionSideContraints: CGFloat = 20
    private var screenWidth: CGFloat = UIScreen.main.bounds.width
    let searchViewModel = SearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        setupSearchField()
        setupCollectionView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.topViewController?.title = "Search a Coin"
        showSkeletonView()
        DispatchQueue.global(qos: .userInitiated).async {
            self.searchViewModel.fetchCoins()
        }
    }
}

// MARK: - Extensions
private extension SearchViewController {
    func bindData() {
        searchViewModel.coins.bind { coins in
            if coins != nil {
                DispatchQueue.main.async {
                    self.collectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.2))
                }
            }
        }
    }

    func setupSearchField() {
        searchTextField.label.text = "Search"
        searchTextField.setOutlineColor(UIColor(named: "MainColor")!, for: .normal)
        searchTextField.setOutlineColor(UIColor(named: "MainColor")!, for: .editing)
        searchTextField.setNormalLabelColor(UIColor(named: "MainColor")!, for: .normal)
        searchTextField.setFloatingLabelColor(UIColor(named: "MainColor")!, for: .editing)
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.tintColor = UIColor(named: "MainColor")
        searchTextField.leadingView = imageView
        searchTextField.leadingViewMode = .always
        searchTextField.delegate = self
    }

    func setupCollectionView() {
        collectionView.register(CoinCollectionViewCell.nibName,
                                forCellWithReuseIdentifier: CoinCollectionViewCell.viewIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func showSkeletonView() {
        collectionView.showGradientSkeleton(usingGradient: .init(baseColor: UIColor(named: "MainColor")!,
                                                                 secondaryColor: UIColor(named: "SecondaryColor")!),
                                                                 animated: true,
                                                                 delay: 0,
                                                                 transition: .crossDissolve(0.25))
    }
}

// MARK: - Delegates
extension SearchViewController: UICollectionViewDelegate,
                                    SkeletonCollectionViewDataSource,
                                UICollectionViewDelegateFlowLayout {

    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return CoinCollectionViewCell.viewIdentifier
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchViewModel.coins.value?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoinCollectionViewCell.viewIdentifier,
                                                      for: indexPath) as? CoinCollectionViewCell
        cell?.delegate = self
        cell?.coindId = searchViewModel.coins.value![indexPath.row].uuid
        cell?.displayData(name: searchViewModel.coins.value![indexPath.row].name,
                          imgUrl: searchViewModel.coins.value![indexPath.row].iconUrl)
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

extension SearchViewController: CoinCollectionViewCellDelegate {
    func onClicked(coindId: String) {
        // TODO: Redirect to other view
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            return false
        }
        textField.resignFirstResponder()
        showSkeletonView()

        if text.isEmpty {
            searchViewModel.fetchCoins()
        } else {
            searchViewModel.filterResults(query: text)
        }

        return true
    }
}
