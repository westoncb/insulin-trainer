//
//  GraphWidget.swift
//  Insulin Trainer
//
//  Created by Weston Beecroft on 11/17/14.
//  Copyright (c) 2014 Weston Beecroft. All rights reserved.
//

import Foundation
import UIKit

let GraphWidget_top_height: CGFloat = 40
let GraphWidget_top_button_width: CGFloat = 30

class GraphWidget: UIView {
    var graphView: GraphView!
    var prevButton: UIButton!
    var nextButton: UIButton!
    var graphLabel: UILabel!
    
    override init(frame: CGRect) {
     super.init(frame: frame)
        self.graphView = GraphView(frame: CGRectMake(0, GraphWidget_top_height, frame.size.width, frame.size.height-GraphWidget_top_height))
        
        prevButton = UIButton(frame: CGRectMake(0, 0, GraphWidget_top_button_width, GraphWidget_top_height))
        prevButton.setTitle("<-", forState: UIControlState.Normal)
        GlobalUIFunctions.instance().customizeButton(prevButton)
            
        nextButton = UIButton(frame: CGRectMake(frame.size.width - GraphWidget_top_button_width, 0, GraphWidget_top_button_width, GraphWidget_top_height))
        nextButton.setTitle("->", forState: UIControlState.Normal)
        GlobalUIFunctions.instance().customizeButton(nextButton)
        
        graphLabel = UILabel(frame: CGRectMake(GraphWidget_top_button_width, 0, frame.size.width-(GraphWidget_top_button_width*2), GraphWidget_top_height))
        graphLabel.text = "test graph!"
        graphLabel.textAlignment = NSTextAlignment.Center
        
        self.addSubview(prevButton)
        self.addSubview(graphLabel)
        self.addSubview(nextButton)
        self.addSubview(graphView)
        
        self.dateTests()
        var data = BSDatabase.instance.data
        var dataToRenderOpt = BSDatabase.instance.dataForDate(data[0].time)
        if let dataToRender = dataToRenderOpt {
            self.graphView.renderWithData(dataToRender)
        }
    }
    
    func dateTests() {
        for index in 0...100 {
            let calendar = NSCalendar.currentCalendar()
            let today = NSDate()
            var normalizedRand = myRand()
            var plusOrMinusFifty: Int = Int(normalizedRand * 101 - 50)
            
            //            var dateString = "3/15/2012 9:15 PM"
            //            let formatter = NSDateFormatter()
            //            formatter.dateFormat = "MM/dd/yyyy HH:mm a"
            //            var randomDate = formatter.dateFromString(dateString)
            
            var randomComps = calendar.components(NSCalendarUnit.DayCalendarUnit, fromDate: today)
            randomComps.day = randomComps.day + plusOrMinusFifty
            randomComps.year = 2014
            
            var randomDate = calendar.dateFromComponents(randomComps)
            
            BSDatabase.instance.addDatum(BSDatum(date: randomDate!, type: EntryType.BloodSugar, values: ["\(self.randomBloodSugar())"]))
        }
        
        BSDatabase.instance.sortByDate()
        BSDatabase.instance.setPerspective(TimeUnit.Month)
        BSDatabase.instance.printData()
        BSDatabase.instance.printPerspectiveIndices()
        println("**********************")
        BSDatabase.instance.printPerspective()
    }
    
    func randomBloodSugar() ->Int {
        return Int(myRand()*150+50)
    }
    
    func myRand() ->Float {
        return Float(arc4random())/Float(UInt32.max)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
