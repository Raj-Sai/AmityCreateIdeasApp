//
//  ProfileModel.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 12/9/2563 BE.
//  Copyright (c) 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit

struct ProfileModel
{
    struct Request
    {
        var userName: String
    }
    struct Response
    {
        /// user data model
        struct Data: Codable {
            var data: UserProfile?
        }
    }
    
    /// using Codable get user details from json
    struct UserProfile: Codable {
        var user_name: String?
        var email: String?
        var ideas: [Ideas]?
    }
    
    struct Ideas: Codable {
        var idea_image_url: String?
        var idea_title: String?
        var idea_category: String?
        var created_time_stamp: String?
        var id: String?
        var updated_time_stamp: String?
        var user_name: String?
        var idea_likes: [IdeaLikes]?
        var idea_comments: [IdeaComments]?
    }
    
    struct IdeaLikes: Codable {
        var like_by: String?
        var like_timestamp: String?
    }
    
    struct IdeaComments: Codable {
        var comment_by: String?
        var comment: String?
    }
    
    struct ViewModel
    {
    }
}
