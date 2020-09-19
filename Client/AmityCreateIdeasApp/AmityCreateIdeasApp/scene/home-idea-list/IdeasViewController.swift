//
//  IdeasViewController.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 12/9/2563 BE.
//  Copyright (c) 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit

protocol IdeasView: class
{
    func startLoading()
    func stopLoading()
    func displayIdeasList(ideaListModel: IdeasModel.Response.Ideas)
    func landToOnbardScreen()
    func landToLoginScreen()
    func dispalyNoInternetErrorAlert()
}

class IdeasViewController: BaseViewController {
    
    /// object for delegates
    var interactor: IdeasInteractorDelegate?
    var router:  IdeasRouterDelegate?
    
    /// conected outlet from storyboard
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var ideasTabelView: UITableView!
    
    /// global variables
    var isShowOnboard: Bool = true
    var ideaList: IdeasModel.Response.Ideas?
    
    /// initial set up for design pattern
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.setUp()
    }
    
    //MARK: - Life cycle methods
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        segment.selectedSegmentIndex = 0
        if let interactorDelegate = interactor {
            interactorDelegate.userLandingScreen()
        }
    }
    
    override func viewDidLoad() {
        self.setUpTableView()
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        segment.setTitleTextAttributes(titleTextAttributes, for: .normal)
        segment.setTitleTextAttributes(titleTextAttributes, for: .selected)
    }

    /// segement index change listener
    @IBAction func indexChanged(_ sender: Any) {
        guard let interactor = interactor else {
            return
        }
        guard var ideasList = ideaList else {
            return
        }
        interactor.selectedSegment(segment.selectedSegmentIndex, withIdeas: &ideasList)
    }
    
}

//MARK: - IdeasView Delegate
extension IdeasViewController: IdeasView {
    
    /// load spinner while call api
    func startLoading() {
        if let view = self.view {
            self.showSpinnerAnimation(onView: view)
        }
    }
    
     /// remove spinner after api success or fail
    func stopLoading() {
        self.removeSpinner()
    }
    
    /// reload tableview
    func displayIdeasList(ideaListModel: IdeasModel.Response.Ideas)
    {
        self.ideaList = ideaListModel
        self.reloadTableView()
    }
    
    /// naviagte to login screen
    func landToLoginScreen() {
        if let routerObj = self.router {
            routerObj.naviagteToLoginViewController()
        }
    }
    
    /// naviagte to onboard screen
    func landToOnbardScreen() {
        if let routerObj = self.router {
            routerObj.naviagteToAppInfoViewController()
        }
    }
    
    /// show connection alert
    func dispalyNoInternetErrorAlert() {
        self.dispalyCommonNoInternetAlert()
    }
}

//MARK: - IdeasViewController extension
extension IdeasViewController {
    /// configurator
    private func setUp() {
        let viewController = self
        let interactor = IdeasInteractor()
        let presenter = IdeasPresenter()
        let router = IdeasRouter()
        router.viewController = viewController
        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
    }
    
    /// setup tableview
    private func setUpTableView() {
        let nib = UINib(nibName: String(describing: IdeasTableViewCell.self), bundle: nil)
        self.ideasTabelView.register(nib, forCellReuseIdentifier: "IdeasTableViewCell")
        self.ideasTabelView.estimatedRowHeight = 130.0
        self.ideasTabelView.rowHeight = UITableView.automaticDimension
        self.ideasTabelView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.reloadTableView()
    }
    
    /// reload tableview
    private func reloadTableView() {
        self.ideasTabelView.reloadData()
    }
}

// MARK: - Delegate & DataSource
extension IdeasViewController: UITableViewDelegate, UITableViewDataSource {
    
    /// set tableview cell count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ideaList?.idea.count ?? 0
    }
    
    /// configure cell display values
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier:
            "IdeasTableViewCell") as? IdeasTableViewCell {
            
            let ideas = self.ideaList?.idea[indexPath.row]
            if let ideas = ideas {
                /// update cell values from idea list
                cell.setupCell(ideas)
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
    /// tableview cell onclick event
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ideas = self.ideaList?.idea[indexPath.row]
        if let ideas = ideas {
            /// naviage to idea details viewcontroller
            self.router?.navigateToIdeaDetailsViewController(ideas.id!)
        }
    }
}
