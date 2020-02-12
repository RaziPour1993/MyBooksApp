//
//  BookDetailTableViewCell.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/12/20.
//

import UIKit

class BookDetailTableViewCell: UITableViewCell, ReusableView, NibLoadableView {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var coverContainerView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var currentPageLabel: UILabel!
    @IBOutlet weak var pagesCountLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var timerLabel: UILabel!
    
    var model: BookDetailCellViewModel? {
        didSet {
            guard let model = self.model else {
                return
            }
            
            self.timerLabel.text = model.totalTime
            self.nameLabel.text = model.name
            self.authorLabel.text = model.author
            self.coverImageView.image = model.cover ?? #imageLiteral(resourceName: "background")
            self.pagesCountLabel.text = model.pagesCount
            self.currentPageLabel.text = model.currentPage
            self.progressView.progress = model.progress
            
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.coverContainerView.setBorder()
        self.coverContainerView.setBorder()
    }
    
    override func prepareForReuse() {
        self.model = nil
    }
    
}

extension BookDetailTableViewCell: ConfigurableTableViewCell {
    
    func configure(with model: TableViewCellModel, indexPath: IndexPath) {
        guard let model = model as? BookDetailCellViewModel else { fatalError(self.description) }
        self.model = model
    }
    
}
