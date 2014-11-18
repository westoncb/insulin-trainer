//
//  LabeledFieldSet.swift
//  Insulin Trainer
//
//  Created by Weston Beecroft on 11/13/14.
//  Copyright (c) 2014 Weston Beecroft. All rights reserved.
//

import Foundation
import UIKit

class LabeledFieldSet: UIView {
    let button: UIButton = UIButton()
    var labeledFieldViews: [LabeledFieldView] = [LabeledFieldView]()
    
    init(labeledFieldViewConfigs: [(fieldWidth: Int, aboveFieldText: String, afterFieldText: String)], buttonText: String, target: AnyObject, action: Selector) {
        super.init(frame: CGRectZero)
        
        var viewsDict = ["button": (self.button as UIView)]
        var visualFormatString: String = "V:|"
        for (index, config) in enumerate(labeledFieldViewConfigs) {
            var labeledFieldView = LabeledFieldView(options: config)
            labeledFieldView.setTranslatesAutoresizingMaskIntoConstraints(false)
            var lfvName = "lfv\(index)"
            viewsDict.updateValue(labeledFieldView, forKey: lfvName)
            visualFormatString += "-2-[\(lfvName)]"
            
            self.addSubview(labeledFieldView)
            
            labeledFieldViews.append(labeledFieldView)
        }
        
        let betweenLFVs_constraint_V:NSArray = NSLayoutConstraint.constraintsWithVisualFormat(visualFormatString, options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDict)
        self.addConstraints(betweenLFVs_constraint_V)
        
        self.button.setTitle(buttonText, forState: UIControlState.Normal)
        self.button.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.button.layer.borderColor = UIColor.whiteColor().CGColor
        self.button.layer.borderWidth = 1
        self.button.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        let button_constraint_width:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:[button(50)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDict)
        let button_constraint_height:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:[button(30)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDict)
        self.button.addConstraints(button_constraint_width + button_constraint_height)
        self.addSubview(self.button)
        
        let addButton_constraint_V = NSLayoutConstraint(item: self.button, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: labeledFieldViews.last, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10)
        let addButton_constraint_H = NSLayoutConstraint(item: self.button, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: labeledFieldViews.last?.textInput, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0.0)
        self.addConstraints([addButton_constraint_V, addButton_constraint_H])
        
    }
    
    func textInputs() ->[LabeledFieldView] {
        return self.labeledFieldViews
    }
    
    func textInput(index: Int) ->UITextField {
        return self.labeledFieldViews[index].textInput
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}