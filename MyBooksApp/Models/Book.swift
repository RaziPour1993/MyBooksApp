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
    var cover: UIImage?
    var descriptions: String
    
    init() {
        self.name = "Name"
        self.author = "author"
        self.pagesCount = 10
        self.cover = UIImage()
        self.descriptions = "descriptions"
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
            self.cover = UIImage(data: image)
        }
        
    }
}
