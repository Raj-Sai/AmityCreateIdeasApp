//
//  AppInfoViewController.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 12/9/2563 BE.
//  Copyright © 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit

class AppInfoViewController: UIViewController {
    
    /// outlet connected from storyboard
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.layer.cornerRadius = 25.0
            nextButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var skipButton: UIButton!
    
    
    /// global variables
    var appInfoPageViewController: AppInfoPageViewController?
    
    //MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// skip button action in first onboard screen
    @IBAction func skipButtonTapped(sender: UIButton) {
        UserDefaults.standard.set(true, forKey: HAS_VIEWED_APP_INFO)
        dismiss(animated: true, completion: nil)
    }
    
    /// next button action
    @IBAction func nextButtonTapped(send: UIButton) {
        if let index = appInfoPageViewController?.currentIndex {
            /// based on current screen go to next screen
            switch index {
            case 0...1:
                appInfoPageViewController?.forwardPage()
            case 2:
                UserDefaults.standard.set(true, forKey: HAS_VIEWED_APP_INFO)

                let storyboard = UIStoryboard(name: "LoginStoryboard", bundle: nil)
                if let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                    self.navigationController?.pushViewController(loginViewController, animated: true)
                }                
            default: break
            }
        }
        updateUI()
    }
    
    /// update UI screen based on current screen
    private func updateUI() {
        if let index = appInfoPageViewController?.currentIndex {
            switch index {
            case 0...1:
                nextButton.setTitle("NEXT", for: .normal)
                skipButton.isHidden = false
            case 2:
                nextButton.setTitle("GET STARTED", for: .normal)
                skipButton.isHidden = true
                
            default: break
            }
            pageControl.currentPage = index
        }
    } 
    
    /// prepare for naviagtion
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let pageViewController = destination as? AppInfoPageViewController {
            appInfoPageViewController = pageViewController
            appInfoPageViewController?.appInfoDelegate = self
        }
    }
}

//MARK: - IdeasView Delegate
extension AppInfoViewController: AppInfoPageViewControllerDelegate {
    /// update screen index
    func didUpdatePageIndex(currentIndex: Int) {
        updateUI()
    }
}

