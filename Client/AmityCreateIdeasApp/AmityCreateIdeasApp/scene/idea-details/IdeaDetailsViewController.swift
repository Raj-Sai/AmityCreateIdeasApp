//
//  IdeaDetailsViewController.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 13/9/2563 BE.
//  Copyright (c) 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit
import Photos
import FirebaseStorage
import Firebase
import FirebaseUI

protocol IdeaDetailsView: class
{
    func startLoading()
    func stopLoading()
    func displayIdeaDetils(model: IdeasModel.Response.Idea)
    func displayTableViewBasedOnSegmentSelection(segment: String)
    func dispalyNoInternetErrorAlert()
}

class IdeaDetailsViewController: BaseViewController {
    
    /// object for delegates
    var interactor: IdeaDetailsInteractorDelegate?
    var router:  IdeaDetailsRouterDelegate?
    
    /// conected outlet from storyboard
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ideaImageView: UIImageView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var addCommentField: UITextView!
    @IBOutlet weak var commentAndLikesTableView: UITableView!
    @IBOutlet weak var ideaDetailsScrollView: UIScrollView!
    @IBOutlet weak var addCommentFieldConstraint: NSLayoutConstraint!
    @IBOutlet weak var tabelViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var likeView: UIView!
    
    /// global variables
    var selectedIdea: String?
    var selectedSegment: String = COMMENTS
    var initial = UILabel()
    var navTitle = UILabel()
    var likeList: [IdeasModel.Response.IdeaLikes] = []
    var commentList: [IdeasModel.Response.IdeaComments] = []
    
    /// initial set up for design pattern
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setUp()
    }
    
    //MARK: - Life cycle methods
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        NotificationCenter.default.addObserver(self, selector: #selector(keyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    override func viewDidLoad() {
        self.setupView()
        self.setUpTableView()
        self.setupNavbar()
        if let id = selectedIdea {
            /// get idea details
            self.interactor?.getIdeaDetails(selectedIdeaID: id)
        }
    }
    
    @IBAction func indexChanged(_ sender: Any) {
        if let interatorObj = interactor {
            interatorObj.selectedSegmentIndex(index: segmentControl.selectedSegmentIndex)
        }
    }
}

//MARK: - IdeaDetailsView Delegate
extension IdeaDetailsViewController: IdeaDetailsView {
    
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
    
    /// display idea details
    func displayIdeaDetils(model: IdeasModel.Response.Idea) {
        initial.text = model.user_name?.prefix(2).uppercased()
        navTitle.text = model.user_name
        titleLabel.text = model.idea_title
        categoryLabel.text = model.idea_category
        descriptionLabel.text = model.idea_des
        likeList = model.idea_likes
        commentList = model.idea_comments
        /// reload like and comment table view
        reloadTableView()
        /// load idea image from fire base storage
        DispatchQueue.global(qos: .background).async {
            let storage = Storage.storage()
            let storageRef = storage.reference()
            let ref = storageRef.child(model.idea_image_url ?? "")
            DispatchQueue.main.async {
                self.ideaImageView.sd_setImage(with: ref)
            }
            
        }
    }
    
    /// reload tableview based segement selection
    func displayTableViewBasedOnSegmentSelection(segment: String) {
        self.selectedSegment = segment
        self.reloadTableView()
    }
    
    /// display internet connection alert
    func dispalyNoInternetErrorAlert() {
        self.dispalyCommonNoInternetAlert()
    }
}

//MARK: - IdeaDetailsViewController extension
extension IdeaDetailsViewController {
    /// configurator
    private func setUp() {
        let viewController = self
        let interactor = IdeaDetailsInteractor()
        let presenter = IdeaDetailsPresenter()
        let router = IdeaDetailsRouter()
        router.viewController = viewController
        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
    }
    
    /// setup view
    private func setupView() {
        setupHideKeyboardOnTap()
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.likeViewTapped))
        likeView.addGestureRecognizer(tapGR)
        likeView.isUserInteractionEnabled = true
        
        addCommentField.delegate = self
        addCommentField.text = COMMENTS_PLACE_HOLDER
        addCommentField.textColor = UIColor.lightGray
        addPostButtonOnKeyboard()
    }
    
    /// setup navigation bar
    private func setupNavbar() {
        
        let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        backView.layer.cornerRadius = 15
        backView.backgroundColor = UIColor(red: 164/255, green: 20/255, blue: 196/255, alpha: 1)
                
        initial = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        initial.textAlignment = .center
        initial.font = UIFont.boldSystemFont(ofSize: 9)
        initial.textColor = .white
        backView.addSubview(initial)
        
        navTitle = UILabel(frame: CGRect(x: 30, y: 0, width: 70, height: 30))
        navTitle.numberOfLines = 0
        navTitle.textAlignment = .center
        navTitle.font = UIFont.boldSystemFont(ofSize: 9)
        
        
        logoContainer.addSubview(backView)
        logoContainer.addSubview(navTitle)
        
        navigationItem.titleView = logoContainer
        
        let backImage = UIImage(named: "ic_close", in: nil, compatibleWith: nil)
        let buttonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(self.onPressedBackBtn))
        self.navigationItem.leftBarButtonItem = buttonItem
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0)
    }
    
    /// setup tableview
    private func setUpTableView() {
        let nib = UINib(nibName: String(describing: IdeaCommentsAndLikesTableViewCell.self), bundle: nil)
        commentAndLikesTableView.register(nib, forCellReuseIdentifier: "IdeaCommentsAndLikesTableViewCell")
        commentAndLikesTableView.estimatedRowHeight = 140
        commentAndLikesTableView.rowHeight = UITableView.automaticDimension
        self.commentAndLikesTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.reloadTableView()
    }
    
    /// reload table view and based on cell count chage tableview hegiht Constraint
    private func reloadTableView() {
        self.commentAndLikesTableView.reloadData()
        let height = self.commentAndLikesTableView.contentSize.height
        self.tabelViewHeightConstraint.constant = height;
    }
    
    /// add post button in keyboard
    private func addPostButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Post Comment", style: .done, target: self, action: #selector(self.postCommantButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        addCommentField.inputAccessoryView = doneToolbar
    }
    
    
    /// nav bar back pressed
    @objc func onPressedBackBtn() {
        /// pop to previous view controller
        if let routerObj = router {
            routerObj.naviagteToIdeasViewController()
        }
    }
    
    /// user tapped like button
    @objc func likeViewTapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            if let selectedIdea = selectedIdea, let interactor = interactor  {
                interactor.putIdeaLikes(selectedIdeaID: selectedIdea)
            }
        }
    }
    
    /// user tapped post comment button
    @objc func postCommantButtonAction() {
        addCommentField.resignFirstResponder()
        if let selectedIdea = selectedIdea,
            let userComment = addCommentField.text, !userComment.isEmpty {
            addCommentField.text = COMMENTS_PLACE_HOLDER
            interactor?.putIdeaComments(selectedIdeaID: selectedIdea, comment: userComment)
        }
    }
    
    /// handle keyboard events show and hide
    @objc func keyboard(notification: Notification) {
        self.commonKeyboard(notification, scrollview: ideaDetailsScrollView)
    }
    
}


// MARK: - Delegate & DataSource
extension IdeaDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    /// tableview count based on segement selection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedSegment == COMMENTS ? commentList.count : likeList.count
    }
    
    /// update cell details based on selected segment
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier:
            "IdeaCommentsAndLikesTableViewCell") as? IdeaCommentsAndLikesTableViewCell {
            cell.setupCell(ideaComments: commentList, ideaLikes: likeList,
                           withSelectedSegment: selectedSegment, selectedIndex: indexPath.row)
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

// MARK: - Delegate for TextView
extension IdeaDetailsViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if addCommentField.textColor == UIColor.lightGray {
            addCommentField.text = ""
            addCommentField.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if addCommentField.text == "" {
            addCommentField.text = COMMENTS_PLACE_HOLDER
            addCommentField.textColor = UIColor.lightGray
        }
    }
}


