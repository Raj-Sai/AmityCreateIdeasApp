//
//  IdeasWorker.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 12/9/2563 BE.
//  Copyright (c) 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol IdeasWorkerInterface {
    func getIdeas(resquest: IdeasModel.Request, completion: @escaping (JSON) -> Void, fail: @escaping (_ httpStatus:Int?, _ errorCode: String?) -> ())
}


class IdeasWorker: IdeasWorkerInterface
{
   var service: IdeasService!
      
      init(with aService: IdeasService) {
          service = aService
      }
      
      func getIdeas(resquest: IdeasModel.Request, completion: @escaping (JSON) -> Void, fail: @escaping (_ httpStatus:Int?, _ errorCode: String?) -> ()) {
          service.getIdeas(resquest: resquest, completion: { (json) in
              completion(json)
          }) { (code, message) in
              fail(code, message)
          }
          
      }
}
