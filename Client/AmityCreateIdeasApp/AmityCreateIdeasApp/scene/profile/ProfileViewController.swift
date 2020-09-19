//
//  ProfileViewController.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 12/9/2563 BE.
//  Copyright (c) 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit

protocol ProfileView: class
{
    func startLoading()
    func stopLoading()
    func displayUserDetails(userDetails: ProfileModel.UserProfile)
    func dispalyNoInternetErrorAlert()
}

class ProfileViewController: BaseViewController {
    
    /// object for delegates
    var interactor: ProfileInteractorDelegate?
    var router:  ProfileRouterDelegate?
    
    /// conected outlet from storyboard
    @IBOutlet weak var myIdeasTableView: UITableView!
    @IBOutlet weak var initialLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    
    /// global variables
    var userProfile = ProfileModel.UserProfile()
    
    /// initial set up for design pattern
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setUp()
    }
    
    //MARK: - Life cycle methods
    override func viewWillAppear(_ animated: Bool) {
        interactor?.getUserDetails()
    }
    
    override func viewDidLoad() {
        self.setUpTableView()
    }
    
    @IBAction func logoutButtonAction(_ sender: Any) {
        dispalyBottomAlert(withMessage: "Logout and close the app")
    }
}

//MARK: - ProfileView Delegates
extension ProfileViewController: ProfileView {
    
    /// disply spinner while call api
    func startLoading() {
        if let view = self.view {
            self.showSpinnerAnimation(onView: view)
        }
    }
    
     /// remove spinner after finish api call
    func stopLoading() {
        self.removeSpinner()
    }
    
    /// after success show the details
    func displayUserDetails(userDetails: ProfileModel.UserProfile) {
        self.userProfile = userDetails
        if let firstTwoLetters = self.userProfile.user_name {
            self.initialLabel.text = firstTwoLetters.prefix(2).uppercased()
            self.userNameLabel.text = self.userProfile.user_name
            self.userEmailLabel.text = self.userProfile.email
        }
        self.reloadTableView()
    }
    
    func dispalyNoInternetErrorAlert() {
        self.dispalyCommonNoInternetAlert()
    }
}

//MARK: - ProfileViewController extension
extension ProfileViewController {
    
    /// setup dependencies
    private func setUp() {
        let viewController = self
        let interactor = ProfileInteractor()
        let presenter = ProfilePresenter()
        let router = ProfileRouter()
        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
    }
    
    /// setup table view
    func setUpTableView() {
        let nib = UINib(nibName: String(describing: MyIdeasTableViewCell.self), bundle: nil)
        myIdeasTableView.register(nib, forCellReuseIdentifier: "MyIdeasTableViewCell")
        myIdeasTableView.estimatedRowHeight = 110.0
        myIdeasTableView.rowHeight = UITableView.automaticDimension
        self.myIdeasTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.reloadTableView()
    }
    
    /// load tableview
    func reloadTableView() {
        self.myIdeasTableView.reloadData()
    }
    
    /// show alert
    func dispalyBottomAlert(withMessage message: String) {
        let actionSheet = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }

        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            UserDefaults.standard.set(false, forKey: HAS_SIGN_IN)
            UserDefaults.standard.set(false, forKey: HAS_VIEWED_APP_INFO)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                 DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                  exit(0)
                 }
            }
        }
        actionSheet.addAction(cancelAction)
        actionSheet.addAction(okAction)
        self.present(actionSheet, animated: true, completion: nil)
    }
}


// MARK: - UITableView Delegate & DataSource
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    /// table cell count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userProfile.ideas?.count ?? 0
    }
    
    /// setup table cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier:
            "MyIdeasTableViewCell") as? MyIdeasTableViewCell {
            if let userProfileInfo = userProfile.ideas {
                let ideas = userProfileInfo[indexPath.row]
                cell.setupCell(ideas)
            }
            return cell
        }
        return UITableViewCell()
    }
}
