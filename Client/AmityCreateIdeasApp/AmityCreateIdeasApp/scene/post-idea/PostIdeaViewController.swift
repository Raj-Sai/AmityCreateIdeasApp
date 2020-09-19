//
//  PostIdeaViewController.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 12/9/2563 BE.
//  Copyright (c) 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit
import Photos


protocol PostIdeaView: class
{
    func displayStartLoading()
    func displayStopLoading()
    func displayPostNewIdeaSuccess()
    func dispalyBottomErrorAlert(withMessage message: String)
    func dispalyNoInternetErrorAlert()
}

class PostIdeaViewController: BaseViewController {
    
    /// object for delegates
    var interactor: PostIdeaInteractorDelegate?
    var router:  PostIdeaRouterDelegate?
    
    /// conected outlet from storyboard
    @IBOutlet weak var ideaTitleTextView: UITextView!
    @IBOutlet weak var selectIdeaCategoryDropDownView: UITextField!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var ideaImageView: UIImageView!
    @IBOutlet weak var postIdeaButton: UIButton!
    
    /// global variables
    var ideaCategories = ["Android Dev", "Blockchain", "Data Science", "iOS Dev", "Machine Learning", "Math", "Programming", "Software Engineering", "Technology", "UX", "Visual Design", "Others"]
    var selectedIdeaCategory: String?
    let ideaCategoryPickerView = UIPickerView()
    var imagePicker: ImagePicker!
    var imageUrl: URL?
    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewDidLoad() {
        self.setupView()
        self.addNavBarCloseButton()
        self.addDoneButtonOnKeyboard()
        self.setupHideKeyboardOnTap()
        self.createPickerView()
        self.dismissPickerView()
        self.checkPermissions()
    }

}

//MARK: - PostIdeaView Delegates
extension PostIdeaViewController: PostIdeaView {
    
    /// disply spinner while call api
    func displayStartLoading() {
        if let view = self.view {
            self.showSpinnerAnimation(onView: view)
        }
    }
    
    /// remove spinner after finish api call
    func displayStopLoading() {
        self.removeSpinner()
    }
    
    /// after post success close the post model
    func displayPostNewIdeaSuccess() {
        self.dismiss(animated: true, completion: nil)
    }
    
    /// show error dialog for empty input box
    func dispalyBottomErrorAlert(withMessage message: String) {
        let actionSheet = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)

        let okAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            print("didPress cancel")
        }
        actionSheet.addAction(okAction)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func dispalyNoInternetErrorAlert() {
        self.dispalyCommonNoInternetAlert()
    }
}

//MARK: - PostIdeaViewController extension
extension PostIdeaViewController {
    
    /// setup dependencies
    private func setUp() {
        let viewController = self
        let interactor = PostIdeaInteractor()
        let presenter = PostIdeaPresenter()
        let router = PostIdeaRouter()
        router.viewController = viewController
        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
    }
    
    /// setup post view
    func setupView() {
        self.title = "Post"
        ideaTitleTextView.delegate = self
        ideaTitleTextView.text = "Enter title here"
        ideaTitleTextView.textColor = UIColor.lightGray
        selectedIdeaCategory = ideaCategories[0]
        selectIdeaCategoryDropDownView.rightViewMode = UITextField.ViewMode.always
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: "dropDown")
        imageView.image = image
        selectIdeaCategoryDropDownView.rightView = imageView
        selectIdeaCategoryDropDownView.placeholder = "Select Category"
        
        postIdeaButton.addTarget(self, action: #selector(self.postIdeaButtonAction), for: .touchUpInside)
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        ideaImageView.addGestureRecognizer(tapGR)
        ideaImageView.isUserInteractionEnabled = true
        
    }
    
    /// add model close button in nav bar
    public func addNavBarCloseButton() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_close", in: nil, compatibleWith: nil), style: .plain, target: self, action: #selector(self.closeButtonClicked))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0)
    }
    
    /// close post model
    @objc func closeButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    /// check permission for camera and photo library
    func checkPermissions() {
        if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized {
            PHPhotoLibrary.requestAuthorization({ (status: PHAuthorizationStatus) -> Void in
                () })
        }
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
        } else {
            PHPhotoLibrary.requestAuthorization(requestAuthroizationHandler)
        }
    }
    
    func requestAuthroizationHandler(status: PHAuthorizationStatus) {
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
            print("We have access to photos")
        } else {
            print("We dont have access to photos")
        }
    }
    
    /// post new ideas
    @objc func postIdeaButtonAction() {
        let title = ideaTitleTextView.text
        let category = selectedIdeaCategory
        let des = descriptionTextView.text
        var image_url = ""
        if let image = self.imageUrl {
            image_url = "\(image)"
        }
        let requestModel = PostIdeaModel.Request(
            user_name:  UserDefaults.standard.string(forKey: "userName"),
            idea_des: des, idea_title: title, id: String(Int.random(in: 1...10000)),
            idea_image_url: image_url, idea_category: category)
        if let interactor = interactor {
            interactor.postNewIdeas(model: requestModel)
        }
    }
    
    /// handle keyboard events show and hide
       @objc func keyboard(notification: Notification) {
           self.commonKeyboard(notification, scrollview: scrollview)
       }
    
    /// add done button on keyboard
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        ideaTitleTextView.inputAccessoryView = doneToolbar
    }
    
    /// keybard done button action
    @objc func doneButtonAction(){
        ideaTitleTextView.resignFirstResponder()
    }
    
    /// add idea images 
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.imagePicker.present(from: self.view)
        }
    }
}

//MARK: - TextView Delegate
extension PostIdeaViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if ideaTitleTextView.textColor == UIColor.lightGray {
            ideaTitleTextView.text = ""
            ideaTitleTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if ideaTitleTextView.text == "" {
            ideaTitleTextView.text = "Enter title here"
            ideaTitleTextView.textColor = UIColor.lightGray
        }
    }
}

//MARK: - PickerView Delegate & DataSource
extension PostIdeaViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    /// create dropdown picker view
    func createPickerView() {
        ideaCategoryPickerView.delegate = self
        selectIdeaCategoryDropDownView.inputView = ideaCategoryPickerView
    }
    
    /// add close button for picker view
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.pickerDoneButtonAction))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        selectIdeaCategoryDropDownView.inputAccessoryView = toolBar
    }
    
    /// picker view done button action
    @objc func pickerDoneButtonAction() {
        selectIdeaCategoryDropDownView.text = selectedIdeaCategory
        view.endEditing(true)
    }
    
    /// number of components in pickerview
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ideaCategories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ideaCategories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIdeaCategory = ideaCategories[row]
    }
    
}

//MARK: - ImagePicker Delegate
extension PostIdeaViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?, imageUrl: URL?) {
        self.ideaImageView.image = image
        self.imageUrl = imageUrl
    }
}


