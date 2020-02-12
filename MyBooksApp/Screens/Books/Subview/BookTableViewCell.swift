//
//  BookTableViewCell.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/4/20.
//

import UIKit

protocol BookTableViewCellDelegate: class {
    func didTapEndRead()
    func didTapPauseRead()
    func didTapResumeRead()
    func didSelectBook()
}

class BookTableViewCell: UITableViewCell, ReusableView, NibLoadableView {
    
    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var coverContainerView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var currentPageLabel: UILabel!
    @IBOutlet weak var pagesCountLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var endButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var resumeButton: UIButton!
    
    weak var delegate: BookTableViewCellDelegate?
    
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        config()
    }
    
    var book: BookCellViewModel? {
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
            
            model.viewUpdateDelegate = self
            self.delegate = model
            self.timerLabel.text = model.currentTime.stringFromTimeInterval()
            self.nameLabel.text = model.name
            self.authorLabel.text = model.author
            self.coverImageView.image = model.cover
            self.pagesCountLabel.text = model.pagesCount
            self.currentPageLabel.text = model.currentPage
            self.progressView.progress = model.progress
            self.updateView(mode: model.readMode)
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.delegate?.didSelectBook()
        }
    }
    
    override func prepareForReuse() {
        self.book?.viewUpdateDelegate = nil
        self.delegate = nil
        self.book = nil
        self.indexPath = nil
    }
    
}

extension BookTableViewCell {
    
    func config() {
        self.endButton.addTarget(self, action: #selector(self.endButtonAction), for: .touchDown)
        self.pauseButton.addTarget(self, action: #selector(self.pauseButtonAction), for: .touchDown)
        self.resumeButton.addTarget(self, action: #selector(self.resumeButtonAction), for: .touchDown)
        self.endButton.setBorder(borderWidth: 0)
        self.pauseButton.setBorder(borderWidth: 0)
        self.resumeButton.setBorder(borderWidth: 0)
        self.contentContainerView.setBorder(color: #colorLiteral(red: 0.9568628669, green: 0.2627450228, blue: 0.2117646933, alpha: 1), borderWidth: 1, cornerRadius: 10)
    }
    
    @objc func endButtonAction() {
        self.delegate?.didTapEndRead()
    }
    
    @objc func pauseButtonAction() {
        self.delegate?.didTapPauseRead()
    }
    
    @objc func resumeButtonAction() {
        self.delegate?.didTapResumeRead()
    }
    
}

extension BookTableViewCell: ConfigurableTableViewCell {
    
    func configure(with model: TableViewCellModel, indexPath: IndexPath) {
        guard let book = model as? BookCellViewModel else { fatalError(self.description) }
        self.book = book
    }
    
}

extension BookTableViewCell: BookCellViewUpdateDelegate {
    
    func updateTimer(time: String) {
        self.timerLabel.text = time
    }
    
    func updateView(mode: ReadMode) {
        switch mode {
        case .reading:
            self.endButton.isHidden = false
            self.pauseButton.isHidden = false
            self.resumeButton.isHidden = true
        case .pauseReading:
            self.endButton.isHidden = false
            self.pauseButton.isHidden = true
            self.resumeButton.isHidden = false
        case .noReading:
            print("")
        }
    }
    
}
