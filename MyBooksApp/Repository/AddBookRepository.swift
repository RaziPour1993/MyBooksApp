//
//  AddBookRepository.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/5/20.
//

import Foundation

protocol AddBookRepository {
    func addBook(_ item: Book, completion: @escaping(Result<Bool, RepositoryError>)-> Void)
}

class AddBookRepositoryIMP: AddBookRepository {
    
    var localBookRepository: BookRepository
    
    init() {
        self.localBookRepository = BookRepositoryIMP()
    }
    
    func addBook(_ item: Book, completion: @escaping (Result<Bool, RepositoryError>) -> Void) {
        self.localBookRepository.create(book: item) { (result) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
