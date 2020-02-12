import Foundation

protocol Router: Presentable {
    
    func present(_ module: Presentable?)
    func present(_ module: Presentable?, animated: Bool)
    func present(_ module: Presentable?, animated: Bool, with navbar: Bool)
    
    func push(_ module: Presentable?)
    func push(_ module: Presentable?, animated: Bool)
    
    func dismissModule()
    func dismissModule(animated: Bool)
    
    func popToRootModule(animated: Bool)
    
    func setRoot(_ module: Presentable?)
    func setRoot(_ module: Presentable?, with navbar: Bool)
    
    func popModule()
    
}
