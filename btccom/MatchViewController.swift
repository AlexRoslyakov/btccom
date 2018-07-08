//
//  MatchViewController.swift
//  btccom
//
//  Created by aleksandr.rosliakov on 08/07/2018.
//  Copyright © 2018 Alex Roslyakov. All rights reserved.
//

import UIKit

class MatchViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var sellOrderLabel: UILabel!
    @IBOutlet weak var buyOrderLabel: UILabel!

    

    @IBAction func onCloseButtonTouchUpInside(_ sender: Any) {
        self.dismiss(animated: true) {
            // nop
        }
    }

    var match : Match? {
        didSet {
            updateWithMatch()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        updateWithMatch()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func updateWithMatch() {
        guard let match = self.match else {
            return
        }
        
        if (!self.isViewLoaded) {
            return
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .long
        let timeText = dateFormatter.string(from: match.time)
        self.timeLabel.text = "Time: \(timeText)"

        self.volumeLabel.text = "Volume: \(match.volume)"
        self.priceLabel.text = "Price: \(match.price)"
        self.sellOrderLabel.text = "Sell Order: \(DescriptionHelper.textFor(order: match.sellOrder))"
        self.buyOrderLabel.text = "Buy Order: \(DescriptionHelper.textFor(order: match.buyOrder))"
    }
}
