//
//  LoginPresenter.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 12/9/2563 BE.
//  Copyright (c) 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit

protocol LoginPresenterDelegate
{
    func presentLoginSuccess()
    func presetStartLoading()
    func prestStopLoading()
    func presentUserValidationFailError(errorType: LoginModel.ErrorType)
    func presentBottomAlert()
    func presentNoInternetAlert()
}

class LoginPresenter: LoginPresenterDelegate
{
    weak var viewController: LoginView?
    
    func presentLoginSuccess() {
        if let viewController = viewController {
            viewController.displayLoginSuccess()
        }
    }
    
    func presetStartLoading() {
        if let viewController = viewController {
            viewController.startLoading()
        }
    }
    
    func prestStopLoading() {
        if let viewController = viewController {
            viewController.stopLoading()
        }
    }
    
    func presentUserValidationFailError(errorType: LoginModel.ErrorType) {
        if let viewController = viewController {
            viewController.displayUserValidationFailError(errorType: errorType)
        }
    }
    
    func presentBottomAlert() {
       if let viewController = viewController {
            viewController.dispalyBottomErrorAlert(withMessage: "Please input all the values")
        }
    }
    
    func presentNoInternetAlert() {
        viewController?.dispalyNoInternetErrorAlert()
    }

}
