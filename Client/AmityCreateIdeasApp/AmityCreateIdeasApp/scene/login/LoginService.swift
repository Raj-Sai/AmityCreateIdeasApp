//
//  LoginService.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 15/9/2563 BE.
//  Copyright © 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginService {

    /*
    *if fail, return error code
    *if success, transform to models (raw)
    */
 
    // MARK: - Calling API Manager
    
    func verifyUser(resquest: LoginModel.Request, completion: @escaping (JSON) -> Void, fail: @escaping (_ httpStatus:Int?, _ errorCode: String?) -> ()) {
        let params: [String: AnyObject] = [
            "user_name": resquest.userName as AnyObject,
            "password" : resquest.password as AnyObject
        ]
        ApiManager.sharedInstance.request(aParameters: params, endPoint: "login/", success: { (json) in
            completion(json)
        }) { (httpStatus, errorCode) in
            fail(httpStatus, errorCode)
        }
    }
}
