//
//  BookCellViewModel.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/4/20.
//

import Foundation
import UIKit

protocol BookDetailCellViewModelDelegate: class {
    
}

class BookDetailCellViewModel: TableViewCellModel {
    
    
    func identifier() -> String {
        return "BookDetailTableViewCell"
    }
    
    private(set) var name: String
    private(set) var author: String
    private(set) var pagesCount: String
    private(set) var currentPage: String
    private(set) var cover: UIImage?
    private(set) var descriptions: String
    private(set) var progress: Float
    private(set) var totalTime: String
    
    weak var delegate: BookDetailCellViewModelDelegate?
    
    init(_ item: Book, delegate: BookDetailCellViewModelDelegate?) {
        self.delegate = delegate
        self.name = item.name
        self.author = item.author
        self.pagesCount = item.pagesCount.description
        self.currentPage = item.currentPage.description
        self.progress = Float((Float(item.currentPage) / Float(item.pagesCount)))
        self.descriptions = item.descriptions
        if let cover =  item.cover { self.cover = UIImage(data: cover) }
        self.totalTime = item.totalReadTime.stringFromTimeInterval()
    }
    
}
