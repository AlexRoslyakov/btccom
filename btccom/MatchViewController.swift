//
//  MatchViewController.swift
//  btccom
//
//  Created by aleksandr.rosliakov on 08/07/2018.
//  Copyright © 2018 Alex Roslyakov. All rights reserved.
//

import UIKit

class MatchViewController: UIViewController {

    @IBOutlet weak var matchView: MatchView!
    @IBOutlet weak var sellOrderView: OrderView!
    @IBOutlet weak var buyOrderView: OrderView!
    

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

        self.matchView.match = match
        self.sellOrderView.order = match.sellOrder
        self.buyOrderView.order = match.buyOrder
    }
}
