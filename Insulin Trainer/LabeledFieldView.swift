//
//  LabeledFieldView.swift
//  Insulin Trainer
//
//  Created by Weston Beecroft on 11/13/14.
//  Copyright (c) 2014 Weston Beecroft. All rights reserved.
//

import Foundation
import UIKit

class LabeledFieldView: UIView {
    var aboveFieldLabel: UILabel = UILabel()
    var textInput: UITextField = UITextField()
    var afterFieldLabel: UILabel = UILabel()
    var gapSize: CGFloat = 5.0
    var aboveLabelHeight: CGFloat = 20.0
    var textInputHeight: CGFloat = 30.0
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(options: (fieldWidth: Int, aboveFieldText: String, afterFieldText: String)) {
        super.init(frame: CGRectZero);
        
        self.aboveFieldLabel.text = options.aboveFieldText
        self.aboveFieldLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.textInput.backgroundColor = UIColor.whiteColor()
        self.textInput.keyboardType = UIKeyboardType.NumberPad
        self.textInput.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.afterFieldLabel.text = options.afterFieldText
        self.afterFieldLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.addSubview(self.aboveFieldLabel)
        self.addSubview(self.textInput)
        self.addSubview(self.afterFieldLabel)
        
        let viewsDict = ["aboveLabel": self.aboveFieldLabel, "field": self.textInput, "afterLabel": self.afterFieldLabel]
        
        let units_constraint_H:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:[afterLabel(120)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDict)
        let units_constraint_V:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:[afterLabel(30)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDict)
        self.afterFieldLabel.addConstraints(units_constraint_H)
        self.afterFieldLabel.addConstraints(units_constraint_V)
        
        let label_constraint_H:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:[aboveLabel(150)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDict)
        let label_constraint_V:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:[aboveLabel(\(self.aboveLabelHeight))]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDict)
        self.aboveFieldLabel.addConstraints(label_constraint_H)
        self.aboveFieldLabel.addConstraints(label_constraint_V)
        
        let field_constraint_H:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:[field(\(options.fieldWidth))]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDict)
        let field_constraint_V:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:[field(\(self.textInputHeight))]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDict)
        self.textInput.addConstraints(field_constraint_H)
        self.textInput.addConstraints(field_constraint_V)
        
        let parent_constraint_H:NSArray = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[field]-\(self.gapSize)-[afterLabel]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDict)
        let parent_constraint_V:NSArray = NSLayoutConstraint.constraintsWithVisualFormat("V:|-\(self.gapSize)-[aboveLabel]-\(self.gapSize)-[field]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDict)
        let unitFieldAlignConstraint = NSLayoutConstraint(item: afterFieldLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: textInput, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0.0)
        let labelFieldHAlign = NSLayoutConstraint(item: aboveFieldLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: textInput, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0.0)
        
        self.addConstraints(parent_constraint_H)
        self.addConstraints(parent_constraint_V)
        self.addConstraint(unitFieldAlignConstraint)
        self.addConstraint(labelFieldHAlign)
    }
}