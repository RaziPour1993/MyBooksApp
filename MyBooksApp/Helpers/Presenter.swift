import Foundation
import UIKit

protocol PresentingView: class {
    func willLoadingData()
    func didLoadingData()
    func warning(message: String)
}

protocol Presenter: class {
    func present()
}

protocol ScreenDelegate: class {
    
}

extension PresentingView where Self: UIViewController {
    
    func willLoadingData() {
        
    }
    
    func didLoadingData() {
        
    }
    
    func warning(message: String) {
        self.showToast(message.localized)
    }
    
}
