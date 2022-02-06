//
//  HomeViewController.swift
//  CryptoTracker
//
//  Created by Uriel Hernandez Gonzalez on 31/01/22.
//

import UIKit
import MaterialComponents.MaterialCards
import EFCountingLabel

class HomeViewController: UIViewController {

    @IBOutlet weak var totalCoinsCard: MDCCard!
    @IBOutlet weak var marketsCard: MDCCard!
    @IBOutlet weak var exchangesCard: MDCCard!
    @IBOutlet weak var marketCapCard: MDCCard!
    @IBOutlet weak var lastDayCard: MDCCard!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var coinsLbl: EFCountingLabel!
    @IBOutlet weak var marketsLbl: EFCountingLabel!
    @IBOutlet weak var exchangesLbl: EFCountingLabel!
    @IBOutlet weak var marketCapLbl: EFCountingLabel!
    @IBOutlet weak var lastDayVolume: EFCountingLabel!

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

        coinsLbl.countFromZeroTo(1000, withDuration: 1)
        marketsLbl.countFromZeroTo(1000, withDuration: 1)
        exchangesLbl.countFromZeroTo(1000, withDuration: 1)
        marketCapLbl.countFromZeroTo(1000, withDuration: 1)
        lastDayVolume.countFromZeroTo(1000, withDuration: 1)
    }

    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "ExchangesTableViewCell", bundle: nil),
                           forCellReuseIdentifier: ExchangesTableViewCell.identifier)
    }

}

// MARK: - Extensions

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExchangesTableViewCell.identifier)
                        as? ExchangesTableViewCell
        cell?.onClicked = {
            print("TODO: Show modal")
        }
        return cell!
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

}
