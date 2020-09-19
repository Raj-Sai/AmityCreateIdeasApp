//
//  PostIdeaWorker.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 12/9/2563 BE.
//  Copyright (c) 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit
import SwiftyJSON

class PostIdeaWorker {
    
    var service: PostIdeaService!
    
    init(with aService: PostIdeaService) {
        service = aService
    }
    
    func postNewIdeas(resquest: PostIdeaModel.Request, completion: @escaping (JSON) -> Void, fail: @escaping (Int?, String?) -> ()) {
        service.postNewIdeas(request: resquest, completion: { (json) in
            completion(json)
        }) { (code, message) in
            fail(code, message)
        }
    }
}
