//
//  BooksPresenter.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/4/20.
//

import Foundation

protocol BooksPresenter: Presenter {
    func set(view: BooksPresentingView)
}

protocol BooksPresentingView: PresentingView {
    
}

protocol BooksScreenDelegate: ScreenDelegate {
    
}
