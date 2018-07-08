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

    @IBAction func onUpdateButtonTouchedUpInside(_ sender: Any) {
        self.model?.update() { viewModel in
            DispatchQueue.main.async {
                self.viewModel = viewModel

                self.sellTableView.reloadData()
                self.buyTableView.reloadData()
                self.matchTableView.reloadData()
            }
        }
    }
    var model : Model?
    var viewModel = ViewModel()

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
        let cell = tableView.dequeueReusableCell(withIdentifier: defaultTableViewCellIdentifier, for: indexPath)

        if (tableView == self.sellTableView) {
            let order = self.viewModel.sellOrders[indexPath.row]
            cell.textLabel?.text = DescriptionHelper.textFor(order: order)
        }
            else if (tableView == self.buyTableView) {
                let order = self.viewModel.buyOrders[indexPath.row]
                cell.textLabel?.text = DescriptionHelper.textFor(order: order)
        }
            else if (tableView == self.matchTableView) {
                let match = self.viewModel.matches[indexPath.row]
                cell.textLabel?.text = DescriptionHelper.textFor(match: match)
        }
            else {
                precondition(false, "Unknown UITableView")
        }

        return cell
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

