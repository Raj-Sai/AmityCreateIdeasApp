//
//  PostIdeaService.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 17/9/2563 BE.
//  Copyright © 2563 Amsaraj Mariyappan. All rights reserved.
//

import Foundation
import SwiftyJSON
import FirebaseStorage

class PostIdeaService {

    /*
    *if fail, return error code
    *if success, transform to models (raw)
    */
 
    // MARK: - Calling API Manager
    /// post new ideas
    func postNewIdeas(request: PostIdeaModel.Request, completion: @escaping (JSON) -> Void, fail: @escaping (_ httpStatus:Int?, _ errorCode: String?) -> ()) {
        var imageName = ""
        if let image = request.idea_image_url {
            imageName = "ideaimage_\(Date())"
            if let url = URL(string: image) {
                uploadToCloud(fileURL: url, imageName: imageName)
            }
        }
        let params: [String: AnyObject] = [
            "user_name": request.user_name as AnyObject,
            "id": request.id as AnyObject,
            "idea_des": request.idea_des as AnyObject,
            "idea_title": request.idea_title as AnyObject,
            "idea_image_url": imageName as AnyObject,
            "idea_category": request.idea_category as AnyObject
        ]
        
        ApiManager.sharedInstance.request(aParameters: params, endPoint: "ideas", method: .post, success: { (json) in
            completion(json)
        }) { (httpStatus, errorCode) in
            fail(httpStatus, errorCode)
        }
    }
    
    /// post new ideas images to firebase storage
    func uploadToCloud(fileURL : URL, imageName: String) {
        let storage = Storage.storage()
        
        _ = Data()
        let storageRef = storage.reference()
        
        let localFule = fileURL
        
        let photoRef = storageRef.child(imageName)
        
        let _ = photoRef.putFile(from: localFule, metadata: nil) { (metadata, err) in
            guard let _ = metadata else {
                print(err?.localizedDescription as Any)
                return
            }
            print("Photo Upload")
        }
    }
}
