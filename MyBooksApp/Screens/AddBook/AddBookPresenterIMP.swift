//
//  AddBookPresenterIMP.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/4/20.
//

import Foundation

class AddBookPresenterIMP {
    
    weak var view: AddBookPresentingView?
    weak var delegate: AddBookScreenDelegate?
    var repository: AddBookRepository
    
    var cover: Data?
    
    init(_ repository: AddBookRepository, _ delegate: AddBookScreenDelegate) {
        self.delegate = delegate
        self.repository = repository
    }
    
    deinit {
        print(self)
    }
    
}

extension AddBookPresenterIMP: AddBookPresenter {
    
    func present() {
        
    }
    
    func set(view: AddBookPresentingView) {
        self.view = view
    }
    
    func didTapAdd() {
        guard let info = self.view?.returnInfo() else {
            return
        }
        
        if info.name.isEmpty {
            self.view?.invalidName(message: "PleaseEnterName")
            return
        }
        
        if info.author.isEmpty {
            self.view?.invalidAuthor(message: "PleaseEnterAuthor")
            return
        }
        
        if info.pagesCount.isEmpty {
            self.view?.invalidPagesCount(message: "PleaseEnterPagesCount")
            return
        }
        
        guard let pagesCount = Int16(info.pagesCount) else {
            self.view?.invalidPagesCount(message: "InvalidPagesCount")
            return
        }
        
        if pagesCount <= 0 {
            self.view?.invalidPagesCount(message: "InvalidPagesCount")
            return
        }
        
        let book = Book(info.name, info.author, pagesCount, self.cover, info.descriptions)
        self.addBook(book)
    }
    
    func didTapDeleteCover() {
        self.cover = nil
        self.view?.coverDeleted()
    }
    
    func didSelectedCover(image: Data) {
        self.cover = image
        self.view?.coverAdded(image: image)
    }
    
}

extension AddBookPresenterIMP {
    
    func addBook(_ book: Book) {
        self.repository.addBook(book) { (result) in
            switch result {
            case .success:
                self.delegate?.bookAdded(book: book)
            case .failure(let error):
                self.view?.warning(message: error.localizedDescription)
            }
        }
    }
    
}
