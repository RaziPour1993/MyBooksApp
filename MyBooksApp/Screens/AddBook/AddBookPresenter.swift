//
//  AddBookPresenter.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/4/20.
//

import Foundation

protocol AddBookPresenter: Presenter {
    func set(view: AddBookPresentingView)
    func didTapAdd()
    func didTapDeleteCover()
    func didSelectedCover(image: Data)
}

protocol AddBookPresentingView: PresentingView {
    func returnInfo()-> AddBook
    func invalidName(message: String)
    func invalidAuthor(message: String)
    func invalidPagesCount(message: String)
    func coverDeleted()
    func coverAdded(image: Data)
}

protocol AddBookScreenDelegate: ScreenDelegate {
    func bookAdded(book: Book)
}
