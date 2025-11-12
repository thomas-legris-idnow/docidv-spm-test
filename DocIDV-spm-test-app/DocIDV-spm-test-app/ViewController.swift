//
//  ViewController.swift
//  DocIDV-spm-test-app
//
//  Created by Thomas Legris on 12/11/2025.
//

import UIKit
import DocIDV

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        IDnowDocIDV.shared.start(token: "DV7-HSYSA", fromViewController: self, listener: { [weak self] _, _, _ in
        })
        // Do any additional setup after loading the view.
    }


}

