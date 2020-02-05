//
//  BooksViewModel.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/4/20.
//

import Foundation

protocol BooksViewModelDelegate: class {
    
}

class BooksViewModel: TableViewModel {
    
    var sections: [TableViewSectionModel]!
    
    private weak var delegate: BooksViewModelDelegate?
    
    init(delegate: BooksViewModelDelegate) {
        self.sections = []
        self.delegate = delegate
    }
    
    init(_ books: Books, delegate: BooksViewModelDelegate) {
        
        self.delegate = delegate
        
        let cellModels = books.map { (item) -> TableViewCellModel in
            let model = BookCellViewModel(item, delegate: self)
            return model
        }
        
        let section = TableViewSection(cellModels: cellModels)
        self.sections = [section]
    }
    
}

extension BooksViewModel: BookCellViewModelDelegate {
    
    
}
