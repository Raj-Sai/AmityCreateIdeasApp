//
//  LoginRouter.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 12/9/2563 BE.
//  Copyright (c) 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit

@objc protocol LoginRouterDelegate
{
    func navigateToNextViewController()
    func naviagteToIdeasViewController()
    func navaigateToSignUpViewController()
}

class LoginRouter: LoginRouterDelegate
{
    var viewController: LoginViewController?
    
    func navigateToNextViewController() {
        // naviagte here 
    }
    
    func naviagteToIdeasViewController() {
        self.viewController?.dismiss(animated: true, completion: nil)
    }
    
    func navaigateToSignUpViewController() {
        guard let nextVc = UIStoryboard(name: "SignUpViewController",
                                        bundle:  nil).instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { return }
        self.viewController?.navigationController?.pushViewController( nextVc, animated: true)
        //self.viewController.pushViewController(nextVc, animated: true)
    }
}
