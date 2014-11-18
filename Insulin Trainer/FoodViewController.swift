//
//  FoodViewController.swift
//  Insulin Trainer
//
//  Created by Weston Beecroft on 11/13/14.
//  Copyright (c) 2014 Weston Beecroft. All rights reserved.
//

import Foundation
import UIKit

class FoodViewController: AddSomethingViewController {
    var foodNameInput: UITextField!
    var carbCountInput: UITextField!
    var glycemicIndexInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.type = EntryType.Food
        
        self.view.backgroundColor = ADD_FOOD_COLOR
        self.navigationItem.title = "Add Food"
        
        super.labeledFieldSet = LabeledFieldSet(labeledFieldViewConfigs: [(120, "Food (optional): ", ""), (120, "Carbohydrates: ", "grams"), (120, "Glycemic Index: ", "")], buttonText: "Add", target: self, action: "add")
        
        foodNameInput = labeledFieldSet.textInput(0)
        carbCountInput = labeledFieldSet.textInput(1)
        glycemicIndexInput = labeledFieldSet.textInput(2)
        
        foodNameInput.keyboardType = UIKeyboardType.Default
        
        self.view.addSubview(labeledFieldSet)
    }
}