//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Uriel Hernandez Gonzalez on 22/02/22.
//

import Foundation
import UIKit

class HomeViewModel {
    var stats: Box<Stats?> = Box(nil)
    var exchanges: Box<ExchangesList?> = Box(nil)
}

extension HomeViewModel {

    func fetchStats() {
        Stats.fetchStats { response in
            guard let stats = response else {
                return
            }

            if stats.status != "success" {
                return
            }

            self.stats.value = stats.data!
        }
    }

    func fetchExchanges() {
        ExchangesList.fetchExchanges { response in
            guard let exchanges = response else {
                return
            }

            if exchanges.status != "success" {
                return
            }

            self.exchanges.value = exchanges.data!
        }
    }

    func getStatsData() -> Stats {

        guard let stats = stats.value,
              let totalCoins = stats.totalCoins,
              let totalMarkets = stats.totalMarkets,
              let exchanges = stats.totalExchanges,
              let marketCap = stats.totalMarketCap,
              let lastDayVolumeStat = stats.lastDayVolume else {
                  return Stats(totalCoins: nil,
                               totalMarkets: nil,
                               totalExchanges: nil,
                               totalMarketCap: nil,
                               lastDayVolume: nil)
              }

        return Stats(totalCoins: totalCoins,
                     totalMarkets: totalMarkets,
                     totalExchanges: exchanges,
                     totalMarketCap: marketCap,
                     lastDayVolume: lastDayVolumeStat)
    }
}
