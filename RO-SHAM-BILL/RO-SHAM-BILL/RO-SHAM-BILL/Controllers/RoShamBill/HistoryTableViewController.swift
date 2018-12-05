//
//  HistoryTableViewController.swift
//  RO-SHAM-BILL
//
//  Created by Patrick Molvik on 4/16/18.
//  Copyright © 2018 Patrick Molvik. All rights reserved.
//

import UIKit
import CoreData

class HistoryTableViewController: UITableViewController {
    
    var games:[NSManagedObject] = []
//    var gameNumber:Int?
//    var game:NSManagedObject!
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func retrieveGames() -> [NSManagedObject] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:"Games")
        
        do {
            return try context.fetch(fetchRequest)
        } catch let err as NSError {
            print("Could not retrieve. \(err)")
            return []
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.games = retrieveGames()
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
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if games.count != 0 {
//            self.gameNumber = indexPath.row + 1
//            self.game = games[indexPath.row]
            self.performSegue(withIdentifier: "goToHistoryDetailsScene", sender: self)
        }

    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return games.count == 0 ? 1 : games.count

    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier:
            games.count == 0 ? "notFoundCellIdentifier" :
            "gameHistoryCellIdentifier", for: indexPath)

        if games.count != 0 {

            let game = games[indexPath.row]
        
            // Configure the cell...

            cell.textLabel?.text = "Game \(indexPath.row + 1)"
        
//            let playedOn = Date().addingTimeInterval(TimeInterval(indexPath.row * 60))
            
            let playedOn = game.value(forKeyPath: "playedOn") as! Date
        
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
        
            let timeFormatter = DateFormatter()
            timeFormatter.timeStyle = .short
        
            cell.detailTextLabel?.text = "\(dateFormatter.string(from: playedOn)) \(timeFormatter.string(from: playedOn))"
        }
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            //tableView.deleteRows(at: [indexPath], with: .fade)
            
            let game = self.games[indexPath.row]
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                return
            }
            
            let context = appDelegate.persistentContainer.viewContext
            context.delete(game)
            
            do{
                try context.save()
                self.games = retrieveGames()
                
                self.tableView.reloadData()
                
            } catch let error as NSError {
                 print("Something went wrong \(error)")
            }
        }
    }
 

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToHistoryDetailsScene"{
            if let indexPath = tableView.indexPathForSelectedRow {
                let game = games[indexPath.row]
                let historyDetailsTableViewController = segue.destination as! HistoryDetailsTableViewController
                historyDetailsTableViewController.gameNumber = indexPath.row + 1
                historyDetailsTableViewController.game = games[indexPath.row]
            }
        }
    }
}
