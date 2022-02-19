//
//  CoinQuery.swift
//  CryptoTracker
//
//  Created by Uriel Hernandez Gonzalez on 18/02/22.
//

import Foundation

struct CoinQuery: Codable {
    let coins: [Coin]

    enum CodingKeys: String, CodingKey {
        case coins
    }
    
    static func searchForCoins(query: String, completion: @escaping (_ response: GenericResponse<CoinQuery>?) -> Void) {
        API.shared.searchForCoins(query: query) { response in
            guard let response2 = response,
                  response2.status == "success",
                  response2.data != nil else {
                      completion(response)
                      return
                  }
            
            completion(response2)
        }
    }
}
