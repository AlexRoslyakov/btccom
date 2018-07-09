//
//  OrderView.swift
//  btccom
//
//  Created by aleksandr.rosliakov on 09/07/2018.
//  Copyright © 2018 Alex Roslyakov. All rights reserved.
//

import UIKit

class OrderView : UIView {
    @IBOutlet weak var orderIdLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet var contentView: UIView!

    public var order : Order? {
        didSet {
            if let order = self.order {
                self.update(order: order)
            }
        }
    }


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }

    private func initSubviews() {
        let nib = UINib(nibName: "Order", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }

    private func update(order : Order) {
        let orderTypeText : String
        let color : UIColor
        switch order.typeEnum() {
            case Order.Types.sell:
                orderTypeText = "Sell"
                color = UIColor(red: 104.0/255.0, green: 151.0/255.0, blue: 0.0, alpha: 1.0)
            case Order.Types.buy:
                orderTypeText = "Buy"
                color = UIColor.red
            case Order.Types.unknown:
                preconditionFailure("Unknown Order Type")
        }
        self.orderIdLabel.text = "\(orderTypeText)\(order.id)"
        self.orderIdLabel.textColor = color

        self.priceLabel.text = "\(order.price)"
        self.quantityLabel.text = "\(order.quantity)"
    }
}
