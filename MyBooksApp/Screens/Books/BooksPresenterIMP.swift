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
    var booksViewModel: BooksViewModel!
    var repository: BooksRepository
    var books: Books
    
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
    
    func bookAdded(book: Book) {
        self.books.append(book)
        self.booksViewModel = BooksViewModel(books, delegate: self)
        self.view?.updated(books: self.booksViewModel)
    }
    
    func present() {
        self.getBooks()
    }
    
    func set(view: BooksPresentingView) {
        self.view = view
    }
    
    func didTapAddBook() {
        self.delegate?.addBook()
    }
    
}

extension BooksPresenterIMP {
    
    func getBooks() {
        self.repository.books { (result) in
            switch result {
            case .success(let items):
                self.books = items
                self.booksViewModel = BooksViewModel(items, delegate: self)
                self.view?.updated(books: self.booksViewModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension BooksPresenterIMP: BooksViewModelDelegate {
    
}
