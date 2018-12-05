//
//  HistoryDetailsTableViewController.swift
//  RO-SHAM-BILL
//
//  Created by Patrick Molvik on 4/16/18.
//  Copyright © 2018 Patrick Molvik. All rights reserved.
//

import UIKit
import CoreData

class TurnTableViewCell: UITableViewCell {

    @IBOutlet weak var turnsLabel: UILabel!
    @IBOutlet weak var turnsDetailLabel: UILabel!
    
}

class HistoryDetailsTableViewController: UITableViewController {
    
    var gameNumber:Int = 0
    var game:NSManagedObject!
    
    var turns:[NSManagedObject] = []
    
    
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.turns = (game!.value(forKeyPath: "turns") as? NSSet)?.allObjects as! [NSManagedObject]
        
        self.turns = self.turns.sorted {
            ($0.value(forKeyPath: "guessedOn") as! Date) < ($1.value(forKeyPath: "guessedOn") as! Date)
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section == 0 {
            return 6
        }else{
            return (turns.count)
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "GENERAL"
        }else{
            return "TURNS"
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //Format the Date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = formatter.string(from:game.value(forKeyPath: "playedOn") as! Date)

        //Store row details for section 0 in double array
        var gameDetails: [[String]] = [
            ["Game Number", String((gameNumber + 1))],
            ["Time", dateString],
            ["Server's Number", "\(game.value(forKeyPath: "numberPicked") as! Int)"],
            ["Number of Players", "\(game.value(forKeyPath: "numberOfPlayers") as! Int)"],
            ["Number of Turns", "\(turns.count)"],
            ["Winner", turns.last?.value(forKeyPath: "playerName") as! String]
        ]
        
        //Store row details into label
        let gameTurn: String = "Turn " + (String(indexPath.row + 1)) + ": "

        //Set the cell content for given section
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailsCellIdentifier", for: indexPath)
            cell.textLabel?.text = gameDetails[indexPath.row][0]
            cell.detailTextLabel?.text = gameDetails[indexPath.row][1]
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "turnsCellIdentifier", for: indexPath) as! TurnTableViewCell
            let turnToSave = turns[indexPath.row]
            let playerName: String = turnToSave.value(forKeyPath: "playerName") as! String
            let playerGuess: Int = turnToSave.value(forKeyPath: "playerGuess") as! Int
            let gameTurnDetail: String = playerName + " guessed " + "\(playerGuess)"
            cell.turnsLabel.text = gameTurn
            cell.turnsDetailLabel.text = gameTurnDetail
            return cell
            
        }
    }
}
