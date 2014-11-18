//
//  AddMenu.swift
//  Insulin Trainer
//
//  Created by Weston Beecroft on 11/12/14.
//  Copyright (c) 2014 Weston Beecroft. All rights reserved.
//

import Foundation
import UIKit

class AddMenu: UIView {
    var isOpen = false;
    class var buttonXPadding: CGFloat {return 6}
    class var buttonYPadding: CGFloat {return 3}
    class var menuRightPadding: CGFloat {return 0}
    class var buttonHeight: CGFloat {return 50}
    class var buttonBorderColor: CGColor {return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6).CGColor}
    class var mHeight: CGFloat {return buttonHeight*3 + buttonYPadding*3}
    class var mWidth: CGFloat {return 250}
    
    class var bloodSugarVC: BloodSugarViewController {return BloodSugarViewController()}
    class var insulinVC: InsulinViewController {return InsulinViewController()}
    class var foodVC: FoodViewController {return FoodViewController()}
    
    override init() {        
        let screenBounds = UIScreen.mainScreen().bounds
        let frame = CGRectMake(screenBounds.width - (AddMenu.mWidth+AddMenu.menuRightPadding), -AddMenu.mHeight, AddMenu.mWidth, AddMenu.mHeight)
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red: 0.5, green: 0.6, blue: 0.7, alpha: 0.9)
        var buttonY: CGFloat = 1.0
        
        let bloodSugarButton: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.customizeButton(bloodSugarButton, yPos: buttonY, title: "Blood Sugar Reading")
        buttonY += bloodSugarButton.frame.size.height + AddMenu.buttonYPadding
        bloodSugarButton.addTarget(self, action: "bloodSugarButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        GlobalUIFunctions.instance().customizeButton(bloodSugarButton)
        
        let insulinButton: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.customizeButton(insulinButton, yPos: buttonY, title: "Insulin Dose")
        buttonY += insulinButton.frame.size.height + AddMenu.buttonYPadding
        insulinButton.addTarget(self, action: "insulinButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        GlobalUIFunctions.instance().customizeButton(insulinButton)
        
        let foodButton: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.customizeButton(foodButton, yPos: buttonY, title: "Food Consumption")
        foodButton.addTarget(self, action: "foodButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        GlobalUIFunctions.instance().customizeButton(foodButton)
        
        self.addSubview(bloodSugarButton)
        self.addSubview(insulinButton)
        self.addSubview(foodButton)
    }
    
    func bloodSugarButtonPressed() {
        var navController = self.window!.rootViewController as UINavigationController
        navController.pushViewController(AddMenu.bloodSugarVC, animated: true)
    }
    
    func insulinButtonPressed() {
        var navController = self.window!.rootViewController as UINavigationController
        navController.pushViewController(AddMenu.insulinVC, animated: true)
    }
    
    func foodButtonPressed() {
        var navController = self.window!.rootViewController as UINavigationController
        navController.pushViewController(AddMenu.foodVC, animated: true)
    }
    
    func customizeButton(button: UIButton, yPos: CGFloat, title: String) {
        let buttonSize = CGSizeMake(AddMenu.mWidth - AddMenu.buttonXPadding, AddMenu.buttonHeight)
        let xPos: CGFloat = AddMenu.buttonXPadding/2
        
        button.layer.borderColor = AddMenu.buttonBorderColor
        button.layer.borderWidth = 1
        button.frame = CGRectMake(xPos, yPos, buttonSize.width, buttonSize.height)
        button.setTitle(title, forState: UIControlState.Normal)
    }
    
    func open() {
        UIView.animateWithDuration(0.5, animations: {
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + AddMenu.mHeight, self.frame.size.width, self.frame.size.height)
        })
        
        isOpen = true;
    }
    
    func close() {
        UIView.animateWithDuration(0.5, animations: {
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - AddMenu.mHeight, self.frame.size.width, self.frame.size.height)
        })
        isOpen = false;
    }
    
    func toggle() {
        if isOpen {
            self.close()
        } else {
            self.open()
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}