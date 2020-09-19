//
//  SignUpViewController.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 12/9/2563 BE.
//  Copyright (c) 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit

protocol SignUpView: class
{
    func startLoading()
    func stopLoading()
    func displaySignUpSuccess()
    func dispalyBottomErrorAlert(withMessage message: String)
    func dispalyNoInternetErrorAlert()
}

class SignUpViewController: BaseViewController {
    
    /// object for delegates
    var interactor: SignUpInteractorDelegate?
    var router:  SignUpRouterDelegate?
    
    /// conected outlet from storyboard
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var scrollview: UIScrollView!
    
    /// initial set up for design pattern
    required init?(coder aDecoder: NSCoder)
    {
      super.init(coder: aDecoder)
      setUp()
    }
    
    //MARK: - Life cycle methods
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    override func viewDidLoad() {
        self.setUpView()
        setupHideKeyboardOnTap()
    }
}

//MARK: - SignUpView Delegate
extension SignUpViewController: SignUpView {
    
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
    /// after post success naviagte to ideas controller
    func displaySignUpSuccess() {
        if let router = router {
            router.navigateToIdeasViewController()
        }
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
    
    /// show connection alert
    func dispalyNoInternetErrorAlert() {
        self.dispalyCommonNoInternetAlert()
    }
}

//MARK: - SignUpViewController extension
extension SignUpViewController {
    
    /// setup dependencies
    private func setUp() {
        let viewController = self
        let interactor = SignUpInteractor()
        let presenter = SignUpPresenter()
        let router = SignUpRouter()
        router.viewController = viewController
        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
    }
    
    /// setup button
    private func setUpView() {
        signUpButton.addTarget(self, action: #selector(self.signupButtonAction),
                               for: .touchUpInside)
    }
    
    /// signup button action
    @objc func signupButtonAction() {
        let userName = userNameField.text
        let email = emailField.text
        let phoneNumber = phoneNumberField.text
        let password = passwordField.text
        let confirmPasscode = confirmPasswordField.text
        let signUpModel = SignUpModel.Request(userName: userName, password: password, email: email, phoneNumber: phoneNumber, confirmPassword: confirmPasscode)
        if let interactor = interactor {
            interactor.userSignUp(requestModel: signUpModel)
        }
    }
    
    /// handle keyboard events show and hide
    @objc func keyboard(notification: Notification) {
        self.commonKeyboard(notification, scrollview: scrollview)
    }
}
