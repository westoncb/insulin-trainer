//
//  GraphView.swift
//  Insulin Trainer
//
//  Created by Weston Beecroft on 11/17/14.
//  Copyright (c) 2014 Weston Beecroft. All rights reserved.
//

import Foundation
import UIKit

let graph_vertical_ticks: Int = 10
let graph_horizontal_ticks: Int = 10
let graph_left_margin: CGFloat = 25
let graph_bottom_margin: CGFloat = 25
let blood_sugar_min: Int = 15
let blood_sugar_max: Int = 250
let graph_tick_size: CGFloat = 12

class GraphView: UIView {
    
    var currentRenderData: [BSDatum]!
    var horizontalTicks: [String] = []
    var verticalTicks: [String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    func renderWithData(data: [BSDatum]) {
        self.currentRenderData = data
        
        self.createTicks()
    }
    
    func createTicks() {
        let calendar: NSCalendar = NSCalendar.currentCalendar()
        
        //----vertical ticks-----
        self.verticalTicks = []
        var verticalRange = blood_sugar_min..<blood_sugar_max
        var verticalTickSize: Int = (verticalRange.endIndex - verticalRange.startIndex)/graph_vertical_ticks
        for tick in 0...graph_vertical_ticks {
            var tickValue = (Int(verticalRange.startIndex) + tick*verticalTickSize)
            self.verticalTicks.append("\(tickValue)")
        }
        
        //----horizontal ticks-----
        self.horizontalTicks = []
        var firstValue: Float = 0
        var valueIncrement: Float = 0
        var beforeString: String = ""
        var afterString: String = ""
        var firstTickDate: NSDate = self.currentRenderData[0].time
        
        switch BSDatabase.instance.activeTimeUnit {
        case .QuarterDay, .HalfDay, .Day:
            var firstTickComponents: NSDateComponents = calendar.components(NSCalendarUnit.HourCalendarUnit, fromDate: firstTickDate)
            firstValue = Float(firstTickComponents.hour)
            beforeString = "hour "
            
            switch BSDatabase.instance.activeTimeUnit {
            case .QuarterDay:
                valueIncrement = 6.0/Float(graph_horizontal_ticks)
            case .HalfDay:
                valueIncrement = 12.0/Float(graph_horizontal_ticks)
            case .Day:
                valueIncrement = 24.0/Float(graph_horizontal_ticks)
            default:
                println("got to an invalid point in switch (on activeTimeUnit, GraphView.swift")
            }
        case .Week, .Month:
            var firstTickComponents: NSDateComponents = calendar.components(NSCalendarUnit.DayCalendarUnit, fromDate: firstTickDate)
            firstValue = Float(firstTickComponents.day)
            beforeString = "day "
            
            if (BSDatabase.instance.activeTimeUnit == TimeUnit.Week) {
                valueIncrement = 7.0/Float(graph_horizontal_ticks)
            } else {
                valueIncrement = 30/Float(graph_horizontal_ticks)
            }
        case .None:
            println("error: activeTimeUnit = None")
        }
        
        for index in 0...graph_horizontal_ticks {
            var tickValue: Float = firstValue+(Float(index)*valueIncrement)
            var fullTickLabel = "\(beforeString)\(tickValue)\(afterString)"
            self.horizontalTicks.append(fullTickLabel)
        }
    }
    
    override func drawRect(rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        CGContextSetRGBStrokeColor(ctx, 1.0, 0.0, 0.0, 1.0)
        CGContextSetLineWidth(ctx, 0.75)
        var xOff: CGFloat = graph_left_margin
        CGContextMoveToPoint(ctx, xOff, 0)
        for datum in self.currentRenderData {
            var date = datum.time
            var bs = CGFloat(datum.values[0].toInt()!)
            CGContextAddLineToPoint(ctx, xOff, self.bounds.size.height*(bs/200))
            xOff += 5
        }
        
        for (index, label) in enumerate(self.verticalTicks) {
            var tickSpace = self.bounds.size.height/CGFloat(self.verticalTicks.count)
            var tickY = self.bounds.size.height - CGFloat(index)*(tickSpace)
            CGContextMoveToPoint(ctx, graph_left_margin - graph_tick_size, tickY)
            CGContextAddLineToPoint(ctx, graph_left_margin, tickY)
        }
        
        CGContextStrokePath(ctx)
        
        self.backgroundColor = UIColor.blackColor()
        
        super.drawRect(rect)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
