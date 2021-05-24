//
//  UIViewControllerExt.swift
//  GitHubFollowers
//
//  Created by Садык Мусаев on 24.05.2021.
//

import UIKit

//Спрятать клавиатуру при тапе в любом месте
extension UIViewController{
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
