//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Uriel Hernandez Gonzalez on 22/02/22.
//

import Foundation

class HomeViewModel {

    private let formatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.decimalSeparator = ","
        return numberFormatter
    }()

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
}
