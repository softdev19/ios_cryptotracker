//
//  Exchange.swift
//  CryptoTracker
//
//  Created by Uriel Hernandez Gonzalez on 12/02/22.
//

import Foundation

struct Exchange: Codable {
    let uuid: String!
    let name: String!
    let iconUrl: String!
    let verified: Bool!
    let recommended: Bool!
    let numberOfMarkets: Int16!
    let coinRankingUrl: String!
    let btcPrice: String!
    let rank: Int8!
    let lastDayVolume: String!
    let price: String!

    enum CodingKeys: String, CodingKey {
        case uuid, name, iconUrl, verified, recommended, numberOfMarkets,
            coinRankingUrl = "coinrankingUrl",
            btcPrice, rank,
            lastDayVolume = "24hVolume",
            price
    }

}

struct RapidStats: Codable {
    let lastDayVolume: String!
    let total: Int16!
    
    enum CodingKeys: String, CodingKey {
        case lastDayVolume = "24hVolume", total
    }
}
