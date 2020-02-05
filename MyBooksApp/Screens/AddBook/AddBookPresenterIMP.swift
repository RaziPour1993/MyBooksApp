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
    
}
