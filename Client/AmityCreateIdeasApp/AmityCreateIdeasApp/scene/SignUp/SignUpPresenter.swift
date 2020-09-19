//
//  SignUpPresenter.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 12/9/2563 BE.
//  Copyright (c) 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit

protocol SignUpPresenterDelegate
{
    func presetStartLoading()
    func prestStopLoading()
    func presentSignUpSuccess()
    func presentUserSignUpValidationFailError(errorType: SignUpModel.ErrorType)
    func presentBottomAlert()
    func presentBottomAlertForValidation()
    func presentBottomAlertForPasswordValidation()
    func presentNoInternetAlert()
}

class SignUpPresenter: SignUpPresenterDelegate
{
    weak var viewController: SignUpView?
    
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
    
    func presentSignUpSuccess() {
        if let viewController = viewController {
            viewController.displaySignUpSuccess()
        }
    }
    
    func presentUserSignUpValidationFailError(errorType: SignUpModel.ErrorType) {
       if let viewController = viewController {
        switch errorType {
        case .userAlreadyExist:
            viewController.dispalyBottomErrorAlert(withMessage: "This user name already exist, try another name")
        default:
            viewController.dispalyBottomErrorAlert(withMessage: "Some thing went wrong, try again")
        }
        }
    }
    
    func presentBottomAlert() {
       if let viewController = viewController {
            viewController.dispalyBottomErrorAlert(withMessage: "Please input all the values")
        }
    }
    
    func presentBottomAlertForValidation() {
       if let viewController = viewController {
            viewController.dispalyBottomErrorAlert(withMessage: "Please input all the values correct format")
        }
    }
    
    func presentBottomAlertForPasswordValidation() {
       if let viewController = viewController {
            viewController.dispalyBottomErrorAlert(withMessage: "Password and Confirm Password mismatch")
        }
    }
    
    func presentNoInternetAlert() {
        viewController?.dispalyNoInternetErrorAlert()
    }
}
