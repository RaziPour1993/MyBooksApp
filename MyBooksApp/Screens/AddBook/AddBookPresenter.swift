//
//  AddBookPresenter.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/4/20.
//

import Foundation

protocol AddBookPresenter: Presenter {
    func set(view: AddBookPresentingView)
}

protocol AddBookPresentingView: PresentingView {
    
}

protocol AddBookScreenDelegate: ScreenDelegate {
    
}
