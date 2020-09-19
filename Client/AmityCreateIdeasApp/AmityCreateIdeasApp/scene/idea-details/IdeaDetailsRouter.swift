//
//  IdeaDetailsRouter.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 13/9/2563 BE.
//  Copyright (c) 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit

@objc protocol IdeaDetailsRouterDelegate
{
    func naviagteToIdeasViewController()
}

class IdeaDetailsRouter: IdeaDetailsRouterDelegate
{
    
    var viewController: IdeaDetailsViewController?

    /// naviagte to IdeasViewController
    func naviagteToIdeasViewController() {
        if let viewControllerObj = viewController {
            viewControllerObj.dismiss(animated: true, completion: nil)
        }
    }
}
