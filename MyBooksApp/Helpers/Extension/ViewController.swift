//
//  ViewController.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/5/20.
//

import UIKit

enum KeyboardState {
    case didShow(keyboardHeight: CGFloat), didHide(keyboardHeight: CGFloat)
}

typealias KeyboardStateChangeCallback = (KeyboardState) -> Void

private class ManagedKeyboardScrollViewWrapper {
    var callback: KeyboardStateChangeCallback
    weak var scrollView: UIScrollView?
    
    init(scrollView: UIScrollView, callback: @escaping KeyboardStateChangeCallback) {
        self.callback = callback
        self.scrollView = scrollView
    }
}

private var managedKeyboardScrollViewWrapperKey = "ManagedKeyboardScrollViewWrapperKey"

extension UIViewController {
    
    @objc func hideKeyboardWhenTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(false)
    }
    
    func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    private var managedKeyboardScrollViewWrapper: ManagedKeyboardScrollViewWrapper? {
        get {
            return objc_getAssociatedObject(self, &managedKeyboardScrollViewWrapperKey) as? ManagedKeyboardScrollViewWrapper
        }
        set {
            newValue?.scrollView?.keyboardDismissMode = .interactive
            objc_setAssociatedObject(self, &managedKeyboardScrollViewWrapperKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func observeKeyboard(for managedScrollView: UIScrollView, with callback: @escaping KeyboardStateChangeCallback) {
        managedKeyboardScrollViewWrapper = ManagedKeyboardScrollViewWrapper(scrollView: managedScrollView, callback: callback)
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        notificationCenter.addObserver(self, selector: #selector(triggerCallback), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        notificationCenter.addObserver(self, selector: #selector(triggerCallback), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        
        guard let managedKeyboardScrollViewWrapper = managedKeyboardScrollViewWrapper, let scrollView = managedKeyboardScrollViewWrapper.scrollView else {
            self.managedKeyboardScrollViewWrapper = nil
            return
        }
        
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = UIEdgeInsets.zero
        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        
        scrollView.scrollIndicatorInsets = scrollView.contentInset
        
    }
    
    @objc func triggerCallback(notification: Notification) {
        guard let managedKeyboardScrollViewWrapper = managedKeyboardScrollViewWrapper else {
            return
        }
        
        var keyboardHeight: CGFloat = 0.0
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
        }
        
        let keyboardState: KeyboardState
        switch notification.name {
        case UIResponder.keyboardWillHideNotification:
            keyboardState = .didHide(keyboardHeight: keyboardHeight)
        case UIResponder.keyboardWillShowNotification:
            keyboardState = .didShow(keyboardHeight: keyboardHeight)
        default: return
        }
        managedKeyboardScrollViewWrapper.callback(keyboardState)
    }
    
}


extension UIScrollView {
    func scrollToBottom(animated: Bool) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        setContentOffset(bottomOffset, animated: animated)
    }
}


