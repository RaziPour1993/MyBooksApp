//
//  BooksViewController.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/4/20.
//

import UIKit

class BooksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: BooksPresenter!
    var tableViewDataSource: TableViewDataSource!
    
    init(_ presenter: BooksPresenter) {
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
        self.tableViewConfig()
        self.presenter.present()
    }
    
}

extension BooksViewController {
    
    func tableViewConfig() {
        self.tableViewDataSource = TableViewDataSource()
        self.tableView.dataSource = self.tableViewDataSource
        self.tableView.delegate = self.tableViewDataSource
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.allowsSelection = true
        self.tableView.tableFooterView = UIView()
        self.tableView.sectionHeaderHeight = 0.0
        self.tableView.sectionFooterHeight = 0.0
        self.tableView.register(BookTableViewCell.self)
    }
    
}

extension BooksViewController: BooksPresentingView {
    
    func updated(books viewModel: TableViewModel) {
        self.tableViewDataSource.viewModel = viewModel
        self.tableView.reloadData()
    }
    
}
