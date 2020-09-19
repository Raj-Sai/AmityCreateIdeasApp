//
//  ProfileService.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 19/9/2563 BE.
//  Copyright © 2563 Amsaraj Mariyappan. All rights reserved.
//

import SwiftyJSON

class ProfileService {

    /*
    *if fail, return error code
    *if success, transform to models (raw)
    */
 
    // MARK: - Calling API Manager
    
    func getUserIdeas(request: ProfileModel.Request, completion: @escaping (JSON) -> Void, fail: @escaping (_ httpStatus:Int?, _ errorCode: String?) -> ()) {
        let params: [String: AnyObject] = [:]
    
        ApiManager.sharedInstance.request(aParameters: params, endPoint: "info/\(request.userName)/ideas", method: .get, success: { (json) in
            completion(json)
        }) { (httpStatus, errorCode) in
            fail(httpStatus, errorCode)
        }
    }
}

