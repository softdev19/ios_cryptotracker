//
//  ExchangesTableViewCell.swift
//  CryptoTracker
//
//  Created by Uriel Hernandez Gonzalez on 05/02/22.
//

import UIKit
import MaterialComponents.MDCCard
import SDWebImage

protocol ExchangesTableViewCellDelegate {
    func onClicked(exchangeId: String)
}

class ExchangesTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: MDCCard!
    @IBOutlet weak var exchangeImg: UIImageView!
    @IBOutlet weak var exchangeNameLbl: UILabel!

    public var delegate: ExchangesTableViewCellDelegate?
    private var exchangeId: String!

    static let identifier: String = "ExchangesTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        exchangeImg.sd_cancelCurrentImageLoad()
        exchangeImg.image = nil
    }

    private func setupUI() {
        exchangeImg.layer.cornerRadius = exchangeImg.bounds.width / 2
        cardView.cornerRadius = 20
        cardView.setShadowColor(UIColor(named: "TextColor"), for: .normal)
        cardView.setShadowElevation(ShadowElevation(rawValue: 10), for: .normal)

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapped))
        cardView.addGestureRecognizer(tapRecognizer)
    }

    public func displayExchangeData(for exchange: Exchange) {
        guard let imgUrl = URL(string: exchange.iconUrl) else {return}

        exchangeId = exchange.uuid
        exchangeNameLbl.text = exchange.name
        exchangeImg.sd_setImage(with: imgUrl)
    }

    @objc private func onTapped() {
        delegate?.onClicked(exchangeId: exchangeId)
    }
}
