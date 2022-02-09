//
//  WatchListViewController.swift
//  CryptoTracker
//
//  Created by Uriel Hernandez Gonzalez on 02/02/22.
//

import UIKit

class WatchListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.topViewController?.title = "Watchlist"
    }

    private func setupUI() {
        tableView.register(UINib(nibName: WatchListTableViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: WatchListTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
    }

}

// MARK: - Extensions
extension WatchListViewController: UITableViewDelegate,
                                    UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WatchListTableViewCell.identifier)
                            as? WatchListTableViewCell
        cell?.onClicked = {
            // TODO: Redirecto to view
        }
        return cell!
    }
}
