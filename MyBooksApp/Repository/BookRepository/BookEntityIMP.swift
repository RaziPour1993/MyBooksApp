//
//  BookRepositoryIMP.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/4/20.
//

import Foundation
import CoreData

class BookEntityIMP: BookRepository {
    
    var dataBaseManeger: CoreDataManager
    let entityName: String
    
    init() {
        self.dataBaseManeger = CoreDataManager(modelName: "MyBooks")
        self.entityName  = "BookEntity"
    }
    
    func create(book: Book, completion: @escaping (Result<Bool, RepositoryError>) -> Void) {
        
        let entity = BookEntity(context: self.dataBaseManeger.managedObjectContext)
        entity.id = book.id
        entity.name = book.name
        entity.author = book.author
        entity.cover = book.cover
        entity.pagesCount = book.pagesCount
        entity.descriptions = book.descriptions
        entity.currentPage = book.currentPage
        
        entity.sessionsReadRelationship = []
        
        let readTimerEntity = ReadTimerEntity(context: self.dataBaseManeger.managedObjectContext)
        readTimerEntity.startDate = book.readTimer.startDate
        readTimerEntity.endDate = book.readTimer.endDate
        readTimerEntity.lastReadDate = book.readTimer.lastReadDate
        readTimerEntity.readMode = book.readTimer.readMode.rawValue
        readTimerEntity.totalReadTimer = book.readTimer.totalReadTimer ?? 0.0
        entity.readTimerRelationship = readTimerEntity
        
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
        
        let fetch = NSFetchRequest<BookEntity>(entityName: "BookEntity")
        fetch.predicate = NSPredicate(format: "id == %@", book.id)
        
        do {
            let books = try self.dataBaseManeger.managedObjectContext.fetch(fetch)
            
            guard let bookEntity = books.first else {
                completion(.success(false))
                return
            }
            
            bookEntity.currentPage = book.currentPage
            
            let readTimerEntity = ReadTimerEntity(context: self.dataBaseManeger.managedObjectContext)
            readTimerEntity.startDate = book.readTimer.startDate
            readTimerEntity.endDate = book.readTimer.endDate
            readTimerEntity.lastReadDate = book.readTimer.lastReadDate
            readTimerEntity.readMode = book.readTimer.readMode.rawValue
            readTimerEntity.totalReadTimer = book.readTimer.totalReadTimer ?? 0.0
            bookEntity.readTimerRelationship = readTimerEntity
            
            bookEntity.sessionsReadRelationship = []
            
            book.sessionsRead.forEach { (sessionsRead) in
                let sessionReadEntity = SessionReadEntity(context: self.dataBaseManeger.managedObjectContext)
                sessionReadEntity.startDate = sessionsRead.startDate
                sessionReadEntity.endDate = sessionsRead.endDate
                sessionReadEntity.pageNumber = sessionsRead.pageNumber
                sessionReadEntity.totalReadTimer = sessionsRead.totalReadTimer
                bookEntity.addToSessionsReadRelationship(sessionReadEntity)
            }
            
            do {
                try dataBaseManeger.managedObjectContext.save()
                completion(.success(true))
            } catch {
                print("Could not save. \(error))")
                completion(.failure(error))
            }
            
        } catch {
            print("Could not fetch. \(error)")
            completion(.failure(error))
        }
        
    }
    
    func delete(book: Book, completion: @escaping (Result<Bool, RepositoryError>) -> Void) {
        let fetch = NSFetchRequest<BookEntity>(entityName: "BookEntity")
        fetch.predicate = NSPredicate(format: "id == %@", book.id)
        
        do {
            
            let books = try self.dataBaseManeger.managedObjectContext.fetch(fetch)        
            self.dataBaseManeger.managedObjectContext.delete(books.first!)
            
            do {
                try dataBaseManeger.managedObjectContext.save()
                completion(.success(true))
            } catch {
                print("Could not save. \(error))")
                completion(.failure(error))
            }
            
        } catch {
            print("Could not fetch. \(error)")
            completion(.failure(error))
        }
    }
    
}
