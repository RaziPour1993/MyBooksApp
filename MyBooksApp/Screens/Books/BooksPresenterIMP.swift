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
    var repository: BooksRepository!
    
    init(_ repository: BooksRepository, _ delegate: BooksScreenDelegate) {
        self.booksViewModel = BooksViewModel(delegate: self)
        self.delegate = delegate
        self.repository = repository
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
    
}

extension BooksPresenterIMP {
    
    func getBooks() {
        
        self.repository.books { (result) in
            switch result {
            case .success(let items):
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
