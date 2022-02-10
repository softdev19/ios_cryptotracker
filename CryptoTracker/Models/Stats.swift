//
//  Stats.swift
//  CryptoTracker
//
//  Created by Uriel Hernandez Gonzalez on 09/02/22.
//

import Foundation

struct Stats: Codable {
    let totalCoins: Int!
    let totalMarkets: Int!
    let totalExchanges: Int!
    let totalMarketCap: String!
    let lastDayVolume: String!

    enum CodingKeys: String, CodingKey {
        case totalCoins, totalMarkets, totalExchanges, totalMarketCap,
            lastDayVolume = "total24hVolume"
    }

    static func fetchStats(completion: @escaping (_ response: GenericResponse<Stats>?) -> Void) {
        API.shared.fetchStats { response in
            guard let response = response,
                  response.status == "success",
                  response.data != nil else {
                      completion(response)
                      return
                  }

            completion(response)
        }
    }
}
