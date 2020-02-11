//
//  SessionRead.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/6/20.
//

import Foundation

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
    
}

