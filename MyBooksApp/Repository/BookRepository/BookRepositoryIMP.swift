//
//  BookRepositoryIMP.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/4/20.
//

import Foundation
import CoreData

class BookRepositoryIMP: BookRepository {
    
    var dataBaseManeger: CoreDataManager
    let entityName: String
    
    init() {
        self.dataBaseManeger = CoreDataManager(modelName: "MyBooks")
        self.entityName  = "BookEntity"
    }
    
    func create(book: Book, completion: @escaping (Result<Bool, RepositoryError>) -> Void) {
        
        let entity = BookEntity(context: self.dataBaseManeger.managedObjectContext)
        entity.name = book.name
        entity.author = book.author
        entity.cover = book.cover?.pngData()
        entity.pagesCount = book.pagesCount
        entity.descriptions = book.descriptions
        
        do {
            try dataBaseManeger.managedObjectContext.save()
            completion(.success(true))
        } catch {
            print("Could not save. \(error))")
            completion(.failure(error))
        }
    }
    
    func readAll(completion: @escaping (Result<Books, RepositoryError>) -> Void) {
        
        let fetchRequest = NSFetchRequest<BookEntity>(entityName: entityName)
        
        do {
            let fetched = try dataBaseManeger.managedObjectContext.fetch(fetchRequest)
            let items = fetched.compactMap({ (item) -> Book? in return Book(item) })
            completion(.success(items))
        } catch {
            print("Could not fetch. \(error)")
            completion(.success([]))
        }
    }
    
    func update(book: Book, completion: @escaping (Result<Bool, RepositoryError>) -> Void) {
        
    }
    
    func delete(book: Book, completion: @escaping (Result<Bool, RepositoryError>) -> Void) {
        
    }
    
    
}
