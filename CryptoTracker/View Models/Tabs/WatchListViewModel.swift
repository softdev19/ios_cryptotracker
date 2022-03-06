//
//  WatchListViewModel.swift
//  CryptoTracker
//
//  Created by Uriel Hernandez Gonzalez on 04/03/22.
//
// swiftlint:disable force_try

import Foundation
import RealmSwift

class WatchListViewModel {
    var favoriteCoins: Box<Results<FavoriteCoin>?> = Box(nil)
}

extension WatchListViewModel {
    func fetchFavorites() {
        DispatchQueue.global(qos: .userInitiated).async {
            let realm = try! Realm()
            self.favoriteCoins.value = realm.objects(FavoriteCoin.self)
        }
    }
}
