//
//  ViewController.swift
//  subirTeclado
//
//  Created by Diego William Crozare on 23/09/18.
//  Copyright © 2018 Diego William Crozare. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        subKeyboard()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unshowKeyboard()
    }
    
    // Create notification to warn you when the keyboard goes up and down
    func subKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardHideShow(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // Remove the Notifications
    func unshowKeyboard() {
        NotificationCenter.default.removeObserver(self)
    }
    
    // Delegate TextField - click return on Keyboard warning
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Open keyboard textField sizing
    @objc func keyBoardWillShow(_ notification: Notification) {
        view.frame.origin.y -= getKeyboardHeight(notification)
    }

    // Close keyboard textField sizing
    @objc func keyBoardHideShow(_ notification: Notification) {
        view.frame.origin.y += getKeyboardHeight(notification)
    }
    
    // Height keyboard
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
}
