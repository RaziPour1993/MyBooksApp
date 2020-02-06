//
//  ReadTimer.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/6/20.
//

import Foundation

struct ReadTimer {
    
    var startDate:Date?
    var endDate: Date?
    var currentPage: Int
    var lastReadDate: Date?
    var totalReadTimer: TimeInterval?
    
    init() {
        self.currentPage = 1
    }
    
}
