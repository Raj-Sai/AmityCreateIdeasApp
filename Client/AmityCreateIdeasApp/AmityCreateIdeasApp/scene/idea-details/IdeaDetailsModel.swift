//
//  IdeaDetailsModel.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 13/9/2563 BE.
//  Copyright (c) 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit

struct IdeaDetailsModel
{
    struct Request
    {
        var id: String
    }
    struct CommentRequest {
        var id: String
        var comment: String
        var comment_by: String
    }
    struct LikeRequest {
        var id: String
        var vote: String
        var vote_by: String
    }
    struct Response
    {
    }
    struct ViewModel
    {
    }
}
