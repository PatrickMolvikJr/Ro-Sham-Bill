//
//  ServerViewController.swift
//  RO-SHAM-BILL
//
//  Created by Patrick Molvik on 4/16/18.
//  Copyright © 2018 Patrick Molvik. All rights reserved.
//

import UIKit
import CoreData

class ServerViewController: UIViewController {
    
    var game:Game?
    
    @IBOutlet weak var instructionsLabel: UILabel!
    
    @IBOutlet weak var serverNumberTextField: UITextField!
    
    @IBAction func okButtonClicked(_ sender: Any) {
        guard let serverNumberString = serverNumberTextField.text,
            let serverNumber = Int(serverNumberString) else {
                //TODO: Display Error Message
                return
        }
        
        game!.numberPicked = serverNumber
        
        self.performSegue(withIdentifier: "goToPlayerSegue", sender: self)
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let playersController = segue.destination as! PlayersViewController
        playersController.game = game
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var instructionsTruple = BaseController.getInstructions(startNumber: nil, endNumber: nil)
        
        self.game = Game(numberOfPlayers: 0, startNumber: instructionsTruple.startNumber, endNumber: instructionsTruple.endNumber, numberPicked: 0, playedOn: Date(), turns: [])
        
        instructionsLabel.attributedText = instructionsTruple.message
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
