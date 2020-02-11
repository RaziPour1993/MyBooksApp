//
//  BookInfoCellViewModel.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/4/20.
//

import Foundation
import UIKit

protocol BookInfoCellViewModelDelegate: class {
    func startRead(book: BookInfoCellViewModel)
    func didSelect(book: BookInfoCellViewModel)
}

class BookInfoCellViewModel: TableViewCellModel, Equatable {
    
    static func == (lhs: BookInfoCellViewModel, rhs: BookInfoCellViewModel) -> Bool {
        return lhs.book.id == rhs.book.id
    }
    
    func identifier() -> String {
        return "BookInfoTableViewCell"
    }

    
    weak var delegate: BookInfoCellViewModelDelegate?
    
    private(set) var name: String
    private(set) var author: String
    private(set) var pagesCount: String
    private(set) var currentPage: String
    private(set) var cover: UIImage?
    private(set) var descriptions: String
    private(set) var progress: Float
    private(set) var totalTime: String
    
    private(set) var book: Book
    
    init(_ book: Book, delegate: BookInfoCellViewModelDelegate) {
        self.delegate = delegate
        self.book = book
        self.name = book.name
        self.author = book.author
        self.pagesCount = book.pagesCount.description
        self.currentPage = book.currentPage.description
        self.progress = Float(book.currentPage)
        self.descriptions = book.descriptions
        if let cover =  book.cover { self.cover = UIImage(data: cover) }
        self.totalTime = self.book.totalReadTime.asString(style: .positional)
    }
    
}

extension BookInfoCellViewModel: BookInfoTableViewCellDelegate {
    
    func didTapStartRead() {
        self.delegate?.startRead(book: self)
    }
    
    func didSelectBook() {
        self.delegate?.didSelect(book: self)
    }
    
}
