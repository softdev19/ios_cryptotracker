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
    let rapidApiBaseUrl: String = "https://coinranking1.p.rapidapi.com/"

    let coinRankingHeaders: HTTPHeaders = [
        "x-access-token": "coinranking8b2327adeb90d342ee607da8b08f4f695318ade2e7ffaa73"
    ]
    let rapidApidHeaders: HTTPHeaders = [
        "x-rapidapi-host": "coinranking1.p.rapidapi.com",
        "x-rapidapi-key": "432b3878aemshd095a8a233041e0p1279bbjsn4fadf9e18581"
    ]

    public func fetchStats(completion: @escaping (_ response: GenericResponse<Stats>?) -> Void) {
        let url = "\(coinRankingBaseUrl)stats"
        requestGet(url: url, headers: coinRankingHeaders, parameters: nil, completion: completion)
    }

    public func fetchExchanges(completion: @escaping (_ response: GenericResponse<ExchangesList>?) -> Void) {
        let url = "\(rapidApiBaseUrl)coin/Qwsogvtv82FCd/exchanges"
        let parameters: Parameters = [
            "limit": "50",
            "orderBy": "24hVolume",
            "orderDiretion": "desc"
        ]

        requestGet(url: url, headers: rapidApidHeaders, parameters: parameters, completion: completion)
    }

    public func fetchCoins(completion: @escaping (_ response: GenericResponse<CoinList>?) -> Void) {
        let url = "\(coinRankingBaseUrl)coins"
        requestGet(url: url, headers: coinRankingHeaders, parameters: nil, completion: completion)
    }

    public func searchForCoins(query: String, completion: @escaping (_ response: GenericResponse<CoinList>?) -> Void) {
        let url = "\(coinRankingBaseUrl)search-suggestions?query=\(query)"
        requestGet(url: url, headers: coinRankingHeaders, parameters: nil, completion: completion)
    }

    private func requestGet<T>(url: String,
                               headers: HTTPHeaders,
                               parameters: Parameters?,
                               completion: @escaping (_ data: T?) -> Void) where T: Codable {

        AF.request(url, method: .get, parameters: parameters,
                   headers: headers).responseDecodable { (response: DataResponse<T, AFError>) in
            debugPrint(response)
            guard response.error == nil else {
                completion(nil)
                return
            }

            completion(response.value)
        }
    }

}
