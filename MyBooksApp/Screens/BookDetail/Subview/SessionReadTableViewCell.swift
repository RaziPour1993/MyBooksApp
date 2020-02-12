//
//  SessionReadTableViewCell.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/12/20.
//

import UIKit

class SessionReadTableViewCell: UITableViewCell, ReusableView, NibLoadableView {
    
    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var pageNumberLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var model: SessionReadCellViewModel? {
        didSet {
            guard let model = self.model else {
                return
            }
            
            self.startDateLabel.text = model.startDate
            self.endDateLabel.text = model.endDate
            self.pageNumberLabel.text = model.pageNumber
            self.timeLabel.text = model.totalReadTimer
            
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentContainerView.setBorder()
    }
    
    override func prepareForReuse() {
        self.model = nil
    }
    
}

extension SessionReadTableViewCell: ConfigurableTableViewCell {
    
    func configure(with model: TableViewCellModel, indexPath: IndexPath) {
        guard let model = model as? SessionReadCellViewModel else { fatalError(self.description) }
        self.model = model
    }
    
}
