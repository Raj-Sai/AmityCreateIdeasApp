//
//  SignUpModel.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 12/9/2563 BE.
//  Copyright (c) 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit

struct SignUpModel
{
    struct Request
    {
        var userName: String!
        var password: String!
        var email: String!
        var phoneNumber: String!
        var confirmPassword: String!
    }
    struct Response
    {
    }
    struct ViewModel
    {
    }
    enum ErrorType {
        case userAlreadyExist, generalError
    }
}
