//
//  IdeaDetailsService.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 16/9/2563 BE.
//  Copyright © 2563 Amsaraj Mariyappan. All rights reserved.
//

import SwiftyJSON

class IdeaDetailsService {

    /*
    *if fail, return error code
    *if success, transform to models (raw)
    */
 
    // MARK: - Calling API Manager
    
    func getIdeaDetails(resquest: IdeaDetailsModel.Request, completion: @escaping (JSON) -> Void, fail: @escaping (_ httpStatus:Int?, _ errorCode: String?) -> ()) {
        let params: [String: AnyObject] = [:]
    
        ApiManager.sharedInstance.request(aParameters: params, endPoint: "ideas/\(resquest.id)", method: .get, success: { (json) in
            completion(json)
        }) { (httpStatus, errorCode) in
            fail(httpStatus, errorCode)
        }
    }
    
    func putIdeaComments(resquest: IdeaDetailsModel.CommentRequest, completion: @escaping (JSON) -> Void, fail: @escaping (_ httpStatus:Int?, _ errorCode: String?) -> ()) {
        let params: [String: AnyObject] = [
            "comment": resquest.comment as AnyObject,
            "comment_by": resquest.comment_by as AnyObject
        ]
        ApiManager.sharedInstance.request(aParameters: params, endPoint: "ideas/\(resquest.id)/comment", method: .put, success: { (json) in
            completion(json)
        }) { (httpStatus, errorCode) in
            fail(httpStatus, errorCode)
        }
    }
    
    func putIdeaLikes(resquest: IdeaDetailsModel.LikeRequest, completion: @escaping (JSON) -> Void, fail: @escaping (_ httpStatus:Int?, _ errorCode: String?) -> ()) {
        let params: [String: AnyObject] = [
            "vote": resquest.vote as AnyObject,
            "vote_by": resquest.vote_by as AnyObject
        ]
    
        ApiManager.sharedInstance.request(aParameters: params, endPoint: "ideas/\(resquest.id)/like", method: .put, success: { (json) in
            completion(json)
        }) { (httpStatus, errorCode) in
            fail(httpStatus, errorCode)
        }
    }
}
