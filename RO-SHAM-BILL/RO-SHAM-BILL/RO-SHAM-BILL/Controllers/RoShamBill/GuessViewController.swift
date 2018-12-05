//
//  GuessViewController.swift
//  RO-SHAM-BILL
//
//  Created by Patrick Molvik on 4/16/18.
//  Copyright © 2018 Patrick Molvik. All rights reserved.
//

import UIKit

class GuessViewController: UIViewController {

    var game:Game!
    var playerNumber = 1
    var minGuess = 0
    var maxGuess = 0
    
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var guessLabel: UILabel!
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var guessTextField: UITextField!
    
    @IBAction func okButtonClicked(_ sender: Any) {
        
        guard let guessNumberString = guessTextField.text,
            let guessNumber = Int(guessNumberString) else {
                //TODO:Display error message
                return
        }
        
        if(game.numberPicked > guessNumber){
            //Higher
            guessLabel.text = "Higher"
            guessLabel.textColor = UIColor(red: 0.56, green: 0.75, blue: 0.0, alpha: 1)
            minGuess = guessNumber
        }else if(game.numberPicked < guessNumber){
            //Lower
            guessLabel.text = "Lower"
            guessLabel.textColor = UIColor(red: 0.0, green: 0.78, blue: 0.78, alpha: 1)
            maxGuess = guessNumber
        }else{
            //Winner
            game.turns.append(Turn(guessOn: Date(), playerName: playerLabel.text!, playerGuess: guessNumber))

            self.performSegue(withIdentifier: "goToWinnerSegue", sender: self)
            return
        }
        game.turns.append(Turn(guessOn: Date(), playerName: playerLabel.text!, playerGuess: guessNumber))
        playerNumber = playerNumber >= game.numberOfPlayers ? 1 : playerNumber + 1
        playerLabel.text = "Player \(playerNumber)"
        guessTextField.text = ""
        instructionsLabel.attributedText = BaseController.getInstructions(startNumber: minGuess, endNumber: maxGuess).message
        
    }
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         let winnerController = segue.destination as! WinnerViewController
        winnerController.game = game
     }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let instructionsTruple = BaseController.getInstructions(startNumber: nil, endNumber: nil)
        minGuess = instructionsTruple.startNumber
        maxGuess = instructionsTruple.endNumber
        playerLabel.text = "Player \(playerNumber)"
        instructionsLabel.attributedText = instructionsTruple.message
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
