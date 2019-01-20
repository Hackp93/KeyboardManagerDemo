//
//  KeyboardManager.swift
//  KayboardManager
//
//  Created by Manu Singh on 04/10/18.
//  Copyright © 2018 Manu Singh. All rights reserved.
//

import UIKit

class KeyboardManager: NSObject {

    static var shared =  KeyboardManager()
    var isEnabled  =  false {
        didSet {
            if isEnabled {
                initializeManager()
            }
        }
    }
    
    private weak var scrollView : UIScrollView?
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private override init() {
        super.init()
    }
    
    private func initializeManager(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc private func keyboardWillAppear(_ notification : Notification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            scrollView = getScrollView(forView: UIApplication.shared.keyWindow!)
            scrollView?.contentInset  =  UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        }
    }
    
    @objc private func keyboardWillHide(_ notification : Notification){
        scrollView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private func getScrollView(forView view : UIView)->UIScrollView? {
        
        for subview in view.subviews {
            
            if let scrollview = subview as? UIScrollView {
                return scrollview
            } else {
                return getScrollView(forView: subview)
            }
        }
        return nil
    }
    
}


extension UITextField {
    open override func awakeFromNib() {
        super.awakeFromNib()
        let toolBar =  UIToolbar(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        toolBar.items  =  [UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onClickDone))]
        inputAccessoryView  =  toolBar
    }
    
    @objc private func onClickDone(_ sender : UIBarButtonItem){
        resignFirstResponder()
    }
    
}


extension UITextView {
    open override func awakeFromNib() {
        super.awakeFromNib()
        let toolBar =  UIToolbar(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        toolBar.items  =  [UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onClickDone))]
        inputAccessoryView  =  toolBar
    }
    
    @objc private func onClickDone(_ sender : UIBarButtonItem){
        resignFirstResponder()
    }
}
