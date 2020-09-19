//
//  IdeaDetailsPresenter.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 13/9/2563 BE.
//  Copyright (c) 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol IdeaDetailsPresenterDelegate
{
    func presentStartLoading()
    func presentStopLoading()
    func presentIdeaDetails(ideaDetailsJSON: JSON)
    func presentTableViewBasedOnSegment(selectedSegment: String)
    func presentNoInternetAlert()
}

class IdeaDetailsPresenter: IdeaDetailsPresenterDelegate
{
    weak var viewController: IdeaDetailsView?
    
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
    
    func presentIdeaDetails(ideaDetailsJSON: JSON) {
        if let viewController = viewController {
            let ideaDetails = IdeasModel.Response.Idea.init(json: ideaDetailsJSON)
            viewController.displayIdeaDetils(model: ideaDetails)
        }
    }
    
    func presentTableViewBasedOnSegment(selectedSegment: String) {
        if let viewController = viewController {
            viewController.displayTableViewBasedOnSegmentSelection(segment: selectedSegment)
        }
    }
    
    func presentNoInternetAlert() {
        viewController?.dispalyNoInternetErrorAlert()
    }
    
}
