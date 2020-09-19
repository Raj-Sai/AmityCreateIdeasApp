//
//  TabBarController.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 13/9/2563 BE.
//  Copyright © 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let identifier = viewController.restorationIdentifier, identifier == "PostIdeaViewController" {
            
            let storyboard = UIStoryboard(name: "PostIdeaStoryboard", bundle: nil)
            if let postIdeaViewController = storyboard.instantiateViewController(withIdentifier: "PostIdeaViewController") as? PostIdeaViewController {
                postIdeaViewController.modalPresentationStyle = .fullScreen
                self.presentFullScreen(BaseNaviagtionViewController(rootViewController: postIdeaViewController), animated: true)
            }
            
            return false
        }

        return true
    }
}
