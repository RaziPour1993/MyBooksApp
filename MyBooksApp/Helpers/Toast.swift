//
//  Toast.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/5/20.
//


import Foundation
import UIKit

class ToastLabel: UILabel {
    var textInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: textInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textInsets.top, left: -textInsets.left, bottom: -textInsets.bottom, right: -textInsets.right)
        
        return textRect.inset(by: invertedInsets)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
}

enum ToastPosition {
    case buttom
    case top
    case center
    case custom(_ constant: CGFloat)
    
    var constant: CGFloat {
        switch self {
        case .buttom: return -50
        case .top: return (UIScreen.main.bounds.height - 50.0)
        case .center: return UIScreen.main.bounds.height / 2
        case .custom(let value): return value
        }
    }
    
}

let toastLabel = ToastLabel()

extension UIView {
    
    func showToast(_ text: String, delay: TimeInterval = 1.0, position: ToastPosition = .custom(-70)) {
        toastLabel.removeFromSuperview()
        toastLabel.backgroundColor = UIColor(white: 0, alpha: 0.5)
        toastLabel.textColor = .white
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 15)
        toastLabel.alpha = 0
        toastLabel.text = text
        toastLabel.clipsToBounds = true
        toastLabel.layer.cornerRadius = 20
        toastLabel.numberOfLines = 0
        toastLabel.textInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(toastLabel)
        
        let saveArea = self.safeAreaLayoutGuide
        toastLabel.centerXAnchor.constraint(equalTo: saveArea.centerXAnchor, constant: 0).isActive = true
        toastLabel.leadingAnchor.constraint(greaterThanOrEqualTo: saveArea.leadingAnchor, constant: 15).isActive = true
        toastLabel.trailingAnchor.constraint(lessThanOrEqualTo: saveArea.trailingAnchor, constant: -15).isActive = true
        toastLabel.bottomAnchor.constraint(equalTo: saveArea.bottomAnchor, constant: position.constant).isActive = true
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            toastLabel.alpha = 1
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: delay, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0
            }, completion: {_ in
                toastLabel.removeFromSuperview()
            })
        })
    }
    
}

extension UIViewController {
    
    func showToast(_ text: String, delay: TimeInterval = 1.0, position: ToastPosition = .custom(-70)) {
        toastLabel.removeFromSuperview()
        toastLabel.backgroundColor = UIColor(white: 0, alpha: 0.5)
        toastLabel.textColor = .white
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 15)
        toastLabel.alpha = 0
        toastLabel.text = text
        toastLabel.clipsToBounds = true
        toastLabel.layer.cornerRadius = 20
        toastLabel.numberOfLines = 0
        toastLabel.textInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toastLabel)
        
        let saveArea = view.safeAreaLayoutGuide
        toastLabel.centerXAnchor.constraint(equalTo: saveArea.centerXAnchor, constant: 0).isActive = true
        toastLabel.leadingAnchor.constraint(greaterThanOrEqualTo: saveArea.leadingAnchor, constant: 15).isActive = true
        toastLabel.trailingAnchor.constraint(lessThanOrEqualTo: saveArea.trailingAnchor, constant: -15).isActive = true
        toastLabel.bottomAnchor.constraint(equalTo: saveArea.bottomAnchor, constant: position.constant).isActive = true
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            toastLabel.alpha = 1
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: delay, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0
            }, completion: {_ in
                toastLabel.removeFromSuperview()
            })
        })
    }
}

