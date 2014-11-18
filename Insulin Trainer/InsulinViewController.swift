//
//  InsulinViewController.swift
//  Insulin Trainer
//
//  Created by Weston Beecroft on 11/13/14.
//  Copyright (c) 2014 Weston Beecroft. All rights reserved.
//

import Foundation
import UIKit

class InsulinViewController: AddSomethingViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        super.type = EntryType.Insulin
        
        self.view.backgroundColor = ADD_INSULIN_COLOR
        self.navigationItem.title = "Add Insulin Dose"
        
        labeledFieldSet = LabeledFieldSet(labeledFieldViewConfigs: [(120, "Insulin Dose: ", "mL")], buttonText: "Add", target: self, action: "add")
        self.view.addSubview(labeledFieldSet)
    }
}