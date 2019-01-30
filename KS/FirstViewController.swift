//
//  FirstViewController.swift
//  KS
//
//  Created by Patrick Adams on 1/30/19.
//  Copyright © 2019 Sure, Inc. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        button.setTitle("Load Zelda Games", for: .normal)
        button.roundCorners(cornerRadius: 8)
    }
}
