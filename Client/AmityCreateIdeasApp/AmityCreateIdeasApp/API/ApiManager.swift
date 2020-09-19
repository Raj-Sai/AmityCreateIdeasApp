//
//  ApiManager.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 15/9/2563 BE.
//  Copyright © 2563 Amsaraj Mariyappan. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class ApiManager: NSObject {
    static let sharedInstance = ApiManager()
    
    func request(aParameters: [String : AnyObject], endPoint: String, method: HTTPMethod = .post, success:@escaping (JSON) -> Void, failure:@escaping (_ httpStatus:Int?, _ errorCode: String?) -> Void) {
        let strURL = "https://us-central1-ideas-demo-api.cloudfunctions.net/user/" + endPoint
        print(strURL)
        
        let isInternetConnected = NetworkReachabilityManager()!.isReachable
        if isInternetConnected {
            AF.request(strURL, method: method, parameters: aParameters.isEmpty ? nil : aParameters, encoding: JSONEncoding.default, headers: nil).responseJSON {
                responseJson in
                print(responseJson.result)
                switch responseJson.result {
                case .success(let value):
                    if (responseJson.response?.statusCode == 200 || responseJson.response?.statusCode == 201) {
                        let swiftyJsonVar = JSON(value)
                        success(swiftyJsonVar)
                    } else {
                        let json: JSON = JSON(value)
                        let errorCode: String? = json["code"].stringValue
                        failure(responseJson.response?.statusCode, errorCode)
                    }
                case .failure(let error):
                    print("fail", error)
                    
                }
            }
        } else {
            failure(400, "no_internet_connection")
        }
        
    }
    
}
