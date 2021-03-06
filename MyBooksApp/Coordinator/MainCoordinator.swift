//
//  MainCoordinator.swift
//  Digipay
//
//  Created by Mohammad Razipour on 12/24/19.
//  Copyright © 2019 Mohammad Razipour. All rights reserved.
//

import Foundation

final class MainCoordinator: Coordinator {
    
    var screenFactory: ScreenFactory
    var coordinatorFactory: CoordinatorFactory
    var router: Router
    
    init(_ coordinatorFactory: CoordinatorFactory, _ screenFactory: ScreenFactory, _ router: Router) {
        self.screenFactory = screenFactory
        self.coordinatorFactory = coordinatorFactory
        self.router = router
    }
    
    func start() {
        startIntroCoordinator()
    }
    
    deinit {
        print(self)
    }
    
}

extension MainCoordinator: IntroCoordinatorDelegate {
    
    func didFinish(coordinator: IntroCoordinator) {
        self.coordinatorFactory.removeChildCoordinator(coordinator)
        self.startBooksCoordinator()
    }
    
    func startIntroCoordinator() {
        let coordinator = self.coordinatorFactory.makeIntroCoordinator(delegate: self)
        coordinator.start()
    }
    
}


extension MainCoordinator: BooksCoordinatorDelegate {
    
    func startBooksCoordinator() {
        let coordinator = self.coordinatorFactory.makeBooksCoordinator(delegate: self)
        coordinator.start()
    }
    
}
