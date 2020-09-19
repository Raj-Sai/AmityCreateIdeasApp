//
//  IdeaDetailsWorker.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 13/9/2563 BE.
//  Copyright (c) 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit
import SwiftyJSON

class IdeaDetailsWorker
{
   var service: IdeaDetailsService!
      
      init(with aService: IdeaDetailsService) {
          service = aService
      }
      
      func getIdeaDetails(resquest: IdeaDetailsModel.Request, completion: @escaping (JSON) -> Void, fail: @escaping (_ httpStatus:Int?, _ errorCode: String?) -> ()) {
          service.getIdeaDetails(resquest: resquest, completion: { (json) in
              completion(json)
          }) { (code, message) in
              fail(code, message)
          }
          
      }
    
    func putIdeaComments(resquest: IdeaDetailsModel.CommentRequest, completion: @escaping (JSON) -> Void, fail: @escaping (_ httpStatus:Int?, _ errorCode: String?) -> ()) {
        service.putIdeaComments(resquest: resquest, completion: { (json) in
            completion(json)
        }) { (code, message) in
            fail(code, message)
        }
        
    }
    
    func putIdeaLikes(resquest: IdeaDetailsModel.LikeRequest, completion: @escaping (JSON) -> Void, fail: @escaping (_ httpStatus:Int?, _ errorCode: String?) -> ()) {
        service.putIdeaLikes(resquest: resquest, completion: { (json) in
            completion(json)
        }) { (code, message) in
            fail(code, message)
        }
        
    }
}
