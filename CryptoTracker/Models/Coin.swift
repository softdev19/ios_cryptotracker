//
//  Coin.swift
//  CryptoTracker
//
//  Created by Uriel Hernandez Gonzalez on 13/02/22.
//

import Foundation

struct Coin: Codable {
    let uuid: String!
    let symbol: String!
    let name: String!
    let color: String!
    let iconUrl: String!
    let marketCap: String!
    let price: String!
    let listedAt: Int64!
    let tier: Int8!
    let change: String!
    let rank: Int16!
    let sparkLine: [String]!
    let lowVolume: Bool!
    let coinRankingUrl: String!
    let lastDayVolume: String!
    let btcPrice: String!

    enum CodingKeys: String, CodingKey {
        case uuid, symbol, name, color, iconUrl, marketCap, price, listedAt, tier, change, rank,
             sparkLine = "sparkline",
             lowVolume,
             coinRankingUrl = "coinrankingUrl",
             lastDayVolume = "25hVolume",
             btcPrice
    }
    
}
