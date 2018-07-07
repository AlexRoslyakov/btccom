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

    private let defaultTableViewCellIdentifier = "DefaultTableViewCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

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
        if (tableView == self.sellTableView ||
            tableView == self.buyTableView) {
            return 20
        }
        else if (tableView == self.matchTableView) {
            return 30
        }
        else {
             precondition(false, "Unknown UITableView")
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: defaultTableViewCellIdentifier, for: indexPath)

        if (tableView == self.sellTableView) {
            cell.textLabel?.text = "Sell"
        }
        else
            if (tableView == self.buyTableView) {
                cell.textLabel?.text = "Buy"
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

