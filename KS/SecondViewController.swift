//
//  ViewController.swift
//  KS
//
//  Created by Patrick Adams on 1/30/19.
//  Copyright © 2019 Sure, Inc. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var zeldaGames = [ZeldaGame]()

    override func viewDidLoad() {
        super.viewDidLoad()
        ZeldaGameFetcher.fetchZeldaGames { (zeldaGames, error) in
            if error == nil && zeldaGames != nil {
                self.zeldaGames = zeldaGames!
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return zeldaGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZeldaGameCell") as! ZeldaGameCell
        cell.zeldaGame = zeldaGames[indexPath.row]
        return cell
    }
}
