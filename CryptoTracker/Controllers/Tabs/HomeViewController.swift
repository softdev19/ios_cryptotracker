//
//  HomeViewController.swift
//  CryptoTracker
//
//  Created by Uriel Hernandez Gonzalez on 31/01/22.
//

import UIKit
import MaterialComponents.MaterialCards

class HomeViewController: UIViewController {

    @IBOutlet weak var totalCoinsCard: MDCCard!
    @IBOutlet weak var marketsCard: MDCCard!
    @IBOutlet weak var exchangesCard: MDCCard!
    @IBOutlet weak var marketCapCard: MDCCard!
    @IBOutlet weak var lastDayCard: MDCCard!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCards()
        setupTable()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.topViewController?.title = "Home"
    }

    private func setupCards() {
        for card in [totalCoinsCard, marketsCard, exchangesCard, marketCapCard, lastDayCard] {
            card?.setShadowColor(UIColor(named: "TextColor"), for: .normal)
            card?.setShadowElevation(ShadowElevation(rawValue: 10), for: .normal)
            card?.cornerRadius = 20
        }
    }

    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

}

// MARK: - Extensions

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO: Table Cell
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO: Return length of exchanges array
        return 0
    }
}
