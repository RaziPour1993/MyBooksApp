//
//  BooksPresenter.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/4/20.
//

import Foundation

protocol BooksPresenter: Presenter, BooksScreenManeger {
    func set(view: BooksPresentingView)
    func didTapAddBook()
}

protocol BooksPresentingView: PresentingView {
    func updated(books viewModel: TableViewModel)
}

protocol BooksScreenDelegate: ScreenDelegate {
    func addBook()
}

protocol BooksScreenManeger: class {
    func bookAdded(book: Book)
}
