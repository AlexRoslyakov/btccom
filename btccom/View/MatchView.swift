//
//  MatchView.swift
//  btccom
//
//  Created by aleksandr.rosliakov on 09/07/2018.
//  Copyright © 2018 Alex Roslyakov. All rights reserved.
//

import UIKit

class MatchView : UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    
    public var match : Match? {
        didSet {
            if let match = self.match {
                self.update(match: match)
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
        let nib = UINib(nibName: "Match", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }

    private func update(match : Match) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .medium
        let timeText = dateFormatter.string(from: match.time)
        self.timeLabel.text = timeText

        self.volumeLabel.text = "\(match.volume)"
        self.priceLabel.text = "\(match.price)"
    }
}
