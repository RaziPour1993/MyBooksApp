//
//  BooksCoordinator.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/4/20.
//

import Foundation

protocol BooksCoordinatorDelegate: class {
    
}

final class BooksCoordinator: Coordinator {
    
    var screenFactory: ScreenFactory
    var coordinatorFactory: CoordinatorFactory
    var router: Router
    weak var delegate: BooksCoordinatorDelegate?
    
    init(_ delegate: BooksCoordinatorDelegate, _ coordinatorFactory: CoordinatorFactory, _ screenFactory: ScreenFactory, _ router: Router) {
        self.screenFactory = screenFactory
        self.coordinatorFactory = coordinatorFactory
        self.router = router
        self.delegate = delegate
    }
    
    func start() {
        self.displayBooksScreen()
    }
    
    deinit {
        print(self)
    }
    
}

extension BooksCoordinator: BooksScreenDelegate {
    
    func displayBooksScreen() {
        let vc = self.screenFactory.makeBooksScreen(delegate: self)
        self.router.setRoot(vc, with: true)
    }
    
}

