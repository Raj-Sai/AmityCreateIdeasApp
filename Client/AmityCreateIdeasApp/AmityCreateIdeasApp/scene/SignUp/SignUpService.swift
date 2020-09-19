//
//  SignUpService.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 15/9/2563 BE.
//  Copyright © 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit
import SwiftyJSON

class SignUpService {

    /*
    *if fail, return error code
    *if success, transform to models (raw)
    */
 
    // MARK: - Calling API Manager
    
    func userSignUp(resquest: SignUpModel.Request, completion: @escaping (JSON) -> Void, fail: @escaping (_ httpStatus:Int?, _ errorCode: String?) -> ()) {
        let params: [String: AnyObject] = [
            "user_name": resquest.userName as AnyObject,
            "email" : resquest.email as AnyObject,
            "phone_number": resquest.phoneNumber as AnyObject,
            "password": resquest.password as AnyObject,
            "id": String(Int.random(in: 0...100000)) as AnyObject
        ]

        ApiManager.sharedInstance.request(aParameters: params, endPoint: "info/", success: { (json) in
            completion(json)
        }) { (httpStatus, errorCode) in
            fail(httpStatus, errorCode)
        }
    }
}
