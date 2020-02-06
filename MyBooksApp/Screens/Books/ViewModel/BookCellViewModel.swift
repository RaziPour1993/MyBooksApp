//
//  BookCellViewModel.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/4/20.
//

import Foundation
import UIKit

protocol BookCellViewModelDelegate: class {
    
}

class BookCellViewModel: TableViewCellModel {
    
    func identifier() -> String {
        return "BookTableViewCell"
    }
    
    weak var delegate: BookCellViewModelDelegate?
    var name: String
    var author: String
    var pagesCount: String
    var cover: UIImage?
    var descriptions: String
    
    init(_ book: Book, delegate: BookCellViewModelDelegate) {
        self.delegate = delegate
        
        self.name = book.name
        self.author = book.author
        self.pagesCount = book.pagesCount.description
        self.descriptions = book.descriptions
        
        if let cover =  book.cover {
            self.cover = UIImage(data: cover)
        }
        
    }
    
}
