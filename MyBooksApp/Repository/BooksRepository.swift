//
//  BookRepository.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/4/20.
//

import Foundation

protocol BooksRepository {
    func books(completion: @escaping(Result<Books, RepositoryError>)-> Void)
    func update(book: Book, completion: @escaping(Result<Bool, RepositoryError>)-> Void)
}

class BooksRepositoryIMP: BooksRepository {
    
    var localBookRepository: BookRepository
    
    init() {
        self.localBookRepository = BookRepositoryIMP()
    }
    
    func books(completion: @escaping (Result<Books, RepositoryError>) -> Void) {
        self.localBookRepository.readAll { (result) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func update(book: Book, completion: @escaping (Result<Bool, RepositoryError>) -> Void) {
        self.localBookRepository.update(book: book) { (result) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
