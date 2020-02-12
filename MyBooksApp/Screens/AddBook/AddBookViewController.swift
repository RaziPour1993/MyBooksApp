//
//  AddBookViewController.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/5/20.
//

import UIKit

class AddBookViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var coverContainerView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var addCoverButton: UIButton!
    @IBOutlet weak var deleteCoverButton: UIButton!
    @IBOutlet weak var nameTextField: TextFieldInput!
    @IBOutlet weak var authorTextField: TextFieldInput!
    @IBOutlet weak var pagesCountTextField: TextFieldInput!
    @IBOutlet weak var descriptionsTextView: TextViewInput!
    
    var presenter: AddBookPresenter!
    var selectFile: SelectFile?
    
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
        self.viewConfig()
        self.config()
        self.presenter.present()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.observeKeyboard(for: self.scrollView) { _ in }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.removeKeyboardObserver()
    }
    
}

extension AddBookViewController {
    
    func config() {
        let addBookButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonAction))
        self.navigationItem.rightBarButtonItem = addBookButton
        self.addCoverButton.addTarget(self, action: #selector(self.addCoverButtonAction), for: .touchDown)
        self.deleteCoverButton.addTarget(self, action: #selector(self.deleteCoverButtonAction), for: .touchDown)
    }
    
    func viewConfig() {
        self.navigationItem.title = "AddBook".localized
        self.hideKeyboardWhenTap()
        self.descriptionsTextView.placeholder = "Descriptions".localized
        self.coverContainerView.setBorder()
        self.descriptionsTextView.setBorder()
    }
    
    @objc func addButtonAction() {
        self.view.endEditing(false)
        self.presenter.didTapAdd()
    }
    
}

extension AddBookViewController: SelectFileDelegate {
    
    @objc func addCoverButtonAction() {
        self.view.endEditing(false)
        self.selectFile = SelectFileIMP(delegate: self, presentationController: self, options: [.photoLibrary(true), .takePhoto(true)])
        self.selectFile?.selectFile()
    }
    
    @objc func deleteCoverButtonAction() {
        self.view.endEditing(false)
        self.presenter.didTapDeleteCover()
    }
    
    func selectFileCancelled() {
        self.selectFile = nil
    }
    
    func selectedFile(data: Data) {
        self.presenter.didSelectedCover(image: data)
    }
}

extension AddBookViewController: AddBookPresentingView {
    
    func returnInfo() -> AddBook {
        let info = AddBook(name: self.nameTextField.text!,
                           author: self.authorTextField.text!,
                           pagesCount: self.pagesCountTextField.text!,
                           descriptions: self.descriptionsTextView.text)
        return info
    }
    
    func invalidName(message: String) {
        self.showToast(message.localized)
    }
    
    func invalidAuthor(message: String) {
        self.showToast(message.localized)
    }
    
    func invalidPagesCount(message: String) {
        self.showToast(message.localized)
    }
    
    func coverDeleted() {
        self.coverImageView.image = nil
    }
    
    func coverAdded(image: Data) {
        self.coverImageView.image = UIImage(data: image)
    }
    
}
