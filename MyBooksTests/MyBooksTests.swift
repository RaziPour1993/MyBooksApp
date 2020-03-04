//
//  MyBooksTests.swift
//  MyBooksTests
//
//  Created by Mohammad Razipour on 3/4/20.
//

import XCTest

class MyBooksTests: XCTestCase {
    
    var booksPresenter: BooksPresenterIMP!
    
    override func setUp() {
        self.booksPresenter = BooksPresenterIMP(BooksLocalRepositoryIMP(), nil)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        self.booksPresenter.present()
        waitForExpectations(timeout: 5, handler: nil)
        
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        
        XCTAssertEqual(self.booksPresenter.books.count, 2)
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
