//
//  WatchListViewController.swift
//  CryptoTracker
//
//  Created by Uriel Hernandez Gonzalez on 02/02/22.
//
// swiftlint:disable force_try

import UIKit
import RealmSwift
import SkeletonView

class WatchListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var favoriteCoins: Results<FavoriteCoin>?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.topViewController?.title = "Watchlist"
        showTableSekeleton()
        DispatchQueue.global(qos: .userInitiated).async {
            self.fetchFavorites()
        }
    }

    private func setupUI() {
        tableView.register(WatchListTableViewCell.nibName,
                           forCellReuseIdentifier: WatchListTableViewCell.viewIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }

    private func showTableSekeleton() {
        tableView.showGradientSkeleton(usingGradient: .init(baseColor: UIColor(named: "MainColor")!,
                                                            secondaryColor: UIColor(named: "SecondaryColor")!),
                                       animated: true, delay: 0, transition: .crossDissolve(0.25))
    }

    private func removeSkeleton() {
        tableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.2))
    }

    private func fetchFavorites() {
        let realm = try! Realm()
        favoriteCoins = realm.objects(FavoriteCoin.self)
        DispatchQueue.main.async {
            self.removeSkeleton()
        }
    }

}

// MARK: - Extensions
extension WatchListViewController: UITableViewDelegate,
                                    SkeletonTableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return favoriteCoins?.count ?? 10
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WatchListTableViewCell.viewIdentifier)
                            as? WatchListTableViewCell
        cell?.delegate = self
        return cell!
    }
    func collectionSkeletonView(_ skeletonView: UITableView,
                                cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return WatchListTableViewCell.viewIdentifier
    }
}

extension WatchListViewController: WatchListTableViewCellDelegate {
    func onClicked(coinId: String) {
        // TODO: Redirect to view
    }
}
