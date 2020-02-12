//
//  BookDetailViewModel.swift
//  MyBookDetailApp
//
//  Created by Mohammad Razipour on 2/4/20.
//

import Foundation

protocol BookDetailViewModelDelegate: class {
    
}

class BookDetailViewModel: TableViewModel {
    
    var sections: [TableViewSectionModel]!
    
    private weak var delegate: BookDetailViewModelDelegate?
    
    init(_ book: Book, delegate: BookDetailViewModelDelegate?) {
        self.delegate = delegate
        
        let items = book.sessionsRead.sorted { (a, b) -> Bool in
            return a.startDate > b.endDate
        }
        
        let sessionsReadCells = items.map { (item) -> TableViewCellModel in
            return SessionReadCellViewModel(item, delegate: nil)
        }
        
        let bookDetailCell = BookDetailCellViewModel(book, delegate: nil)
        
        let bookDetailSection = TableViewSection(cellModels: [bookDetailCell])
        let sessionReadSection = TableViewSection(cellModels: sessionsReadCells)
        self.sections = [bookDetailSection, sessionReadSection]
    }
    
}
