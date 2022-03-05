//
//  WatchListTableViewCell.swift
//  CryptoTracker
//
//  Created by Uriel Hernandez Gonzalez on 08/02/22.
//

import UIKit
import MaterialComponents.MDCCard

protocol WatchListTableViewCellDelegate {
    func onClicked(coinId: String)
}

class WatchListTableViewCell: UITableViewCell, ReuseView {

    @IBOutlet weak var cardView: MDCCard!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var coinLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var coinImage: UIImageView!

    public var delegate: WatchListTableViewCellDelegate?

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
        coinImage.layer.cornerRadius = coinImage.bounds.height / 2
    }

    @objc private func onTap() {
        delegate?.onClicked(coinId: "Hola")
    }

}
