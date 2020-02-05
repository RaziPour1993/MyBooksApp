//
//  BookCellViewModel.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/4/20.
//

import Foundation

protocol BookCellViewModelDelegate: class {
    
}

class BookCellViewModel: TableViewCellModel {
    
    func identifier() -> String {
        return "BookTableViewCell"
    }
    
    weak var delegate: BookCellViewModelDelegate?
    
    init(_ book: Book, delegate: BookCellViewModelDelegate) {
        self.delegate = delegate
    }
    
}
