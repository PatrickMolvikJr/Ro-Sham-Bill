//
//  PlayersViewController.swift
//  RO-SHAM-BILL
//
//  Created by Patrick Molvik on 4/16/18.
//  Copyright © 2018 Patrick Molvik. All rights reserved.
//

import UIKit

class PlayersViewController: UIViewController {

    var game:Game!
    
    @IBOutlet weak var numberOfPlayersTextField: UITextField!
    @IBAction func okButtonClicked(_ sender: Any) {
        
        guard let numOfPlayersString = numberOfPlayersTextField.text,
            let numberOfPlayers = Int(numOfPlayersString) else {
                //TODO: Display Error Message
                return
        }
        
        game.numberOfPlayers = numberOfPlayers
        
        self.performSegue(withIdentifier: "goToGuessSegue", sender: self)
    }
    @IBAction func cancelButtonClicked(_ sender: Any) {
    self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let guessController = segue.destination as! GuessViewController
        guessController.game = game
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
