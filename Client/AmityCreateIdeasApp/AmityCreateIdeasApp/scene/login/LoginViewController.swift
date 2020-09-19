//
//  LoginViewController.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 12/9/2563 BE.
//  Copyright (c) 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit

protocol LoginView: class
{
    func startLoading()
    func stopLoading()
    func displayLoginSuccess()
    func displayUserValidationFailError(errorType: LoginModel.ErrorType)
    func dispalyBottomErrorAlert(withMessage message: String)
    func dispalyNoInternetErrorAlert()
}

class LoginViewController: BaseViewController {
    
    /// object for delegates
    var interactor: LoginInteractorDelegate?
    var router:  LoginRouterDelegate?
    
    /// conected outlet from storyboard
    @IBOutlet weak var loginTitleLabel: UILabel!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var userNameErrorMessage: UILabel!
    @IBOutlet weak var passcodeErrorMessage: UILabel!
    
    /// initial set up for design pattern
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setUp()
    }
    
    //MARK: - Life cycle methods
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        
    }
    override func viewDidLoad() {
        self.navigationItem.hidesBackButton = true
        self.setUpView()
        self.setupHideKeyboardOnTap()
        self.userNameErrorMessage.isHidden = true
        self.passcodeErrorMessage.isHidden = true
    }
}

//MARK: - LoginView Delegate
extension LoginViewController: LoginView {
    
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
    /// after login success naviagte to ideas controller
    func displayLoginSuccess() {
        UserDefaults.standard.set(true, forKey: HAS_SIGN_IN)
        router?.naviagteToIdeasViewController()
        self.router?.naviagteToIdeasViewController()
    }
    /// after login fail show error
    func displayUserValidationFailError(errorType: LoginModel.ErrorType) {
        self.userNameField.text = ""
        self.passwordField.text = ""
        self.userNameField.layer.borderColor = UIColor.yellow.cgColor
        self.passwordField.layer.borderColor = UIColor.yellow.cgColor
        switch errorType {
        case .userNotExist:
            self.userNameErrorMessage.isHidden = false
            self.userNameErrorMessage.text = "user name not found"
        case .incorectPasscode:
            self.passcodeErrorMessage.isHidden = false
            self.passcodeErrorMessage.text = "invalid passcode"
        default:
            print("")
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
    
    func dispalyNoInternetErrorAlert() {
        self.dispalyCommonNoInternetAlert()
    }
}

//MARK: - LoginViewController extension
extension LoginViewController {
    
    /// setup dependencies
    private func setUp() {
        let viewController = self
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        router.viewController = viewController
        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
    }
    
    /// setup view
    private func setUpView() {
        loginButton.addTarget(self, action: #selector(self.loginButtonAction),
                              for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(self.signupButtonAction),
                               for: .touchUpInside)
        userNameField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    /// login button action
    @objc func loginButtonAction() {
        if let userName = userNameField.text, let passwoard = passwordField.text {
            self.interactor?.login(userName: userName, password: passwoard)
        }
    }
    
    /// text field change
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.userNameErrorMessage.isHidden = true
        self.passcodeErrorMessage.isHidden = true
    }
    
    /// signup button action
    @objc func signupButtonAction() {
        router?.navaigateToSignUpViewController()
    }
    
   /// handle keyboard events show and hide
    @objc func keyboard(notification: Notification) {
        self.commonKeyboard(notification, scrollview: scrollview)
    }
}
