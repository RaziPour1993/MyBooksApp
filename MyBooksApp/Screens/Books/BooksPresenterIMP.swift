//
//  BooksPresenterIMP.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/4/20.
//

import Foundation

class BooksPresenterIMP {
    
    weak var view: BooksPresentingView?
    weak var delegate: BooksScreenDelegate?
    var repository: BooksRepository
    
    var booksViewModel: BooksViewModel! {
        didSet {
            self.view?.updated(books: self.booksViewModel)
        }
    }
    
    var books: Books {
        didSet {
            self.booksViewModel = BooksViewModel(books, delegate: self)
        }
    }
    
    var currentBook: Book?
    
    init(_ repository: BooksRepository, _ delegate: BooksScreenDelegate) {
        self.books = []
        self.delegate = delegate
        self.repository = repository
        self.booksViewModel = BooksViewModel(delegate: self)
    }
    
    deinit {
        print(self)
    }
    
}

extension BooksPresenterIMP: BooksPresenter {
    
    func present() {
        self.getBooks()
    }
    
    func set(view: BooksPresentingView) {
        self.view = view
    }
    
    func didTapAddBook() {
        self.delegate?.addBook()
    }
    
    func bookAdded(book: Book) {
        self.books.append(book)
    }
    
}

extension BooksPresenterIMP {
    
    func getBooks() {
        self.repository.books { (result) in
            switch result {
            case .success(let items):
                self.books = items
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension BooksPresenterIMP: BooksViewModelDelegate {
    
    func canNotRead() {
        self.view?.warning(message: "YouAreCurrentlyReadingABook")
    }
    
    func didEndRead(book: Book) {
        self.currentBook = book
        self.view?.enterPage()
    }
    
    func didSelect(book: Book) {
        self.delegate?.didSelect(book: book)
    }
    
    func didEnterPage(number: String) {
        guard let number = Int16(number) else {
            self.currentBook = nil
            return
        }
        
        if number > currentBook!.pagesCount {
            self.currentBook = nil
            self.view?.warning(message: "NumberGreaterPageCount")
            return
        }
        
        if number < currentBook!.currentPage {
            self.currentBook = nil
            self.view?.warning(message: "AlreadyReadPage")
            return
        }
        
        let readTimer = currentBook?.readTimer
        let sessionRead = SessionRead(readTimer!.startDate!, readTimer!.endDate!, readTimer!.totalReadTimer!, number)
        self.currentBook?.readTimer = ReadTimer(readMode: .noReading)
        self.currentBook?.currentPage = number
        self.currentBook?.sessionsRead.append(sessionRead)
        self.update(book: currentBook!)
        
    }
    
    func update(book: Book) {
        self.repository.update(book: book) { (result) in
            switch result {
            case .success:
                
                self.books.enumerated().forEach { (offset, element) in
                    if book.id == element.id {
                        self.books[offset] = book
                    }
                }
                
            case .failure(let error):
                self.view?.warning(message: error.localizedDescription)
            }
        }
    }
    
}
