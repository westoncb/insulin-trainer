//
//  AddSomethingViewController.swift
//  Insulin Trainer
//
//  Created by Weston Beecroft on 11/13/14.
//  Copyright (c) 2014 Weston Beecroft. All rights reserved.
//

import Foundation
import UIKit

class AddSomethingViewController: UIViewController {
    var labeledFieldSet: LabeledFieldSet!
    var type: EntryType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "cancel")
        
        var tapRecognizer = UITapGestureRecognizer(target:self, action: "bgTap")
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    override func viewDidAppear(animated: Bool) {
        self.labeledFieldSet.textInput(0).becomeFirstResponder()
        var screenSize = UIScreen.mainScreen().bounds.size
        self.labeledFieldSet.bounds = UIScreen.mainScreen().bounds
        self.labeledFieldSet.center = CGPointMake(screenSize.width/2, screenSize.height/2)
    }
    
    func cancel() {
        self.returnHome()
    }
    
    func add() {
        var textInputs = self.labeledFieldSet.textInputs()
        
        for textInput in textInputs {
            
        }
        
        self.returnHome()
    }
    
    func returnHome() {
        var navController = self.view.window!.rootViewController as UINavigationController
        navController.popViewControllerAnimated(true)
    }
    
    func bgTap() {
        UIApplication.sharedApplication().sendAction("resignFirstResponder", to:nil, from:nil, forEvent:nil)
    }
}