//
//  PostIdeaModel.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 12/9/2563 BE.
//  Copyright (c) 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit

struct PostIdeaModel
{
    /// idea post request model
    struct Request
    {
        var user_name: String?
        var idea_des: String?
        var idea_title: String?
        var id: String?
        var idea_image_url: String?
        var idea_category: String?
    }
    struct Response
    {
    }
}
