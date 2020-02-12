//
//  BookDetailPresenterIMP.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/4/20.
//

import Foundation

class BookDetailPresenterIMP {
    
    weak var view: BookDetailPresentingView?
    weak var delegate: BookDetailScreenDelegate?
    var repository: BookDetailRepository
    var book: Book
    
    init(_ book: Book, _ repository: BookDetailRepository, _ delegate: BookDetailScreenDelegate) {
        self.book = book
        self.repository = repository
        self.delegate = delegate
    }
    
    deinit {
        print(self)
    }
    
}

extension BookDetailPresenterIMP: BookDetailPresenter {
    
    func present() {
        let viewModel = BookDetailViewModel(self.book, delegate: nil)
        self.view?.updated(bookDetail: viewModel)
    }
    
    func set(view: BookDetailPresentingView) {
        self.view = view
    }
    
    func didTapDeleteBook() {
        self.repository.deleteBook(self.book) { (result) in
            switch result {
            case .success:
                self.delegate?.bookDeleted()
            case .failure(let error):
                self.view?.warning(message: error.localizedDescription)
            }
        }
    }
    
}
