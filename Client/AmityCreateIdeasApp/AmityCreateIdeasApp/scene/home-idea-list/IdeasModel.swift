//
//  IdeasModel.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 12/9/2563 BE.
//  Copyright (c) 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit
import SwiftyJSON

struct IdeasModel
{
    /// request model
    struct Request
    {
    }
    
    /// response model
    struct Response
    {
        /// idea list model
        struct Ideas {
            var idea: [Idea] = []
            init(json: JSON) {
                let data = json["data"].arrayValue
                for ideas in data {
                    self.idea.append(Idea(json: ideas))
                }
            }
        }
        /// here used normal way of JSON to object in Profile model used Codable for JSON to Object
        /// specific idea model
        struct Idea {
            var id: String?
            var idea_likes: [IdeaLikes] = []
            var idea_comments: [IdeaComments] = []
            var user_name: String?
            var created_time_stamp: String?
            var idea_des: String?
            var idea_image_url: String?
            var idea_title: String?
            var idea_category: String?
            
            init(json: JSON) {
                self.id = json["id"].stringValue
                let ideaLikes = json["idea_likes"].arrayValue
                let ideaComments = json["idea_comments"].arrayValue
                self.user_name = json["user_name"].stringValue
                self.created_time_stamp = json["created_time_stamp"].stringValue
                self.idea_des = json["idea_des"].stringValue
                self.idea_image_url = json["idea_image_url"].stringValue
                self.idea_title = json["idea_title"].stringValue
                self.idea_category = json["idea_category"].stringValue
                
                for ideaLike in ideaLikes {
                    self.idea_likes.append(IdeaLikes(json: ideaLike))
                }
                
                for ideaComment in ideaComments {
                    self.idea_comments.append(IdeaComments(json: ideaComment))
                }
            }
        }
        
        /// specific idea likes model
        struct IdeaLikes {
            var like_by: String?
            var like_timestamp: String?
            
            init(json: JSON) {
                self.like_by = json["like_by"].stringValue
                self.like_timestamp = json["like_timestamp"].stringValue
            }
        }
        /// specific idea comments model
        struct IdeaComments {
            var comment: String?
            var comment_timestamp: String?
            var comment_by: String?
            
            init(json: JSON) {
                self.comment = json["comment"].stringValue
                self.comment_timestamp = json["comment_timestamp"].stringValue
                self.comment_by = json["comment_by"].stringValue
            }
        }
    }
}
