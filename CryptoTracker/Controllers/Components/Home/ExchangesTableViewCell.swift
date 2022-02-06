//
//  ExchangesTableViewCell.swift
//  CryptoTracker
//
//  Created by Uriel Hernandez Gonzalez on 05/02/22.
//

import UIKit
import MaterialComponents.MDCCard

class ExchangesTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: MDCCard!

    public var onClicked: (() -> Void)!

    static let identifier: String = "ExchangesTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        cardView.cornerRadius = 20
        cardView.setShadowColor(UIColor(named: "TextColor"), for: .normal)
        cardView.setShadowElevation(ShadowElevation(rawValue: 10), for: .normal)

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapped))
        cardView.addGestureRecognizer(tapRecognizer)
    }

    @objc private func onTapped() {
        onClicked()
    }
}
