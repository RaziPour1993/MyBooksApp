import UIKit

final class MainScreenFactoryIMP: ScreenFactory {
    
    init() {
        
    }
    
    func makeIntroScreen(delegate: IntroScreenDelegate) -> IntroViewController {
        let presenter = IntroPresenterIMP(delegate)
        let vc = IntroViewController(presenter)
        return vc
    }
    
}
