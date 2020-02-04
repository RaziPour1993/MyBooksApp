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
    
}

extension MainCoordinator: IntroCoordinatorDelegate {
    
    func startIntroCoordinator() {
        let coordinator = self.coordinatorFactory.makeIntroCoordinator(delegate: self)
        coordinator.start()
    }
    
}
