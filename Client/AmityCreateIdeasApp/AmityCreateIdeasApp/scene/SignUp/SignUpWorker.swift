//
//  SignUpWorker.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 12/9/2563 BE.
//  Copyright (c) 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol SignUpWorkerInterface {
    func userSignUp(resquest: SignUpModel.Request, completion: @escaping (JSON) -> Void, fail: @escaping (_ httpStatus:Int?, _ errorCode: String?) -> ())
}

class SignUpWorker: SignUpWorkerInterface
{
    var service: SignUpService!
    
    init(with aService: SignUpService) {
        service = aService
    }
    
    func userSignUp(resquest: SignUpModel.Request, completion: @escaping (JSON) -> Void, fail: @escaping (_ httpStatus:Int?, _ errorCode: String?) -> ()) {
        service.userSignUp(resquest: resquest, completion: { (json) in
            completion(json)
        }) { (code, message) in
            fail(code, message)
        }
        
    }
    
    
    
}
