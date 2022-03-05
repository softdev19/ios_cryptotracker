//
//  SearchViewModel.swift
//  CryptoTracker
//
//  Created by Uriel Hernandez Gonzalez on 04/03/22.
//

import Foundation

class SearchViewModel {
    var coins: Box<[Coin]?> = Box(nil)
}

extension SearchViewModel {

    func fetchCoins() {
        CoinList.fetchCoins { response in
            guard let coinList = response,
                  coinList.status == "success" else {
                      return
                  }
            self.coins.value = coinList.data?.coins
        }
    }
    
    func filterResults(query: String) {
        DispatchQueue.global(qos: .userInitiated).async {
            CoinList.searchForCoins(query: query) { response in
                guard let coins = response,
                      coins.status == "success" else {
                          return
                      }

                self.coins.value = coins.data?.coins
            }
        }
    }
}
