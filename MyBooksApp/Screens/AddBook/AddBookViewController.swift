//
//  AddBookViewController.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/5/20.
//

import UIKit

class AddBookViewController: UIViewController {
    
    var presenter: AddBookPresenter!
    
    init(_ presenter: AddBookPresenter) {
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

extension AddBookViewController: AddBookPresentingView {
    
    
}
