import Foundation

protocol ScreenFactory {
    
    func makeIntroScreen(delegate: IntroScreenDelegate)-> IntroViewController
    func makeBooksScreen(delegate: BooksScreenDelegate)-> BooksViewController
    func makeAddBookScreen(delegate: AddBookScreenDelegate)-> AddBookViewController
    
}
