//
//  BSDatabase.swift
//  Insulin Trainer
//
//  Created by Weston Beecroft on 11/14/14.
//  Copyright (c) 2014 Weston Beecroft. All rights reserved.
//

import Foundation

enum TimeUnit {
    case QuarterDay
    case HalfDay
    case Day
    case Week
    case Month
    case None
}

private let _theInstance = BSDatabase()

class BSDatabase {
    class var instance: BSDatabase {return _theInstance}
    
    //Date components for making comparisions between dates using different time intervals
    class var quarterDayComps: NSDateComponents {var comps = NSDateComponents(); comps.hour = 6; return comps}
    class var halfDayComps: NSDateComponents {var comps = NSDateComponents(); comps.hour = 12; return comps}
    class var dayComps: NSDateComponents {var comps = NSDateComponents(); comps.day = 1; return comps}
    class var weekComps: NSDateComponents {var comps = NSDateComponents(); comps.day = 7; return comps}
    class var monthComps: NSDateComponents {var comps = NSDateComponents(); comps.month = 1; return comps}
    
    var data = [BSDatum]()
    var activeTimeUnit: TimeUnit
    var currentCalendarUnits: NSCalendarUnit!
    var perspective = [Range<Int>]() //represents a partition of the database into some TimeUnit
    var perspectiveIndex: Int = 0 //used for functions getting next/previous database segments
    
    private init() {
        self.activeTimeUnit = TimeUnit.None
    }
    
    func addDatum(datum: BSDatum) {
        self.data.append(datum)
    }
    
    func setPerspective(timeUnit: TimeUnit) {
        if (self.activeTimeUnit == timeUnit) {
            return
        } else {
            self.activeTimeUnit = timeUnit
            
            switch self.activeTimeUnit {
            case .QuarterDay:
                self.currentCalendarUnits = NSCalendarUnit.CalendarUnitHour
            case .HalfDay:
                self.currentCalendarUnits = NSCalendarUnit.CalendarUnitHour
            case .Day:
                self.currentCalendarUnits = NSCalendarUnit.CalendarUnitDay
            case .Week:
                self.currentCalendarUnits = NSCalendarUnit.CalendarUnitDay
            case .Month:
                self.currentCalendarUnits = NSCalendarUnit.CalendarUnitMonth
            case .None:
                println("error! invalid time unit: None!")
            }
        }
        
        self.perspective = []
        var startedUnit = false
        var rangeStart: Int!
        var firstDateInUnit: NSDate!
        var rangeStartOffset = 0
        for (index, datum) in enumerate(data) {
            if (!startedUnit) {
                if let last = perspective.last {
                    rangeStart = last.endIndex+1
                } else {
                    rangeStart = 0
                }
                startedUnit = true
                firstDateInUnit = data[rangeStart].time
            }
            
            var thisDate = datum.time
            var dateInRange = self.isDateInRange(firstDateInUnit, second: thisDate)
            if (!dateInRange) {
                perspective.append(Range(start: rangeStart, end: index-1))
                startedUnit = false
                rangeStartOffset = 1
            }
        }
        
        //if we reached the end of the array, but not the end of the time unit, make the last range go to the end of the array
        if (startedUnit) {
            var optRange = perspective.last?
            if let lastRange = optRange {
                var startIndex = lastRange.startIndex
                perspective[perspective.count-1] = Range(start: startIndex, end: perspective.count-1)
            }
            
        }
    }
    
    func dateDifference(first: NSDate, second: NSDate, calendarUnits: NSCalendarUnit) ->NSDateComponents {
        var calendar = NSCalendar.currentCalendar()
        
        return calendar.components(calendarUnits, fromDate: first, toDate: second, options: NSCalendarOptions.allZeros)
    }
    
    private func isDateInRange(first: NSDate, second: NSDate) ->Bool {
        var difference = dateDifference(first, second: second, calendarUnits: self.currentCalendarUnits)
        
        switch self.activeTimeUnit {
        case .QuarterDay:
            return difference.hour < BSDatabase.quarterDayComps.hour
        case .HalfDay:
            return difference.hour < BSDatabase.halfDayComps.hour
        case .Day:
            return difference.day < BSDatabase.dayComps.day
        case .Week:
            return difference.day < BSDatabase.weekComps.day
        case .Month:
            return difference.month < BSDatabase.monthComps.month
        case .None:
            println("error! invalid time unit: None!")
            return false;
        }
    }
    
    func printData() {
        for (index, datum) in enumerate(self.data) {
            println("\(index): \(datum.doThePrint())")
        }
    }
    
    func printPerspectiveIndices() {
        for (index, bounds) in enumerate(perspective) {
            println("indices: \(index): \(bounds)")
        }
    }
    
    func printPerspective() {
        var segmentIndex = 0;
        var currentSegment = perspective[segmentIndex];
        
        for (index, datum) in enumerate(self.data) {
            var printedEntry = false;
            if index == currentSegment.startIndex {
                println("--------start:\(segmentIndex)------------")
                println("a: \(index): \(datum.doThePrint())")
                printedEntry = true;
            }
            
            if index == currentSegment.endIndex {
                if !printedEntry {
                    println("b: \(index): \(datum.doThePrint())")
                    printedEntry = true
                }
                
                var lastSegmentIndex = segmentIndex
                if segmentIndex < perspective.count-1 {
                    segmentIndex++
                    currentSegment = perspective[segmentIndex]
                }
                println("--------end:\(lastSegmentIndex)-------------")
            }
            
            if (!printedEntry) {
                println("c: \(index): \(datum.doThePrint())")
            }
        }
    }
    
    func sortByDate() {
        func dateCompare(first: BSDatum, second: BSDatum) ->Bool {
            return first.time.compare(second.time) == NSComparisonResult.OrderedAscending
        }
        
        self.data.sort(dateCompare)
    }
    
    func perspectiveSegmentWithDate(date: NSDate) ->(index: Int, segment: Range<Int>)? { //return includes the index of the segment
        for segment in self.perspective {
            for index in segment {
                var row = self.data[index]
                if (row.time.isEqualToDate(date)) { //just 'isEqual' probably isn't good enough here
                    return (index, segment)
                }
            }
        }
        
        return nil
    }
    
    func dataForCurrentDate() ->[BSDatum]? {
        return dataForDate(NSDate())
    }
    
    func dataForDate(date: NSDate) ->[BSDatum]? {
        var possibleSegmentAndIndex: (index: Int, segment: Range<Int>)? = self.perspectiveSegmentWithDate(date)
        
        if let segmentAndIndex = possibleSegmentAndIndex {
            self.perspectiveIndex = segmentAndIndex.index
            return Array(self.data[segmentAndIndex.segment])
        }
        
        return nil
    }
    
    func dataForNextDate() ->[BSDatum]? {
        return [];
    }
    
    func dataForPreviousDate() ->[BSDatum]? {
        return [];
    }
}