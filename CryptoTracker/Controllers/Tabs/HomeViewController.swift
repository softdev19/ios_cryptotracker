//
//  HomeViewController.swift
//  CryptoTracker
//
//  Created by Uriel Hernandez Gonzalez on 31/01/22.
//

import UIKit
import MaterialComponents.MaterialCards
import EFCountingLabel
import SkeletonView

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

    private let formatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.decimalSeparator = ","
        return numberFormatter
    }()
    private var exchanges: [Exchange]! = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCards()
        setupTable()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.topViewController?.title = "Home"
        showSkeletonView()
        DispatchQueue.global(qos: .userInitiated).async {
            self.fetchStats()
        }
        DispatchQueue.global(qos: .userInitiated).async {
            self.fetchExchanges()
        }
    }

    private func showSkeletonView() {
        for view in [coinsLbl, marketsLbl, exchangesLbl, marketCapLbl, lastDayVolume, tableView] {
            view?.showGradientSkeleton(usingGradient: .init(baseColor: UIColor(named: "MainColor")!,
                                                             secondaryColor: UIColor(named: "SecondaryColor")!),
                                        animated: true, delay: 0, transition: .crossDissolve(0.25))
        }
    }

    private func hideSkeletonView() {
        for label in [coinsLbl, marketsLbl, exchangesLbl, marketCapLbl, lastDayVolume] {
            label?.hideSkeleton(reloadDataAfter: false, transition: .crossDissolve(0.2))
        }
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
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "ExchangesTableViewCell", bundle: nil),
                           forCellReuseIdentifier: ExchangesTableViewCell.identifier)
    }

    private func fetchStats() {
        Stats.fetchStats { response in
            guard let stats = response else {return}

            if stats.status != "success" {
                return
            }

            DispatchQueue.main.async {
                self.showData(for: stats.data!)
            }
        }
    }

    private func fetchExchanges() {
        ExchangesList.fetchExchanges { response in
            guard let exchanges = response else {
                return
            }

            if exchanges.status != "success" {
                return
            }

            self.exchanges = exchanges.data?.exchanges
            self.tableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.2))
        }
    }

    private func showData(for stats: Stats) {

        guard let totalCoins = stats.totalCoins,
              let totalMarkets = stats.totalMarkets,
              let exchanges = stats.totalExchanges,
              let marketCap = stats.totalMarketCap,
              let lastDayVolumeStat = stats.lastDayVolume else {
                  return
              }

        hideSkeletonView()
        coinsLbl.countFromZeroTo(CGFloat(totalCoins), withDuration: 0.7)
        marketsLbl.countFromZeroTo(CGFloat(totalMarkets), withDuration: 0.7)
        exchangesLbl.countFromZeroTo(CGFloat(exchanges), withDuration: 0.7)
        marketCapLbl.countFromZeroTo(CGFloat(formatter.number(from: marketCap)!), withDuration: 0.7)
        lastDayVolume.countFromZeroTo(CGFloat(formatter.number(from: lastDayVolumeStat)!), withDuration: 0.7)

        for label in [coinsLbl, marketsLbl, exchangesLbl, marketCapLbl, lastDayVolume] {
            label?.setUpdateBlock({ value, sender in
                sender.text = String(format: "%.0f", locale: Locale.current, value)
            })
        }
    }

}

// MARK: - Extensions

extension HomeViewController: UITableViewDelegate, SkeletonTableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExchangesTableViewCell.identifier, for: indexPath)
                        as? ExchangesTableViewCell
        cell?.displayExchangeData(for: exchanges[indexPath.row])
        cell?.onClicked = {
            print("TODO: Show modal")
        }
        return cell!
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchanges.count
    }

    func collectionSkeletonView(_ skeletonView: UITableView,
                                cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return ExchangesTableViewCell.identifier
    }

}
