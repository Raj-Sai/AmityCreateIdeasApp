//
//  PostIdeaPresenter.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 12/9/2563 BE.
//  Copyright (c) 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit

protocol PostIdeaPresenterDelegate
{
    func presentStartLoading()
    func presentStopLoading()
    func presentPostIdeasSuccess()
    func prrsentBottomErrorAlert()
    func presentNoInternetAlert()
}

class PostIdeaPresenter: PostIdeaPresenterDelegate
{
    weak var viewController: PostIdeaView?
    
    func presentStopLoading() {
        if let viewController = viewController {
            viewController.displayStopLoading()
        }
    }
    
    func presentStartLoading() {
        if let viewController = viewController {
            viewController.displayStartLoading()
        }
    }
    
    func presentPostIdeasSuccess() {
        if let viewController = viewController {
            viewController.displayPostNewIdeaSuccess()
        }
    }
    
    func prrsentBottomErrorAlert() {
        if let viewController = viewController {
            viewController.dispalyBottomErrorAlert(withMessage: "Please input all the values")
        }
    }
    
    func presentNoInternetAlert() {
        viewController?.dispalyNoInternetErrorAlert()
    }
}
