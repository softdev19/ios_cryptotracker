//
//  Protocols.swift
//  CryptoTracker
//
//  Created by Uriel Hernandez Gonzalez on 04/03/22.
//

import Foundation
import UIKit

protocol ReuseView {
    static var viewIdentifier: String { get }
    static var nibName: UINib { get }
}

extension ReuseView {
    static var viewIdentifier: String {
        return String(describing: self)
    }
    
    static var nibName: UINib {
        return UINib(nibName: viewIdentifier, bundle: .main)
    }
}
