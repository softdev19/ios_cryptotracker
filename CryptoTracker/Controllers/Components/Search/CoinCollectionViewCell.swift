//
//  CoinCollectionViewCell.swift
//  CryptoTracker
//
//  Created by Uriel Hernandez Gonzalez on 06/02/22.
//

import UIKit
import MaterialComponents.MDCCard

protocol CoinCollectionViewCellDelegate {
    func onClicked(coindId: String)
}

class CoinCollectionViewCell: UICollectionViewCell, ReuseView {


    @IBOutlet weak var cardView: MDCCard!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var coinNameLbl: UILabel!

    public var delegate: CoinCollectionViewCellDelegate?
    public var coindId: String!

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
        setupUI()
    }

    private func setupUI() {
        cardView.layer.masksToBounds = true
        cardView.cornerRadius = 20
        coinImage.layer.cornerRadius = coinImage.bounds.height / 2
        gradient.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        gradientView.layer.insertSublayer(gradient, at: 0)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        gradientView.addGestureRecognizer(tapGesture)
    }

    func displayData(name: String?, imgUrl: String?) {

        guard let name = name,
              let imgUrl = imgUrl,
              let url = URL(string: imgUrl) else {
                  return
              }

        coinNameLbl.text = name
        coinImage.sd_setImage(with: url)
    }

    @objc private func didTap() {
        delegate?.onClicked(coindId: coindId)
    }

}
