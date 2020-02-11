//
//  BookCellViewModel.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/4/20.
//

import Foundation
import UIKit

protocol BookCellViewModelDelegate: class {
    func pauseRead(book: BookCellViewModel, at time: TimeInterval)
    func resumeRead(book: BookCellViewModel, at time: TimeInterval)
    func endRead(book: BookCellViewModel, at time: TimeInterval)
    func didSelect(book: BookCellViewModel)
}

protocol BookCellViewUpdateDelegate: class {
    func updateTimer(time: String)
}

class BookCellViewModel: TableViewCellModel {
    
    func identifier() -> String {
        return "BookTableViewCell"
    }
    
    weak var viewUpdateDelegate: BookCellViewUpdateDelegate?
    weak var delegate: BookCellViewModelDelegate?
    
    private(set) var name: String
    private(set) var author: String
    private(set) var pagesCount: String
    private(set) var currentPage: String
    private(set) var cover: UIImage?
    private(set) var descriptions: String
    private(set) var progress: Float
    private(set) var readMode: ReadMode
    
    private(set) var book: Book
    private(set) var currentTime: TimeInterval
    
    private var timer: Timer = Timer()
    
    init(_ book: Book, delegate: BookCellViewModelDelegate) {
        self.delegate = delegate
        self.book = book
        self.readMode = book.readTimer.readMode
        self.name = book.name
        self.author = book.author
        self.pagesCount = book.pagesCount.description
        self.currentPage = book.currentPage.description
        self.progress = Float(book.currentPage)
        self.descriptions = book.descriptions
        if let cover =  book.cover { self.cover = UIImage(data: cover) }
        self.currentTime = 0
        
        switch book.readTimer.readMode {
        case .reading:
            NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
            self.currentTime = Date().timeIntervalSince(book.readTimer.lastReadDate!)
            self.startTimer()
        case .pauseReading:
            self.currentTime = book.readTimer.totalReadTimer!
        case .noReading:
            self.currentTime = 0
        }
        
    }
    
    @objc func applicationDidBecomeActive() {
        if self.book.readTimer.readMode == .reading {
            self.currentTime = Date().timeIntervalSince(book.readTimer.lastReadDate!)
            self.startTimer()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    func startTimer() {
        
        self.timer.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { result in
            self.currentTime += 1
            self.viewUpdateDelegate?.updateTimer(time: self.currentTime.asString(style: .positional))
        })
        
    }
    
}

extension BookCellViewModel: BookTableViewCellDelegate {
    
    func didTapEndRead() {
        self.delegate?.endRead(book: self, at: self.currentTime)
    }
    
    func didTapPauseRead() {
        self.delegate?.pauseRead(book: self, at: self.currentTime)
    }
    
    func didTapResumeRead() {
        self.delegate?.resumeRead(book: self, at: self.currentTime)
    }
    
    func didSelectBook() {
        self.delegate?.didSelect(book: self)
    }
    
}

