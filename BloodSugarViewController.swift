//
//  BloodSugarViewController.swift
//  Insulin Trainer
//
//  Created by Weston Beecroft on 11/13/14.
//  Copyright (c) 2014 Weston Beecroft. All rights reserved.
//

import Foundation
import UIKit

class BloodSugarViewController: AddSomethingViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        super.type = EntryType.BloodSugar
        
        self.view.backgroundColor = ADD_BS_COLOR
        self.navigationItem.title = "Add Blood Sugar"
        
        labeledFieldSet = LabeledFieldSet(labeledFieldViewConfigs: [(120, "Blood Sugar: ", "mg/dl")], buttonText: "Add", target: self, action: "add")
        self.view.addSubview(labeledFieldSet)
    }
}