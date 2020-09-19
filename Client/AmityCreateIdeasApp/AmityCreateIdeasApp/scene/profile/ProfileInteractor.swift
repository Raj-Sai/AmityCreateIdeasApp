//
//  ProfileInteractor.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 12/9/2563 BE.
//  Copyright (c) 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit

protocol ProfileInteractorDelegate
{
    func getUserDetails()
}


class ProfileInteractor: ProfileInteractorDelegate
{
    var presenter: ProfilePresenterDelegate!
    var worker = ProfileWorker(with: ProfileService())
    
    func getUserDetails() {
        presenter.presentStartLoading()
        guard let userName = UserDefaults.standard.string(forKey: "userName") else {
            return
        }
        let requestModel = ProfileModel.Request(userName: userName)
        worker.getUserIdeas(request: requestModel, completion: { [weak self] (json) in
            // success
            if let selfObj = self {
                selfObj.presenter.presentStopLoading()
                let jsonDecoder = JSONDecoder.init()
                do {
                    let data = try json.rawData()
                    let userDataObj = try jsonDecoder.decode(ProfileModel.Response.Data.self, from: data)
                    if let userData = userDataObj.data {
                        selfObj.presenter.presentUserDetails(model: userData)
                    }
                } catch {
                    
                }
            }
        }) {[weak self] (httpStatus, errorCode) in
            // fail
            if let selfObj = self {
                selfObj.presenter.presentStopLoading()
                if errorCode == "no_internet_connection" {
                    selfObj.presenter.presentNoInternetAlert()
                }
            }
        }
    }
    
}
