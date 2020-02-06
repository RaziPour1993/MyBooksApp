//
//  SessionRead.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/6/20.
//

import Foundation

typealias SessionsRead = [SessionRead]

struct SessionRead {
    
    var startDate:Date?
    var endDate: Date?
    var pageNumber: Int16
    var totalReadTimer: TimeInterval?
    var pagesCountRead: Int16?
    
    init() {
        self.pageNumber = 1
    }
    
}
