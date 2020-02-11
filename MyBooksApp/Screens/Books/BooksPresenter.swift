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
    func didEnterPage(number: String)
}

protocol BooksPresentingView: PresentingView {
    func updated(books viewModel: TableViewModel)
    func enterPage()
}

protocol BooksScreenDelegate: ScreenDelegate {
    func addBook()
    func didSelect(book: Book)
}

protocol BooksScreenManeger: class {
    func bookAdded(book: Book)
}
