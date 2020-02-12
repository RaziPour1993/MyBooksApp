//
//  BookDetailViewController.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/11/20.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: BookDetailPresenter!
    var tableViewDataSource: TableViewDataSource!
    
    init(_ presenter: BookDetailPresenter) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
        self.presenter.set(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        viewConfig()
        tableViewConfig()
        self.presenter.present()
    }
    
}

extension BookDetailViewController {
    
    func config() {
        let deleteBookButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteBookButtonAction))
        self.navigationItem.rightBarButtonItem = deleteBookButton
    }
    
    func viewConfig() {
        self.navigationItem.title = "BookDetail".localized
    }
    
    func tableViewConfig() {
        self.tableViewDataSource = TableViewDataSource()
        self.tableView.dataSource = self.tableViewDataSource
        self.tableView.delegate = self.tableViewDataSource
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.allowsSelection = false
        self.tableView.tableFooterView = UIView()
        self.tableView.sectionHeaderHeight = 0.0
        self.tableView.sectionFooterHeight = 0.0
        self.tableView.register(SessionReadTableViewCell.self)
        self.tableView.register(BookDetailTableViewCell.self)
    }
    
    @objc func deleteBookButtonAction() {
        self.presenter.didTapDeleteBook()
    }
    
}

extension BookDetailViewController: BookDetailPresentingView {
    
    func updated(bookDetail viewModel: TableViewModel) {
        self.tableViewDataSource.viewModel = viewModel
        self.tableView.reloadData()
    }
    
}
