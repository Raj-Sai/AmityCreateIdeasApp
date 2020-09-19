//
//  LoginModel.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 12/9/2563 BE.
//  Copyright (c) 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit

struct LoginModel
{
    struct Request
    {
        var userName: String!
        var password: String!
    }
    struct Response
    {
    }
    struct ViewModel
    {
    }
    enum ErrorType: String {
        case userNotExist, incorectPasscode, generalError
    }
}
