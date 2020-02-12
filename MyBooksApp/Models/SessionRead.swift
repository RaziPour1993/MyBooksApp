//
//  SessionRead.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/6/20.
//

import Foundation
import CoreData

typealias SessionsRead = [SessionRead]

struct SessionRead {
    
    var startDate:Date
    var endDate: Date
    var totalReadTimer: TimeInterval
    var pageNumber: Int16
    
    init(_ startDate: Date, _ endDate: Date, _ totalReadTimer: TimeInterval, _ pageNumber: Int16) {
        self.startDate = startDate
        self.endDate = endDate
        self.totalReadTimer = totalReadTimer
        self.pageNumber = pageNumber
    }
    
    init(_ entity: SessionReadEntity) {
        self.startDate = entity.startDate!
        self.endDate = entity.endDate!
        self.totalReadTimer = entity.totalReadTimer
        self.pageNumber = entity.pageNumber
    }
    
}

