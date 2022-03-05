//
//  HomeViewController.swift
//  CryptoTracker
//
//  Created by Uriel Hernandez Gonzalez on 31/01/22.
//
// swiftlint:disable force_cast

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

    let homeViewModel = HomeViewModel()

    private let formatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.decimalSeparator = ","
        return numberFormatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCards()
        setupTable()
        bindData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.topViewController?.title = "Home"
        showSkeletonView()
        DispatchQueue.global(qos: .userInitiated).async {
            self.homeViewModel.fetchStats()
        }
        DispatchQueue.global(qos: .userInitiated).async {
            self.homeViewModel.fetchExchanges()
        }
    }

    private func bindData() {
        homeViewModel.exchanges.bind { exchanges in
            if exchanges != nil {
                DispatchQueue.main.async {
                    self.tableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.2))
                }
            }
        }
        homeViewModel.stats.bind { stats in
            if stats != nil {
                DispatchQueue.main.async {
                    self.showData()
                }
            }
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

    private func showData() {

        let statsData = homeViewModel.getStatsData()

        hideSkeletonView()
        coinsLbl.countFromZeroTo(CGFloat(statsData.totalCoins), withDuration: 0.7)
        marketsLbl.countFromZeroTo(CGFloat(statsData.totalMarkets), withDuration: 0.7)
        exchangesLbl.countFromZeroTo(CGFloat(statsData.totalExchanges), withDuration: 0.7)
        marketCapLbl.countFromZeroTo(CGFloat(formatter.number(from: statsData.totalMarketCap)!), withDuration: 0.7)
        lastDayVolume.countFromZeroTo(CGFloat(formatter.number(from: statsData.lastDayVolume)!), withDuration: 0.7)

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
        cell?.displayExchangeData(for: (homeViewModel.exchanges.value?.exchanges?[indexPath.row])!)
        cell?.delegate = self
        return cell!
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.exchanges.value?.exchanges.count ?? 0
    }

    func collectionSkeletonView(_ skeletonView: UITableView,
                                cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return ExchangesTableViewCell.identifier
    }

}

extension HomeViewController: ExchangesTableViewCellDelegate {
    func onClicked(exchangeId: String) {
        // TODO: Navifate to other view
    }
}
