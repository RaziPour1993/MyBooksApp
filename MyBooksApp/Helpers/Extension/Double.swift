//
//  Double.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/7/20.
//

import Foundation

extension Double {
    
    func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        formatter.unitsStyle = style
        
        guard let formattedString = formatter.string(from: self) else { return "" }
        return formattedString
    }
    
}
