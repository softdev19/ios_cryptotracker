//
//  WatchListTableViewCell.swift
//  CryptoTracker
//
//  Created by Uriel Hernandez Gonzalez on 08/02/22.
//

import UIKit
import MaterialComponents.MDCCard

class WatchListTableViewCell: UITableViewCell {

    static let identifier = "WatchListTableViewCell"

    @IBOutlet weak var cardView: MDCCard!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var coinLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
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

    public var onClicked: (() -> Void)!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardView.layer.masksToBounds = true
        cardView.cornerRadius = 20
        gradient.frame = CGRect(x: 0, y: 0, width: 500, height: 200)
        gradientView.layer.insertSublayer(gradient, at: 0)
        gradientView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap)))
    }
    
    @objc private func onTap() {
        onClicked()
    }

}
