//
//  IntroPresenterIMP.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/4/20.
//

import Foundation

class IntroPresenterIMP {
    
    weak var view: IntroPresentingView?
    weak var delegate: IntroScreenDelegate?
    
    init(_ delegate: IntroScreenDelegate) {
        self.delegate = delegate
    }
    
    deinit {
        print(self)
    }
    
}

extension IntroPresenterIMP: IntroPresenter {
    
    func present() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
            self.delegate?.preparationDone()
        }
    }
    
    func set(view: IntroPresentingView) {
        self.view = view
    }
    
}
