//
//  BooksViewController.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/4/20.
//

import UIKit

class BooksViewController: UIViewController {
    
    var presenter: BooksPresenter!
    
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
        self.presenter.present()
    }
    
}

extension BooksViewController: BooksPresentingView {
    
    
}
