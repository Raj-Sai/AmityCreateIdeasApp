//
//  LoginInteractor.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 12/9/2563 BE.
//  Copyright (c) 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit

protocol LoginInteractorDelegate
{
    func login(userName: String, password: String)
}


class LoginInteractor: LoginInteractorDelegate
{
    var presenter: LoginPresenterDelegate!
    var worker = LoginWorker(with: LoginService())
    
    /// login
    func login(userName: String, password: String) {
        
        /// check user name and password empty
        if userName.isEmpty
            && password.isEmpty
        {
            self.presenter?.presentBottomAlert()
            
        } else {
            self.presenter.presetStartLoading()
            let loginRequestModel = LoginModel.Request(userName: userName, password: password)
            worker.verifyUser(resquest: loginRequestModel, completion: { [weak self] (json) in
                // success
                if let selfObj = self {
                    UserDefaults.standard.set(userName, forKey: "userName")
                    selfObj.presenter.prestStopLoading()
                    selfObj.presenter.presentLoginSuccess()
                }
            }) {[weak self] (httpStatus, errorCode) in
                // fail
                if let selfObj = self {
                    selfObj.presenter.prestStopLoading()
                    if errorCode == "no_internet_connection" {
                        selfObj.presenter.presentNoInternetAlert()
                    } else {
                        var errorType: LoginModel.ErrorType
                        if errorCode == "user_not_exist" {
                            errorType = .userNotExist
                        } else if errorCode == "invalid_passcode" {
                            errorType = .incorectPasscode
                        } else {
                            errorType = .generalError
                        }
                        selfObj.presenter.presentUserValidationFailError(errorType: errorType)
                    }
                }
            }
        }
    }
    
}
