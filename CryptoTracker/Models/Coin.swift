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
    let iconUrl: String!
    let price: String!

    enum CodingKeys: String, CodingKey {
        case uuid, symbol, name, iconUrl, price
    }
    
}
