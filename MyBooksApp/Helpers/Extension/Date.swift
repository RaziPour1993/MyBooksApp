//
//  Date.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/10/20.
//

import Foundation

extension Date {
    
    func toString(withFormat format: String = "yyyy/MM/d, HH:mm:ss") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = .current
        dateFormatter.locale = .current
        let str = dateFormatter.string(from: self)
        return str
    }
    
}

