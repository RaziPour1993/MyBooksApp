//
//  IntroCoordinator.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/4/20.
//

import Foundation

protocol IntroCoordinatorDelegate: class {
    func didFinish(coordinator: IntroCoordinator)
}

final class IntroCoordinator: Coordinator {
    
    var screenFactory: ScreenFactory
    var coordinatorFactory: CoordinatorFactory
    var router: Router
    weak var delegate: IntroCoordinatorDelegate?
    
    init(_ delegate: IntroCoordinatorDelegate, _ coordinatorFactory: CoordinatorFactory, _ screenFactory: ScreenFactory, _ router: Router) {
        self.screenFactory = screenFactory
        self.coordinatorFactory = coordinatorFactory
        self.router = router
        self.delegate = delegate
    }
    
    func start() {
        self.displayIntroScreen()
    }
    
    deinit {
        print(self)
    }
    
}

extension IntroCoordinator: IntroScreenDelegate {
    
    func preparationDone() {
        self.delegate?.didFinish(coordinator: self)
    }
    
    func displayIntroScreen() {
        let vc = self.screenFactory.makeIntroScreen(delegate: self)
        self.router.setRoot(vc)
    }
    
}

