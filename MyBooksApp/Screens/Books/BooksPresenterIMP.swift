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
    
    init(_ delegate: BooksScreenDelegate) {
        self.delegate = delegate
    }
    
    deinit {
        print(self)
    }
    
}

extension BooksPresenterIMP: BooksPresenter {
    
    func present() {
        
    }
    
    func set(view: BooksPresentingView) {
        self.view = view
    }
    
}
