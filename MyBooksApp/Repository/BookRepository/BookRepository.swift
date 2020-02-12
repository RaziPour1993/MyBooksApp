//
//  BookRepository.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/4/20.
//

import Foundation

protocol BookRepository: BookCreateRepository, BookReadRepository, BookUpdateRepository, BookDeleteRepository {
    
}

protocol BookCreateRepository {
    func create(book: Book, completion: @escaping(Result<Bool, RepositoryError>)-> Void)
}

protocol BookReadRepository {
    func readAll(completion: @escaping(Result<Books, RepositoryError>)-> Void)
}

protocol BookUpdateRepository {
    func update(book: Book, completion: @escaping(Result<Bool, RepositoryError>)-> Void)
}

protocol BookDeleteRepository {
    func delete(book: Book, completion: @escaping(Result<Bool, RepositoryError>)-> Void)
}
