import UIKit

final class MainScreenFactoryIMP: ScreenFactory {
    
    init() {
        
    }
    
    func makeIntroScreen(delegate: IntroScreenDelegate) -> IntroViewController {
        let presenter = IntroPresenterIMP(delegate)
        let vc = IntroViewController(presenter)
        return vc
    }
    
    func makeBooksScreen(delegate: BooksScreenDelegate) -> BooksViewController {
        let presenter = BooksPresenterIMP(delegate)
        let vc = BooksViewController(presenter)
        return vc
    }
    
}
