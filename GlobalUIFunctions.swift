//
//  GlobalUIFunctions.swift
//  Insulin Trainer
//
//  Created by Weston Beecroft on 11/17/14.
//  Copyright (c) 2014 Weston Beecroft. All rights reserved.
//

import Foundation
import UIKit

private let _guifunctionsinstance = GlobalUIFunctions()

class GlobalUIFunctions {
    
    private init() {
        
    }
    
    class func instance() ->GlobalUIFunctions {
        return _guifunctionsinstance
    }
    
    func changeButtonBackgroundColor(sender: UIButton) {
        sender.backgroundColor = UIColor(red: 0.7, green: 0.85, blue: 1, alpha: 1)
    }
    
    func restoreButtonBackgroundColor(sender: UIButton) {
        sender.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    }
    
    func customizeButton(button: UIButton) {
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).CGColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 4
//        button.addTarget(_guifunctionsinstance, action: "changeButtonBackgroundColor:", forControlEvents: UIControlEvents.TouchDown)
//        button.addTarget(_guifunctionsinstance, action: "restoreButtonBackgroundColor:", forControlEvents: UIControlEvents.TouchUpInside)
//        button.addTarget(_guifunctionsinstance, action: "restoreButtonBackgroundColor:", forControlEvents: UIControlEvents.TouchUpOutside)
    }
}