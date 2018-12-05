//
//  ViewController.swift
//  RO-SHAM-BILL
//
//  Created by Patrick Molvik on 4/10/18.
//  Copyright © 2018 Patrick Molvik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var helloLabel: UILabel!
    
    @IBOutlet weak var enterNameTextField: UITextField!
    
    @IBAction func helloButton(_ sender: Any) {

        if let name: String = enterNameTextField.text
        {
            helloLabel.text = "Hello " + name
        }
        
        helloLabel.text = "Hello World"

    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        helloLabel.text = ""
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

