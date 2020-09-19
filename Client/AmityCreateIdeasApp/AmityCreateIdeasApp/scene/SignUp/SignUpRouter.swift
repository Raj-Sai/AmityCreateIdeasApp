//
//  SignUpRouter.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 12/9/2563 BE.
//  Copyright (c) 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit

@objc protocol SignUpRouterDelegate
{
    func navigateToNextViewController()
    func navigateToIdeasViewController()
}

class SignUpRouter: SignUpRouterDelegate
{
    var viewController: SignUpViewController?
    
    func navigateToNextViewController() {
        // naviagte here 
    }
    
    func navigateToIdeasViewController() {
        self.viewController?.dismiss(animated: true, completion: nil)
    }
}
