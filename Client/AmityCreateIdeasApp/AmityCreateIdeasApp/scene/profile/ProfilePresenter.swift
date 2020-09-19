//
//  ProfilePresenter.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 12/9/2563 BE.
//  Copyright (c) 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol ProfilePresenterDelegate
{
    func presentStartLoading()
    func presentStopLoading()
    func presentUserDetails(model: ProfileModel.UserProfile)
    func presentNoInternetAlert()
}

class ProfilePresenter: ProfilePresenterDelegate
{
    weak var viewController: ProfileView?
    
    func presentStartLoading() {
        viewController?.startLoading()
    }
    
    func presentStopLoading() {
        viewController?.stopLoading()
    }
    
    func presentUserDetails(model: ProfileModel.UserProfile) {
        viewController?.displayUserDetails(userDetails: model)
    }
    
    func presentNoInternetAlert() {
        viewController?.dispalyNoInternetErrorAlert()
    }
}
