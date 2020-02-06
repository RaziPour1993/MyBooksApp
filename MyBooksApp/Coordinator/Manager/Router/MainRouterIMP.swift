import Foundation
import UIKit

final class MainRouterIMP: NSObject, Router {
    
    private var rootController: UINavigationController?
    private var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func toPresent() -> UIViewController? {
        return rootController
    }
    
    func present(_ module: Presentable?) {
        present(module, animated: true)
    }
    
    func present(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        self.window?.rootViewController?.present(controller, animated: animated, completion: nil)
    }
    
    func present(_ module: Presentable?, animated: Bool, with navbar: Bool) {
        if navbar {
            guard let controller = module?.toPresent() else { return }
            let navigationController = UINavigationController(rootViewController: controller)
            self.window?.rootViewController?.present(navigationController, animated: animated, completion: nil)
        } else {
            self.present(module, animated: animated)
        }
    }
    
    func push(_ module: Presentable?) {
        self.push(module, animated: true)
    }
    
    func push(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        guard let rootController = self.window?.rootViewController as? UINavigationController else { return }
        rootController.pushViewController(controller, animated: animated)
    }
    
    func dismissModule() {
        self.dismissModule(animated: true)
    }
    
    func dismissModule(animated: Bool) {
        
    }
    
    func popToRootModule(animated: Bool) {
        
    }
    
    func setRoot(_ module: Presentable?) {
        guard let controller = module?.toPresent() else { return }
        self.window?.rootViewController = controller
        self.window?.makeKeyAndVisible()
    }
    
    func setRoot(_ module: Presentable?, with navbar: Bool) {
        if navbar {
            guard let controller = module?.toPresent() else { return }
            let navigationController = UINavigationController()
            navigationController.setViewControllers([controller], animated: false)
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
        } else {
            self.setRoot(module)
        }
    }
    
    func popModule() {
        guard let rootController = self.window?.rootViewController as? UINavigationController else { return }
        rootController.popViewController(animated: true)
    }
    
}
