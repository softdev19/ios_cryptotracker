//
//  CoinCollectionViewCell.swift
//  CryptoTracker
//
//  Created by Uriel Hernandez Gonzalez on 06/02/22.
//

import UIKit
import MaterialComponents.MDCCard

class CoinCollectionViewCell: UICollectionViewCell {

    static let identifier = "CoinCollectionViewCell"

    @IBOutlet weak var cardView: MDCCard!
    @IBOutlet weak var gradientView: UIView!
    
    public var onClicked: (() -> Void)!

    private var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor(named: "SecondaryColor")?.withAlphaComponent(0.5).cgColor,
            UIColor(named: "MainColor")?.withAlphaComponent(0.5).cgColor
        ]
        gradient.locations = [0, 0.5]
        return gradient
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.layer.masksToBounds = true
        cardView.cornerRadius = 20
        gradient.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        gradientView.layer.insertSublayer(gradient, at: 0)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        gradientView.addGestureRecognizer(tapGesture)
    }

    @objc private func didTap() {
        onClicked()
    }

}
