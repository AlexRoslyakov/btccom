//
//  ViewController.swift
//  btccom
//
//  Created by aleksandr.rosliakov on 07/07/2018.
//  Copyright © 2018 Alex Roslyakov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var sellTableView: UITableView!
    @IBOutlet weak var buyTableView: UITableView!
    @IBOutlet weak var matchTableView: UITableView!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var autoUpdateButton: UIButton!

    var timer : Timer?

    @IBAction func onAutomaticUpdateButtonTouchedUpInside(_ sender: Any) {
        if self.timer != nil {
            self.timer?.invalidate()
            self.timer = nil

            self.autoUpdateButton.setTitle("Enable Automatic Updates", for: .normal)
            self.updateButton.isEnabled = true
        }
        else {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimer), userInfo: nil, repeats: true)

            self.autoUpdateButton.setTitle("Disable Automatic Updates", for: .normal)
            self.updateButton.isEnabled = false
        }
    }

    @objc func onTimer() {
        self.update()
    }

    @IBAction func onUpdateButtonTouchedUpInside(_ sender: Any) {
        self.update()
    }
    var model : Model?
    var viewModel = ViewModel()

    private func update() {
        self.model?.update() { viewModel in
            DispatchQueue.main.async {
                self.viewModel = viewModel

                self.sellTableView.reloadData()
                self.buyTableView.reloadData()
                self.matchTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let parser = ParserImplDecodable()
        let network = NetworkImplURLSession()
        let api = BackendApiImplNetwork(network: network, parser: parser)
        self.model = Model(api: api)
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
            return self.viewModel.sellOrders.count
        }
        else if (tableView == self.buyTableView) {
            return self.viewModel.buyOrders.count
        }
        else if (tableView == self.matchTableView) {
            return self.viewModel.matches.count
        }
        else {
             precondition(false, "Unknown UITableView")
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let orderCellIdentifier = "OrderCellIdentifier"
        if (tableView == self.sellTableView) {
            let order = self.viewModel.sellOrders[indexPath.row]
            guard let cell = tableView.dequeueReusableCell(withIdentifier: orderCellIdentifier, for: indexPath) as? OrderTableViewCell else {
                preconditionFailure("Unknown type of cell")
            }
            cell.orderView.order = order
            return cell
        }
            else if (tableView == self.buyTableView) {
                let order = self.viewModel.buyOrders[indexPath.row]
                guard let cell = tableView.dequeueReusableCell(withIdentifier: orderCellIdentifier, for: indexPath) as? OrderTableViewCell else {
                    preconditionFailure("Unknown type of cell")
                }
                cell.orderView.order = order
                return cell
        }
            else if (tableView == self.matchTableView) {
                let match = self.viewModel.matches[indexPath.row]
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MatchCellIdentifier", for: indexPath) as? MatchTableViewCell else {
                preconditionFailure("Unknown type of cell")
            }
                cell.matchView.match = match
                return cell
        }
            else {
                precondition(false, "Unknown UITableView")
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if tableView == self.matchTableView {
            let match = self.viewModel.matches[indexPath.row]

            let vc : MatchViewController = self.storyboard?.instantiateViewController(withIdentifier: "MatchViewController") as! MatchViewController
            vc.match = match
            vc.modalPresentationStyle = .formSheet
            self.present(vc, animated: true) {
                // nop
            }
        }
    }
}

