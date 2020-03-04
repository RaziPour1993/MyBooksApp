//
//  BookDetailRepository.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/11/20.
//

import Foundation

protocol BookDetailRepository {
    func deleteBook(_ item: Book, completion: @escaping(Result<Bool, RepositoryError>)-> Void)
}

class BookDetailRepositoryIMP: BookDetailRepository {
    
    var localBookRepository: BookRepository
    
    init() {
        self.localBookRepository = BookEntityIMP()
    }
    
    func deleteBook(_ item: Book, completion: @escaping (Result<Bool, RepositoryError>) -> Void) {
        self.localBookRepository.delete(book: item) { (result) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
