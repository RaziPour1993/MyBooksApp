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
    
    var id: String
    var name: String
    var author: String
    var pagesCount: Int16
    var cover: Data?
    var descriptions: String
    var currentPage: Int16
    
    var readTimer: ReadTimer
    var sessionsRead: SessionsRead
    
    init(_ name: String, _ author: String, _ pagesCount: Int16, _ cover: Data? = nil, _ descriptions: String = "") {
        self.name = name
        self.author = author
        self.pagesCount = pagesCount
        self.cover = cover
        self.descriptions = descriptions
        
        self.id = UUID().uuidString
        self.readTimer = ReadTimer()
        self.sessionsRead = []
        self.currentPage = 0
    }
    
    init?(_ entity: BookEntity) {
        
        guard let id = entity.id, let name = entity.name, let author = entity.author, let readTimerEntity = entity.readTimerRelationship else {
            return nil
        }
        
        self.id = id
        self.name = name
        self.author = author
        self.pagesCount = entity.pagesCount
        self.descriptions = entity.descriptions!
        self.currentPage = entity.currentPage
        
        if let image = entity.cover  {
            self.cover = image
        }
        
        self.readTimer = ReadTimer(entity: readTimerEntity)
        
        self.sessionsRead = []
        
        self.sessionsRead = entity.sessionsReadRelationship!.compactMap({ (item) -> SessionRead? in
            guard let entity = item as? SessionReadEntity else {
                return nil
            }
            return SessionRead(entity)
        })
        
    }
    
    var totalReadTime: Double {
        var total: Double = 0.0
        self.sessionsRead.forEach { (item) in total += item.totalReadTimer }
        return total
    }
}
