//
//  CoinList.swift
//  CryptoTracker
//
//  Created by Uriel Hernandez Gonzalez on 13/02/22.
//

import Foundation

struct CoinList: Codable {
    let coins: [Coin]!

    enum CodingKeys: String, CodingKey {
        case coins
    }
    
    static func fetchCoins(completion: @escaping (_ response: GenericResponse<CoinList>?) -> Void) {
        API.shared.fetchCoins { response in
            guard let response2 = response,
                  response2.status == "success",
                  response2.data != nil else {
                      completion(response)
                      return
                  }
            
            completion(response2)
        }
    }

    static func searchForCoins(query: String, completion: @escaping (_ response: GenericResponse<CoinList>?) -> Void) {
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
