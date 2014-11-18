//
//  GraphView.swift
//  Insulin Trainer
//
//  Created by Weston Beecroft on 11/17/14.
//  Copyright (c) 2014 Weston Beecroft. All rights reserved.
//

import Foundation
import UIKit

class GraphView: UIView {
    
    var currentRenderData: [BSDatum]!
    var horizontalTicks: [String] = []
    var verticalTicks: [String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    func renderWithData(data: [BSDatum], timeUnitSetting: TimeUnit) {
        self.currentRenderData = data
    }
    
    override func drawRect(rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        CGContextSetRGBStrokeColor(ctx, 1.0, 0.0, 0.0, 1.0)
        CGContextSetLineWidth(ctx, 0.75)
        var xOff: CGFloat = 0
        CGContextMoveToPoint(ctx, xOff, 0)
        for datum in self.currentRenderData {
            var date = datum.time
            var bs = CGFloat(datum.values[0].toInt()!)
            CGContextAddLineToPoint(ctx, xOff, self.bounds.size.height*(bs/200))
            xOff += 5
        }
        
        CGContextStrokePath(ctx)
        
        self.backgroundColor = UIColor.blackColor()
        
        super.drawRect(rect)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
