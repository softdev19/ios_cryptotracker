//
//  API.swift
//  CryptoTracker
//
//  Created by Uriel Hernandez Gonzalez on 09/02/22.
//

import Foundation
import Alamofire

class API {

    static let shared = API()

    let coinRankingBaseUrl: String = "https://api.coinranking.com/v2/"

    public func fetchStats(completion: @escaping (_ response: GenericResponse<Stats>?) -> Void) {
        let url = "\(coinRankingBaseUrl)stats"

        let headers: HTTPHeaders = [
            "x-access-token": "coinranking8b2327adeb90d342ee607da8b08f4f695318ade2e7ffaa73"
        ]

        requestGet(url: url, headers: headers, completion: completion)
    }

    private func requestGet<T>(url: String,
                               headers: HTTPHeaders,
                               completion: @escaping (_ data: T?) -> Void) where T: Codable {

        AF.request(url, method: .get, headers: headers).responseDecodable { (response: DataResponse<T, AFError>) in
            debugPrint(response)
            guard response.error == nil else {
                completion(nil)
                return
            }

            completion(response.value)
        }
    }

}
