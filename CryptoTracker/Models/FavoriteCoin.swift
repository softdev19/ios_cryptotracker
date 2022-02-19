//
//  FavoriteCoin.swift
//  CryptoTracker
//
//  Created by Uriel Hernandez Gonzalez on 15/02/22.
//
// swiftlint:disable force_try

import Foundation
import RealmSwift

class FavoriteCoin: Object {
    @Persisted(primaryKey: true) var id = 0
    @Persisted var coindName: String!
    @Persisted var coinPrice: String!
    @Persisted var coinImg: String!
    @Persisted var coinUUID: String!

    func incrementId() -> Int {
        let realm = try! Realm()
        return (realm.objects(FavoriteCoin.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
}
