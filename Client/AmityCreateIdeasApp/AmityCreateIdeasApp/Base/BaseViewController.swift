//
//  BaseViewController.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 15/9/2563 BE.
//  Copyright © 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var spinner: UIView?

    func navbarColor() {
        navigationController?.navigationBar.barTintColor = UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1)
    }

    /// common spinner show while load api
    func showSpinnerAnimation(onView: UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        var style: UIActivityIndicatorView.Style!
        
        if #available(iOS 13, *) {
            style = UIActivityIndicatorView.Style.large
        } else {
            style = UIActivityIndicatorView.Style.whiteLarge
        }
        
        DispatchQueue.main.async {
            let view = UIActivityIndicatorView.init(style: style)
            view.color = .black
            view.startAnimating()
            view.center = spinnerView.center
            spinnerView.addSubview(view)
            onView.addSubview(spinnerView)
            self.spinner = spinnerView
        }
    }

    /// remove spinner
    func removeSpinner() {
         DispatchQueue.main.async {
            self.spinner?.removeFromSuperview()
            self.spinner = nil
        }
    }
    
    /// keyboard handles
    func commonKeyboard(_ notification: Notification, scrollview: UIScrollView) {
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollview.contentInset = UIEdgeInsets.zero
        } else {
            scrollview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        
        scrollview.scrollIndicatorInsets = scrollview.contentInset
    }
    
    
    /// show error dialog for no internet connection
    func dispalyCommonNoInternetAlert() {
        let actionSheet = UIAlertController(title: nil, message: "No Internet Connection, Try later", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            print("didPress cancel")
        }
        actionSheet.addAction(okAction)
        self.present(actionSheet, animated: true, completion: nil)
    }
}
