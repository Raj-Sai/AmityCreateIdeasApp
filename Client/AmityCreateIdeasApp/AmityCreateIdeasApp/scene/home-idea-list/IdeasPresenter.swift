//
//  IdeasPresenter.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 12/9/2563 BE.
//  Copyright (c) 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit

protocol IdeasPresenterDelegate
{
    func presentStartLoading()
    func presentStopLoading()
    func presentToLandOnboardScreen()
    func presentToLandLoginScreen()
    func presentIdeasList(ideaListModel: IdeasModel.Response.Ideas)
    func presentNoInternetAlert()
}

class IdeasPresenter: IdeasPresenterDelegate
{
    weak var viewController: IdeasView?
    
    func presentStopLoading() {
        if let viewController = viewController {
            viewController.stopLoading()
        }
    }
    
    func presentStartLoading() {
        if let viewController = viewController {
            viewController.startLoading()
        }
    }
    
    func presentIdeasList(ideaListModel: IdeasModel.Response.Ideas) {
        if let viewController = viewController {
            viewController.displayIdeasList(ideaListModel: ideaListModel)
        }
    }
    
    func presentToLandLoginScreen() {
        if let viewController = viewController {
            viewController.landToLoginScreen()
        }
    }
    
    func presentToLandOnboardScreen() {
        if let viewController = viewController {
            viewController.landToOnbardScreen()
        }
    }
    
    func presentNoInternetAlert() {
        viewController?.dispalyNoInternetErrorAlert()
    }
}
