import Foundation
import UIKit

protocol Coordinator: class {
    
    var screenFactory: ScreenFactory  { get }
    var coordinatorFactory: CoordinatorFactory { get }
    var router: Router { get }
    
    func start()
    
}
