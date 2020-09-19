//
//  PostIdeaInteractor.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 12/9/2563 BE.
//  Copyright (c) 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit

protocol PostIdeaInteractorDelegate
{
    func postNewIdeas(model: PostIdeaModel.Request)
}


class PostIdeaInteractor: PostIdeaInteractorDelegate
{
    var presenter: PostIdeaPresenterDelegate!
    var worker = PostIdeaWorker(with: PostIdeaService())
    
    /// post new ideas
    func postNewIdeas(model: PostIdeaModel.Request) {
        if validatePostField(withModel: model) {
            self.presenter.presentStartLoading()
            self.worker.postNewIdeas(resquest: model, completion: {[weak self] (responseJson) in
                /// success
                if let selfObj = self {
                    selfObj.presenter.presentStopLoading()
                    selfObj.presenter.presentPostIdeasSuccess()
                }
            }) {[weak self] (errorCode, message) in
                /// fail
                if let selfObj = self {
                    selfObj.presenter.presentStopLoading()
                    if message == "no_internet_connection" {
                        selfObj.presenter.presentNoInternetAlert()
                    } 
                }
            }
        } else {
            self.presenter.prrsentBottomErrorAlert()
        }
    }
    
    /// validate all the input fileds and image
    private func validatePostField(withModel model: PostIdeaModel.Request) -> Bool {
        if let title = model.idea_title,
            let idea_category = model.idea_category,
            let idea_des = model.idea_des,
            let idea_image = model.idea_image_url {
            
            if (title == "Enter title here" || title.isEmpty) || idea_category.isEmpty
            || idea_des.isEmpty || idea_image.isEmpty {
                return false
            }
            return true
        }
        return true
    }
}
