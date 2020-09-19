//
//  ProfileWorker.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 12/9/2563 BE.
//  Copyright (c) 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProfileWorker
{
    var service: ProfileService!
    
    init(with aService: ProfileService) {
        service = aService
    }
    
    func getUserIdeas(request: ProfileModel.Request, completion: @escaping (JSON) -> Void, fail: @escaping (_ httpStatus:Int?, _ errorCode: String?) -> ()) {
        service.getUserIdeas(request: request, completion: { (json) in
            completion(json)
        }) { (code, message) in
            fail(code, message)
        }
    }
}
