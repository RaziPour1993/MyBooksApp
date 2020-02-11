import UIKit

final class MainScreenFactoryIMP: ScreenFactory {
    
    init() {
        
    }
    
    func makeAddBookScreen(delegate: AddBookScreenDelegate) -> AddBookViewController {
        let repository = AddBookRepositoryIMP()
        let presenter = AddBookPresenterIMP(repository, delegate)
        let vc = AddBookViewController(presenter)
        return vc
    }
    
    func makeIntroScreen(delegate: IntroScreenDelegate) -> IntroViewController {
        let presenter = IntroPresenterIMP(delegate)
        let vc = IntroViewController(presenter)
        return vc
    }
    
    func makeBooksScreen(delegate: BooksScreenDelegate) -> BooksViewController {
        let repository = BooksRepositoryIMP()
        let presenter = BooksPresenterIMP(repository, delegate)
        let vc = BooksViewController(presenter)
        return vc
    }
    
    func makeBooksScreen(delegate: BooksScreenDelegate, maneger: BooksScreenManeger) -> BooksViewController {
        let repository = BooksRepositoryIMP()
        let presenter = BooksPresenterIMP(repository, delegate)
        let vc = BooksViewController(presenter)
        return vc
    }
    
}
