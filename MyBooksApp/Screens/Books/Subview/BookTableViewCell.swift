//
//  BookTableViewCell.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/4/20.
//

import UIKit

class BookTableViewCell: UITableViewCell, ReusableView, NibLoadableView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    var book: BookCellViewModel? {
        didSet {
            guard let model = self.book else {
                return
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
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
