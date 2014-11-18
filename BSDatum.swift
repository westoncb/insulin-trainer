//
//  BSDatum.swift
//  Insulin Trainer
//
//  Created by Weston Beecroft on 11/14/14.
//  Copyright (c) 2014 Weston Beecroft. All rights reserved.
//

import Foundation

enum EntryType {
    case BloodSugar
    case Insulin
    case Food
    case None
}

class BSDatum {
    var time: NSDate!
    var type: EntryType!
    var values: [String]!
    
    init(date: NSDate, type: EntryType, values: [String]) {
        self.time = date
        self.type = type
        self.values = values
    }
    
    func doThePrint() {
        println("date: \(self.time), type: \(self.type), values: \(self.values)")
    }
}