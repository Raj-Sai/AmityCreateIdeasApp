//
//  LoginWorker.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 12/9/2563 BE.
//  Copyright (c) 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol LoginWorkerInterface {
    func verifyUser(resquest: LoginModel.Request, completion: @escaping (JSON) -> Void, fail: @escaping (_ httpStatus:Int?, _ errorCode: String?) -> ())
}

class LoginWorker: LoginWorkerInterface
{
    var service: LoginService!
    
    init(with aService: LoginService) {
        service = aService
    }
    
    func verifyUser(resquest: LoginModel.Request, completion: @escaping (JSON) -> Void, fail: @escaping (_ httpStatus:Int?, _ errorCode: String?) -> ()) {
        service.verifyUser(resquest: resquest, completion: { (json) in
            completion(json)
        }) { (code, message) in
            fail(code, message)
        }
        
    }
}
