//
//  BookDetailPresenter.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/4/20.
//

import Foundation

protocol BookDetailPresenter: Presenter {
    func set(view: BookDetailPresentingView)
    func didTapDeleteBook()
}

protocol BookDetailPresentingView: PresentingView {
    func updated(bookDetail viewModel: TableViewModel)
}

protocol BookDetailScreenDelegate: ScreenDelegate {
    func bookDeleted()
}
