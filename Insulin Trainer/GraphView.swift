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
        let textFontAttributes = [
            NSFontAttributeName: UIFont.systemFontOfSize(11),
            NSForegroundColorAttributeName: UIColor.whiteColor()
        ]
        var adjustedGraphHeight = self.bounds.size.height - graph_bottom_margin
        var adjustedGraphWidth = self.bounds.size.width - graph_left_margin
        
        func drawBackground() {
            CGContextSetFillColorWithColor(ctx, UIColor.blackColor().CGColor)
            CGContextMoveToPoint(ctx, graph_left_margin, 0)
            CGContextAddLineToPoint(ctx, self.bounds.size.width, 0)
            CGContextAddLineToPoint(ctx, self.bounds.size.width, adjustedGraphHeight)
            CGContextAddLineToPoint(ctx, graph_left_margin, adjustedGraphHeight)
            CGContextClosePath(ctx)
            CGContextFillPath(ctx)
        }
        
        func drawData() {
            CGContextSetRGBStrokeColor(ctx, 1.0, 0.0, 0.0, 1.0)
            CGContextSetLineWidth(ctx, 0.75)
            var xOff: CGFloat = graph_left_margin
            CGContextMoveToPoint(ctx, xOff, 0)
            for datum in self.currentRenderData {
                var date = datum.time
                var bs = CGFloat(datum.values[0].toInt()!)
                var datumLineHeight = (bs/CGFloat(blood_sugar_max) - CGFloat(blood_sugar_min)/CGFloat(blood_sugar_max))*adjustedGraphHeight
                CGContextAddLineToPoint(ctx, xOff, adjustedGraphHeight - datumLineHeight)
                xOff += 5
            }
            CGContextStrokePath(ctx)
        }
        
        func drawLeftTicks() {
            for (index, label) in enumerate(self.verticalTicks) {
                var tickSpace = adjustedGraphHeight/CGFloat(self.verticalTicks.count)
                var tickY = adjustedGraphHeight - CGFloat(index)*(tickSpace)
                CGContextSetRGBStrokeColor(ctx, 1.0, 0.0, 0.0, 1.0)
                CGContextSetLineWidth(ctx, 0.75)
                CGContextMoveToPoint(ctx, graph_left_margin - graph_tick_size, tickY)
                CGContextAddLineToPoint(ctx, graph_left_margin, tickY)
                CGContextStrokePath(ctx)
                
                CGContextSetFillColorWithColor(ctx, UIColor.redColor().CGColor)
                var string: NSString = NSString(string: label)
                var stringBounds = string.sizeWithAttributes(textFontAttributes)
                string.drawInRect(CGRectMake(0, tickY - stringBounds.height, graph_left_margin, tickSpace), withAttributes: textFontAttributes)
            }
        }
        
        drawBackground()
        drawData()
        drawLeftTicks()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
