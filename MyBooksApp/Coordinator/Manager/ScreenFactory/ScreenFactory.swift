import Foundation

protocol ScreenFactory {
    
    func makeIntroScreen(delegate: IntroScreenDelegate)-> IntroViewController
    func makeBooksScreen(delegate: BooksScreenDelegate)-> BooksViewController
    func makeBooksScreen(delegate: BooksScreenDelegate, maneger: BooksScreenManeger)-> BooksViewController
    func makeAddBookScreen(delegate: AddBookScreenDelegate)-> AddBookViewController
    
}
