//
//  BooksViewModel.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/4/20.
//

import Foundation

protocol BooksViewModelDelegate: class {
    func update(book: Book)
    func didSelect(book: Book)
    func didEndRead(book: Book)
    func canNotRead()
}

class BooksViewModel: TableViewModel {
    
    var sections: [TableViewSectionModel]!
    var books: Books!
    
    private weak var delegate: BooksViewModelDelegate?
    
    init(delegate: BooksViewModelDelegate?) {
        self.sections = []
        self.delegate = delegate
    }
    
    init(_ books: Books, delegate: BooksViewModelDelegate?) {
        self.books = books
        self.delegate = delegate
        
        let bookCellViewModels = books.compactMap { (book) -> BookCellViewModel? in
            if book.readTimer.readMode != .noReading {
                return BookCellViewModel(book, delegate: self)
            }
            return nil
        }
        
        let bookInfoCellViewModels = books.compactMap { (book) -> BookInfoCellViewModel? in
            if book.readTimer.readMode == .noReading {
                return BookInfoCellViewModel(book, delegate: self)
            }
            return nil
        }
        
        let bookInfoSection = TableViewSection(cellModels: bookInfoCellViewModels)
        let bookSection = TableViewSection(cellModels: bookCellViewModels)
        self.sections = [bookSection, bookInfoSection]
    }
    
}

extension BooksViewModel: BookCellViewModelDelegate {
    
    func pauseRead(book: BookCellViewModel, at time: TimeInterval) {
        var book = book.book
        var readTimer = book.readTimer
        readTimer.totalReadTimer = time
        readTimer.readMode = .pauseReading
        readTimer.lastReadDate = nil
        book.readTimer = readTimer
        self.delegate?.update(book: book)
    }
    
    func resumeRead(book: BookCellViewModel, at time: TimeInterval) {
        var book = book.book
        var readTimer = book.readTimer
        readTimer.readMode = .reading
        readTimer.lastReadDate = Calendar.current.date(byAdding: .second, value: -(Int(readTimer.totalReadTimer!)), to: Date())
        readTimer.totalReadTimer = nil
        book.readTimer = readTimer
        self.delegate?.update(book: book)
    }
    
    func endRead(book: BookCellViewModel, at time: TimeInterval) {
        var book = book.book
        var readTimer = book.readTimer
        readTimer.readMode = .pauseReading
        readTimer.endDate = Date()
        readTimer.lastReadDate = nil
        readTimer.totalReadTimer = time
        book.readTimer = readTimer
        self.delegate?.update(book: book)
        self.delegate?.didEndRead(book: book)
    }
    
    func didSelect(book: BookCellViewModel) {
        self.delegate?.didSelect(book: book.book)
    }
    
}

extension BooksViewModel: BookInfoCellViewModelDelegate {
    
    func startRead(book: BookInfoCellViewModel) {
        if !sections.first!.cellModels.isEmpty {
            self.delegate?.canNotRead()
            return
        }
        
        let readTimer = ReadTimer(startDate: Date(), lastReadDate: Date(), readMode: .reading)
        var book = book.book
        book.readTimer = readTimer
        self.delegate?.update(book: book)
    }
    
    func didSelect(book: BookInfoCellViewModel) {
        self.delegate?.didSelect(book: book.book)
    }    
    
}
