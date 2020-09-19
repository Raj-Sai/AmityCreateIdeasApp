//
//  PostIdeaRouter.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 12/9/2563 BE.
//  Copyright (c) 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit

@objc protocol PostIdeaRouterDelegate
{
    func naviagteToIdeasViewController()
}

class PostIdeaRouter: PostIdeaRouterDelegate
{
    var viewController: PostIdeaViewController?

    func naviagteToIdeasViewController() {
        if let viewController = viewController {
            viewController.dismiss(animated: true, completion: nil)
        }
    }
}
