import Foundation

protocol ScreenFactory {
    
    func makeIntroScreen(delegate: IntroScreenDelegate)-> IntroViewController
    
}
