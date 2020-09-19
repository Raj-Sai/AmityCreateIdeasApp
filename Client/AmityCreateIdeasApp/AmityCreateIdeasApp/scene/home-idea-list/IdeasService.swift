//
//  IdeasService.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 16/9/2563 BE.
//  Copyright © 2563 Amsaraj Mariyappan. All rights reserved.
//

import SwiftyJSON

class IdeasService {

    /*
    *if fail, return error code
    *if success, transform to models (raw)
    */
 
    // MARK: - Calling API Manager
    
    func getIdeas(resquest: IdeasModel.Request, completion: @escaping (JSON) -> Void, fail: @escaping (_ httpStatus:Int?, _ errorCode: String?) -> ()) {
        let params: [String: AnyObject] = [:]
    
        ApiManager.sharedInstance.request(aParameters: params, endPoint: "ideas", method: .get, success: { (json) in
            completion(json)
        }) { (httpStatus, errorCode) in
            fail(httpStatus, errorCode)
        }
    }
}
