//
//  SettingsTableViewController.swift
//  RO-SHAM-BILL
//
//  Created by Patrick Molvik on 4/16/18.
//  Copyright © 2018 Patrick Molvik. All rights reserved.
//

import UIKit
import CoreData

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var startNumberLabel: UILabel!
    @IBOutlet weak var endNumberLabel: UILabel!
    @IBAction func saveButtonClicked(_ sender: Any) {
        //TODO: Add Save Functionality
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext

        let entity =
            NSEntityDescription.entity(forEntityName: "Settings",
                                       in: managedContext)!
        
        let setting = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        setting.setValue(10, forKeyPath: "startNumber")
        setting.setValue(230, forKeyPath: "endNumber")
        
        do {
            try managedContext.save()
            print("worked")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
     //   self.dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        //Retrieve what was saved to the Database

        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext

        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Settings")
        
        var startNumber = 0
        var endNumber = 0
        
        do {
            let setting = try managedContext.fetch(fetchRequest).first
            if setting != nil {
                startNumber = setting!.value(forKey: "startNumber") as! Int
                endNumber = setting!.value(forKey: "endNumber") as! Int
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        startNumberLabel.text = "Start Number: \(startNumber)"
        endNumberLabel.text = "End Number: \(endNumber)"
        
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
