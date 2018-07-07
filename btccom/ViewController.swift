//
//  ViewController.swift
//  btccom
//
//  Created by aleksandr.rosliakov on 07/07/2018.
//  Copyright © 2018 Alex Roslyakov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var sellTableView: UITableView!
    @IBOutlet weak var buyTableView: UITableView!
    @IBOutlet weak var matchTableView: UITableView!

    var model : Model?

    private let defaultTableViewCellIdentifier = "DefaultTableViewCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let parser = ParserImplDecodable()
        let network = NetworkImplURLSession()
        let api = BackendApiImplNetwork(network: network, parser: parser)
        self.model = Model(api: api)

        self.sellTableView.register(UITableViewCell.self, forCellReuseIdentifier: defaultTableViewCellIdentifier)
        self.buyTableView.register(UITableViewCell.self, forCellReuseIdentifier: defaultTableViewCellIdentifier)
        self.matchTableView.register(UITableViewCell.self, forCellReuseIdentifier: defaultTableViewCellIdentifier)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.model?.update() {
            DispatchQueue.main.async {
                self.sellTableView.reloadData()
                self.buyTableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: UITableView

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == self.sellTableView) {
            return self.model?.sellOrders.count ?? 0
        }
        else if (tableView == self.buyTableView) {
            return self.model?.buyOrders.count ?? 0
        }
        else if (tableView == self.matchTableView) {
            return 0
        }
        else {
             precondition(false, "Unknown UITableView")
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: defaultTableViewCellIdentifier, for: indexPath)

        if (tableView == self.sellTableView) {
            var text = ""
            if let order = self.model?.sellOrders[indexPath.row] {
                text = "Sell \(order.id) \(order.quantity) \(order.price)"
            }
            cell.textLabel?.text = text
        }
            else if (tableView == self.buyTableView) {
                var text = ""
                if let order = self.model?.buyOrders[indexPath.row] {
                    text = "Buy \(order.id) \(order.quantity) \(order.price)"
                }
                cell.textLabel?.text = text
        }
            else if (tableView == self.matchTableView) {
                cell.textLabel?.text = "Match"
        }
            else {
                precondition(false, "Unknown UITableView")
        }

        return cell
    }
}

