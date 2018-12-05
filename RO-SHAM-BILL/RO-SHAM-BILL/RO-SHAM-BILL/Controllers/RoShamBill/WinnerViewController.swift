//
//  WinnerViewController.swift
//  RO-SHAM-BILL
//
//  Created by Patrick Molvik on 4/16/18.
//  Copyright © 2018 Patrick Molvik. All rights reserved.
//

import UIKit
import CoreData

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
class WinnerViewController: UIViewController {

    var game:Game!
    
    @IBAction func homeButtonClicked(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity =
            NSEntityDescription.entity(forEntityName: "Games",
                                       in: managedContext)!
        
        let gameObject = NSManagedObject(entity: entity,
                                      insertInto: managedContext)
        
//        let gameTurns: [Turn] = game.turns.sorted(by: {$0.guessOn > $1.guessOn})

        gameObject.setValue(game.numberOfPlayers, forKeyPath: "numberOfPlayers")
        gameObject.setValue(game.startNumber, forKeyPath: "startNumber")
        gameObject.setValue(game.endNumber, forKeyPath: "endNumber")
        gameObject.setValue(game.numberPicked, forKeyPath:"numberPicked")
        gameObject.setValue(game.playedOn, forKeyPath:"playedOn")

        for turn in game.turns {
            let turnEntity = NSEntityDescription.entity(forEntityName: "Turns", in: managedContext)!
            let turnToAdd = NSManagedObject(entity: turnEntity, insertInto: managedContext)
            turnToAdd.setValue(turn.guessOn, forKeyPath: "guessedOn")
            turnToAdd.setValue(turn.playerGuess, forKeyPath: "playerGuess")
            turnToAdd.setValue(turn.playerName, forKeyPath: "playerName")
            
            gameObject.mutableSetValue(forKeyPath: "turns").add(turnToAdd)
        }

        do {
            try managedContext.save()
            print("worked")
        } catch let error as NSError {
            print("Didn't Work")
            print("Could not save. \(error), \(error.code)")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
