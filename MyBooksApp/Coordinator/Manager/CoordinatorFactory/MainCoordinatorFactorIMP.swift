import Foundation

final class MainCoordinatorFactorIMP: CoordinatorFactory {
    
    var childCoordinators: [Coordinator]
    var screenFactory: ScreenFactory
    var router: Router
    
    init(screenFactory: ScreenFactory, router: Router) {
        self.childCoordinators = []
        self.screenFactory = screenFactory
        self.router = router
    }
    
    func makeMainCoordinator() -> MainCoordinator {
        let coordinator = MainCoordinator(self, self.screenFactory, router)
        self.addChildCoordinator(coordinator)
        return coordinator
    }
    
    func makeIntroCoordinator(delegate: IntroCoordinatorDelegate) -> IntroCoordinator {
        let coordinator = IntroCoordinator(delegate, self, self.screenFactory, self.router)
        self.addChildCoordinator(coordinator)
        return coordinator
    }
    
}
