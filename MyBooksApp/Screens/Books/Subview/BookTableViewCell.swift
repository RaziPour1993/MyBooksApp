//
//  BookTableViewCell.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/4/20.
//

import UIKit

class BookTableViewCell: UITableViewCell, ReusableView, NibLoadableView {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var coverContainerView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var currentPageLabel: UILabel!
    @IBOutlet weak var pagesCountLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var endButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var resumeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    var book: BookCellViewModel? {
        didSet {
            guard let model = self.book else {
                self.nameLabel.text = nil
                self.authorLabel.text = nil
                self.coverImageView.image = nil
                return
            }
            
            self.nameLabel.text = model.name
            self.authorLabel.text = model.author
            self.coverImageView.image = model.cover
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func prepareForReuse() {
        self.book = nil
    }
    
}

extension BookTableViewCell: ConfigurableTableViewCell {
    
    func configure(with model: TableViewCellModel, indexPath: IndexPath) {
        guard let book = model as? BookCellViewModel else {
            fatalError(self.description)
        }
        
        self.book = book
        
    }
    
}
