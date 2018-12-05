//
//  Turn.swift
//  RO-SHAM-BILL
//
//  Created by Patrick Molvik on 5/1/18.
//  Copyright © 2018 Patrick Molvik. All rights reserved.
//

import Foundation

class Turn {
    var guessOn:Date
    var playerName:String
    var playerGuess:Int
    
    init(guessOn:Date, playerName:String, playerGuess:Int){
        self.guessOn = guessOn
        self.playerName = playerName
        self.playerGuess = playerGuess
    }
    
}

