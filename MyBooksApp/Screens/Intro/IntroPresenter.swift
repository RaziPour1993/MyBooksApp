//
//  IntroPresenter.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/4/20.
//

import Foundation

protocol IntroPresenter: Presenter {
    func set(view: IntroPresentingView)
}

protocol IntroPresentingView: PresentingView {
    
}

protocol IntroScreenDelegate: ScreenDelegate {
    func preparationDone()
}
