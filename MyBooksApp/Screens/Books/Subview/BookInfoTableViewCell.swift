//
//  BookInfoTableViewCell.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/11/20.
//

import UIKit

protocol BookInfoTableViewCellDelegate: class {
    func didTapStartRead()
    func didSelectBook()
}


class BookInfoTableViewCell: UITableViewCell, ReusableView, NibLoadableView {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var coverContainerView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var currentPageLabel: UILabel!
    @IBOutlet weak var pagesCountLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    weak var delegate: BookInfoTableViewCellDelegate?
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        config()
    }
    
    var book: BookInfoCellViewModel? {
        didSet {
            guard let model = self.book else {
                self.nameLabel.text = "Name"
                self.authorLabel.text = "Author"
                self.coverImageView.image = nil
                self.delegate = nil
                self.timerLabel.text = "Timer"
                self.pagesCountLabel.text = "PagesCount"
                return
            }
            
            self.delegate = model
            self.timerLabel.text = model.totalTime
            self.nameLabel.text = model.name
            self.authorLabel.text = model.author
            self.coverImageView.image = model.cover
            self.pagesCountLabel.text = model.pagesCount
            self.currentPageLabel.text = model.currentPage
            self.progressView.progress = Float(Int(model.pagesCount) ?? 1)
            self.progressView.setProgress(model.progress, animated: true)
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.delegate?.didSelectBook()
        }
    }
    
    override func prepareForReuse() {
        self.delegate = nil
        self.book = nil
        self.indexPath = nil
    }
    
}

extension BookInfoTableViewCell {
    
    func config() {
        self.startButton.addTarget(self, action: #selector(self.startButtonAction), for: .touchDown)
    }
    
    @objc func startButtonAction() {
        self.delegate?.didTapStartRead()
    }
    
}

extension BookInfoTableViewCell: ConfigurableTableViewCell {
    
    func configure(with model: TableViewCellModel, indexPath: IndexPath) {
        guard let book = model as? BookInfoCellViewModel else {
            fatalError(self.description)
        }
        
        self.book = book
        
    }
    
}
