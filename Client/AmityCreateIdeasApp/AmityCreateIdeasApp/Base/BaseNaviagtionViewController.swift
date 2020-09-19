//
//  BaseNaviagtionViewController.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 12/9/2563 BE.
//  Copyright © 2563 Amsaraj Mariyappan. All rights reserved.
//

import Foundation

import UIKit

public class BaseNaviagtionViewController: UINavigationController, UINavigationControllerDelegate {

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        let yourBackImage = UIImage(named: "ic_nav_back", in: nil, compatibleWith: nil)
        self.navigationBar.backIndicatorImage = yourBackImage
        self.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        
        self.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1.0),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)
        ]
        self.navigationBar.setBarColor(.clear)
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target: nil, action: nil)
        viewController.navigationController?.navigationBar.tintColor = UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0)
    }
}

