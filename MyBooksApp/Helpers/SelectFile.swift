//
//  SelectFile.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/5/20.
//

import Foundation
import UIKit

protocol SelectFileDelegate: class {
    func selectFileCancelled()
    func selectedFile(data: Data)
}

protocol SelectFile {
    func selectFile()
    func cancel()
}

enum SelectFileOption: Hashable {
    case takePhoto(_ allowsEditing: Bool)
    case photoLibrary(_ allowsEditing: Bool)
    case file
    
    var title: String {
        switch self {
        case .takePhoto: return "TakePhoto"
        case .photoLibrary: return "PhotoLibrary"
        case .file: return "File"
        }
    }
}

class SelectFileIMP: NSObject, SelectFile {
    
    private let imagePickerController: UIImagePickerController!
    private weak var delegate: SelectFileDelegate?
    private weak var presentationController: UIViewController?
    private var options: [SelectFileOption]
    
    init(delegate: SelectFileDelegate, presentationController: UIViewController, options: [SelectFileOption]) {
        self.delegate = delegate
        self.options = options
        self.presentationController = presentationController
        self.imagePickerController = UIImagePickerController()
        self.imagePickerController.mediaTypes = ["public.image"]
    }
    
    func selectFile() {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        self.options.forEach { (option) in
            switch option {
                
            case .takePhoto(let allowsEditing):
                let action = UIAlertAction(title: option.title.localized, style: .default) { (tap) in
                    self.imagePickerController.sourceType = .camera
                    self.imagePickerController.allowsEditing = allowsEditing
                    self.presentationController?.present(self.imagePickerController, animated: true)
                }
                self.imagePickerController.delegate = self
                alertController.addAction(action)
                
                
            case .photoLibrary(let allowsEditing):
                let action = UIAlertAction(title: option.title.localized, style: .default) { (tap) in
                    self.imagePickerController.sourceType = .photoLibrary
                    self.imagePickerController.allowsEditing = allowsEditing
                    self.presentationController?.present(self.imagePickerController, animated: true)
                }
                self.imagePickerController.delegate = self
                alertController.addAction(action)
                
            case .file:
                let action = UIAlertAction(title: option.title.localized, style: .default) { (tap) in
                    let importMenu = UIDocumentPickerViewController(documentTypes: ["public.item"], in: .import)
                    importMenu.delegate = self
                    importMenu.modalPresentationStyle = .fullScreen
                    UINavigationBar.appearance(whenContainedInInstancesOf: [UIDocumentBrowserViewController.self]).tintColor = .black
                    self.presentationController!.present(importMenu, animated: true, completion: nil)
                }
                alertController.addAction(action)
                
            }
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = self.presentationController?.view
            alertController.popoverPresentationController?.sourceRect = (self.presentationController?.view.bounds)!
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }
        
        self.presentationController?.present(alertController, animated: true)
        
    }
    
    func cancel() {
        
    }
    
}


extension SelectFileIMP: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate  {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        self.delegate?.selectFileCancelled()
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        let allowsEditing = options.compactMap { (item) -> Bool? in
            switch item {
            case .file: return nil
            case .photoLibrary(let allowsEditing): return allowsEditing
            case .takePhoto(let allowsEditing): return allowsEditing
            }
        }
        
        guard let allow = allowsEditing.first else {
            return
        }
        
        guard let image = info[allow ? .editedImage : .originalImage] as? UIImage else {
            return
        }
        
        guard let data = image.pngData() else {
            return
        }
        
        self.delegate?.selectedFile(data: data)
        
    }
    
}
