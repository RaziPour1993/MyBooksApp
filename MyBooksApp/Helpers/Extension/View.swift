//
//  View.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/5/20.
//

import Foundation
import UIKit

extension UIView {
    
    func setBorder(color: UIColor = #colorLiteral(red: 0.7411764264, green: 0.7411764264, blue: 0.7411764264, alpha: 1), borderWidth: CGFloat = 1, cornerRadius: CGFloat = 5) {
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
    }
    
}
