//
//  ExchangesList.swift
//  CryptoTracker
//
//  Created by Uriel Hernandez Gonzalez on 12/02/22.
//

import Foundation

struct ExchangesList: Codable {
    let stats: RapidStats!
    let exchanges: [Exchange]!
    
    enum CodinKeys: String, CodingKey {
        case stats, exchanges
    }
    
    static func fetchExchanges(completion: @escaping (_ response: GenericResponse<ExchangesList>?) -> Void) {
        API.shared.fetchExchanges { response in
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
