//
//  SignUpInteractor.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 12/9/2563 BE.
//  Copyright (c) 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit

protocol SignUpInteractorDelegate
{
    func userSignUp(requestModel: SignUpModel.Request)
}


class SignUpInteractor: SignUpInteractorDelegate
{
    var presenter: SignUpPresenterDelegate!
    var worker = SignUpWorker(with: SignUpService())
    
    /// signup new users
    func userSignUp(requestModel: SignUpModel.Request) {
        /// validate user input fields not empty
        if requestModel.userName.isEmpty
            && requestModel.email.isEmpty
            && requestModel.phoneNumber.isEmpty
            && requestModel.password.isEmpty
            && requestModel.confirmPassword.isEmpty {
            
            self.presenter.presentBottomAlert()
            
        } else if !validateUserDetails(requestModel) {
            self.presenter.presentBottomAlertForValidation()
            
        } else if !isValidatePassword(requestModel) {
            self.presenter.presentBottomAlertForPasswordValidation()
            
        } else {
            self.presenter.presetStartLoading()
            /// signup
            worker.userSignUp(resquest: requestModel, completion: { [weak self] (json) in
                // success
                if let selfObj = self {
                    UserDefaults.standard.set(true, forKey: HAS_SIGN_IN)
                    UserDefaults.standard.set(requestModel.userName, forKey: "userName")
                    selfObj.presenter.prestStopLoading()
                    selfObj.presenter.presentSignUpSuccess()
                }
            }) {[weak self] (httpStatus, errorCode) in
                // fail
                if let selfObj = self {
                    if errorCode == "no_internet_connection" {
                        selfObj.presenter.presentNoInternetAlert()
                    } else {
                        selfObj.presenter.prestStopLoading()
                        var errorType: SignUpModel.ErrorType
                        if errorCode == "user_already_exist" {
                            errorType = .userAlreadyExist
                        } else {
                            errorType = .generalError
                        }
                        selfObj.presenter.presentUserSignUpValidationFailError(errorType: errorType)
                    }
                }
            }
        }
    }
    
    /// validate user inputs
    func validateUserDetails(_ requestModel: SignUpModel.Request) -> Bool {
        if requestModel.userName.isAlphanumeric && requestModel.email.isEmail && requestModel.phoneNumber.isValidPhoneNumber {
            return true
        }
        return false
    }
    
    /// validate password with confirm password
    func isValidatePassword(_ requestModel: SignUpModel.Request) -> Bool{
        if requestModel.password == requestModel.confirmPassword {
            return true
        }
        return false
    }
    
}
