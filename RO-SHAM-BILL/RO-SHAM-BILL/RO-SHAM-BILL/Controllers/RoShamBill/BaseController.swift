//
//  BaseController.swift
//  RO-SHAM-BILL
//
//  Created by Patrick Molvik on 5/21/18.
//  Copyright © 2018 Patrick Molvik. All rights reserved.
//

import UIKit
import CoreData

class BaseController {
    static func getInstructions(startNumber:Int?, endNumber:Int?) -> (startNumber:Int, endNumber:Int, message:NSMutableAttributedString, isError:Bool) {
        
        var instructionsTruple = (startNumber:1, endNumber:1000, message:NSMutableAttributedString(string:""), isError:false)
        
        if let startNumber = startNumber,
            let endNumber = endNumber {
            instructionsTruple.startNumber = startNumber
            instructionsTruple.endNumber = endNumber
        }else{

           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                instructionsTruple.isError = true
                instructionsTruple.message = NSMutableAttributedString(string: "Error")
                return instructionsTruple
            }
        
            let context = appDelegate.persistentContainer.viewContext
        
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Settings")
        
            do {
                let setting = try context.fetch(fetchRequest).first
                if(setting != nil){
                    instructionsTruple.startNumber = setting!.value(forKey:"startNumber") as! Int
                    instructionsTruple.endNumber = setting!.value(forKey: "endNumber") as! Int
                }
            
            }catch let error as NSError{
                //TODO: Add error checking
//              return NSMutableAttributedString(string: "Error")
                instructionsTruple.isError = true
                instructionsTruple.message = NSMutableAttributedString(string: "Error occurred with core data")
                return instructionsTruple
            }
        }
        let boldStyling = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 21)]
        
        let instructionString = NSMutableAttributedString(string:"Enter a number between ")
        
        let startNumberString = NSMutableAttributedString(string:String(instructionsTruple.startNumber), attributes:boldStyling)
        let andString = NSMutableAttributedString(string:" and ")
        let endNumberString = NSMutableAttributedString(string:String(instructionsTruple.endNumber), attributes:boldStyling)
        instructionString.append(startNumberString)
        
        instructionString.append(andString)
        instructionString.append(endNumberString)
        
        instructionsTruple.message = instructionString
        instructionsTruple.isError = false
        
        return instructionsTruple
    }
}
