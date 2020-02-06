//
//  Book.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/4/20.
//

import Foundation
import UIKit

typealias Books = [Book]

struct Book {
    
    var name: String
    var author: String
    var pagesCount: Int16
    var cover: Data?
    var descriptions: String
    var readTimer: ReadTimer!
    var sessionsRead: SessionsRead
    
    init(_ name: String, _ author: String, _ pagesCount: Int16, _ cover: Data? = nil, _ descriptions: String = "") {
        self.name = name
        self.author = author
        self.pagesCount = pagesCount
        self.cover = cover
        self.descriptions = descriptions
        self.readTimer = ReadTimer()
        self.sessionsRead = []
    }
    
    init?(_ entity: BookEntity) {
        
        guard let name = entity.name, let author = entity.author else {
            return nil
        }
        
        self.name = name
        self.author = author
        self.pagesCount = entity.pagesCount
        self.descriptions = entity.descriptions ?? ""
        
        if let image = entity.cover  {
            self.cover = image
        }
        
        self.readTimer = ReadTimer()
        self.sessionsRead = []
    }
}
