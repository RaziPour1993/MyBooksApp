//
//  BookCellViewModel.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/4/20.
//

import Foundation
import UIKit

protocol SessionReadCellViewModelDelegate: class {
    
}

class SessionReadCellViewModel: TableViewCellModel {
    
    func identifier() -> String {
        return "SessionReadTableViewCell"
    }
    
    weak var delegate: SessionReadCellViewModelDelegate?
    
    private(set) var startDate: String
    private(set) var endDate: String
    private(set) var totalReadTimer: String
    private(set) var pageNumber: String
    
    init(_ item: SessionRead, delegate: SessionReadCellViewModelDelegate?) {
        self.startDate = item.startDate.toString()
        self.endDate = item.endDate.toString()
        self.totalReadTimer = item.totalReadTimer.asString(style: .positional)
        self.pageNumber = item.pageNumber.description
    }
    
}
