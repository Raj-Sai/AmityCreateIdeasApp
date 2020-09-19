//
//  AppWalkthroughPageViewController.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 12/9/2563 BE.
//  Copyright © 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit

protocol AppInfoPageViewControllerDelegate: class {
    func didUpdatePageIndex(currentIndex: Int)
}

class AppInfoPageViewController: UIPageViewController {
    
    /// heading, image and messgae for onboard
    private var pageHeadings = ["Post an Idea", "View others Idea", "Comment on others Idea"]
    private var pageImages = ["onboarding-1", "onboarding-2", "onboarding-3"]
    private var pageSubheadings = ["Post your Idea, thoughts or opinion to improve the existing system.", "View others idea on the particular problem, and various comments by others.", "Share our thoughts or opinion on others idea."]
    /// global variables
    var currentIndex = 0
    weak var appInfoDelegate: AppInfoPageViewControllerDelegate?
    
    //MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Set the datasource to itself
        dataSource = self
        delegate = self
        
        /// Create the first walkthrough screen
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    private func contentViewController(at index: Int) -> AppInfoContentViewController? {
        if index < 0 || index >= pageHeadings.count {
            return nil
        }
        /// Create a new view controller and pass suitable data.
        let storyboarad = UIStoryboard(name: "AppInfoContentStoryboard", bundle: nil)
        if let pageContentViewController = storyboarad.instantiateViewController(withIdentifier: "AppInfoContentViewController") as? AppInfoContentViewController {
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.heading = pageHeadings[index]
            pageContentViewController.subheading = pageSubheadings[index]
            pageContentViewController.index = index
            
            return pageContentViewController
        }
        
        return nil
    }
    
    /// forwardPage
    func forwardPage() {
        currentIndex += 1
        if let nextViewController = contentViewController(at: currentIndex) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
}

// MARK: - Delegate & DataSource
extension AppInfoPageViewController: UIPageViewControllerDataSource,
UIPageViewControllerDelegate {
    /// previous screen
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! AppInfoContentViewController).index
        index -= 1
        return contentViewController(at: index)
    }
    
    /// next screen
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! AppInfoContentViewController).index
        index += 1
        return contentViewController(at: index)
    }
    
    /// naviagte animation
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let contentViewController = pageViewController.viewControllers?
                .first as? AppInfoContentViewController {
                currentIndex = contentViewController.index
                appInfoDelegate?.didUpdatePageIndex(currentIndex: contentViewController.index)
            }
        }
    }
}

