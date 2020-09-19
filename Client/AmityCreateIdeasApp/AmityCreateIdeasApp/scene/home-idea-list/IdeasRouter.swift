//
//  IdeasRouter.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 12/9/2563 BE.
//  Copyright (c) 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit

@objc protocol IdeasRouterDelegate
{
    func naviagteToAppInfoViewController()
    func naviagteToLoginViewController()
    func navigateToIdeaDetailsViewController(_ selectedIdeaId: String)
}

class IdeasRouter: IdeasRouterDelegate
{
    var viewController: IdeasViewController?
    
    /// naviagte to login screen
    func naviagteToLoginViewController() {
        guard let viewControllerObj = viewController else {
            return
        }
        let storyboard = UIStoryboard(name: "LoginStoryboard", bundle: nil)
        if let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            loginViewController.modalPresentationStyle = .fullScreen
            viewControllerObj.presentFullScreen(BaseNaviagtionViewController(rootViewController: loginViewController), animated: true)
        }
        
    }
    
    /// naviagte to onbard screen
    func naviagteToAppInfoViewController() {
        guard let viewControllerObj = viewController else {
            return
        }
        let storyboard = UIStoryboard(name: "AppInfoViewStoryboard", bundle: nil)
        if let appInfoViewController = storyboard.instantiateViewController(withIdentifier: "AppInfoViewController") as? AppInfoViewController {
            appInfoViewController.modalPresentationStyle = .fullScreen
            viewControllerObj.presentFullScreen(BaseNaviagtionViewController(rootViewController: appInfoViewController), animated: true)
        }
    }
    
    /// naviagte to details view controller
    func navigateToIdeaDetailsViewController(_ selectedIdeaId: String) {
        guard let viewControllerObj = viewController else {
            return
        }
        let storyboard = UIStoryboard(name: "IdeaDetailsStoryboard", bundle: nil)
        if let ideaDetailsViewController = storyboard.instantiateViewController(withIdentifier: "IdeaDetailsViewController") as? IdeaDetailsViewController {
            ideaDetailsViewController.selectedIdea = selectedIdeaId
            ideaDetailsViewController.modalPresentationStyle = .fullScreen
            viewControllerObj.presentFullScreen(BaseNaviagtionViewController(rootViewController: ideaDetailsViewController), animated: true)
        }
    }
}
