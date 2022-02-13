//
//  GenericResponse.swift
//  CryptoTracker
//
//  Created by Uriel Hernandez Gonzalez on 09/02/22.
//

import Foundation

struct GenericResponse<T: Codable>: Codable {
    var status: String!
    var data: (T)?

    enum CodingKeys: String, CodingKey {
        case status, data
    }
}
