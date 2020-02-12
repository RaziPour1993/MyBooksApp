//
//  ReadTimer.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/6/20.
//

import Foundation
import CoreData

struct ReadTimer {
    
    var startDate: Date?
    var endDate: Date?
    var lastReadDate: Date?
    var totalReadTimer: TimeInterval?
    var readMode: ReadMode
    
    init() {
        self.readMode = .noReading
    }
    
    init(startDate:Date? = nil, endDate: Date? = nil, lastReadDate: Date? = nil, totalReadTimer: TimeInterval? = nil, readMode: ReadMode) {
        self.startDate = startDate
        self.endDate = endDate
        self.lastReadDate = lastReadDate
        self.totalReadTimer = totalReadTimer
        self.readMode = readMode
    }
    
    init(entity: ReadTimerEntity) {
        
        self.startDate = entity.startDate
        self.endDate = entity.endDate
        self.lastReadDate = entity.lastReadDate
        self.readMode = ReadMode(rawValue: entity.readMode!)!
        self.totalReadTimer = entity.totalReadTimer
        
    }
    
}
