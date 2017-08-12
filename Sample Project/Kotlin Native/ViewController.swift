//
//  ViewController.swift
//  Kotlin Native
//
//  Created by Michał Kałużny on 12/08/2017.
//  Copyright © 2017 Makowiec. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let retVal = kotlin_wrapper() {
            let string = String(cString: retVal)
            let alertController = UIAlertController(title: "Kotlin says:", message: string, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Okay?", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
}

