//
//  IdeaDetailsInteractor.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 13/9/2563 BE.
//  Copyright (c) 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit

protocol IdeaDetailsInteractorDelegate
{
    func getIdeaDetails(selectedIdeaID: String)
    func putIdeaComments(selectedIdeaID: String, comment: String)
    func putIdeaLikes(selectedIdeaID: String)
    func selectedSegmentIndex(index: Int)
}


class IdeaDetailsInteractor: IdeaDetailsInteractorDelegate
{
    var presenter: IdeaDetailsPresenterDelegate!
    var worker = IdeaDetailsWorker(with: IdeaDetailsService())
    
    /// get specific idea details
    func getIdeaDetails(selectedIdeaID: String) {
        let request = IdeaDetailsModel.Request(id: selectedIdeaID)
        presenter.presentStartLoading()
        worker.getIdeaDetails(resquest: request, completion: { [weak self] (json) in
            // success
            if let selfObj = self {
                selfObj.presenter.presentStopLoading()
                selfObj.presenter.presentIdeaDetails(ideaDetailsJSON: json)
            }
        }) {[weak self] (httpStatus, errorCode) in
            // fail
            if let selfObj = self {
                selfObj.presenter.presentStopLoading()
                if errorCode == "no_internet_connection" {
                    selfObj.presenter.presentNoInternetAlert()
                }
            }
        }
    }
    
    /// add comments
    func putIdeaComments(selectedIdeaID: String, comment: String) {
        let request = IdeaDetailsModel.CommentRequest(id: selectedIdeaID, comment: comment, comment_by: UserDefaults.standard.string(forKey: "userName") ?? "")
        presenter.presentStartLoading()
        worker.putIdeaComments(resquest: request, completion: { [weak self] (json) in
            // success
            if let selfObj = self {
                selfObj.presenter.presentStopLoading()
                selfObj.getIdeaDetails(selectedIdeaID: selectedIdeaID)
            }
        }) {[weak self] (httpStatus, errorCode) in
            // fail
            if let selfObj = self {
                selfObj.presenter.presentStopLoading()
                if errorCode == "no_internet_connection" {
                    selfObj.presenter.presentNoInternetAlert()
                }
            }
        }
    }
    
    /// add likes
    func putIdeaLikes(selectedIdeaID: String) {
        let request = IdeaDetailsModel.LikeRequest(id: selectedIdeaID, vote: "01", vote_by: UserDefaults.standard.string(forKey: "userName") ?? "")
        presenter.presentStartLoading()
        worker.putIdeaLikes(resquest: request, completion: { [weak self] (json) in
            // success
            if let selfObj = self {
                selfObj.presenter.presentStopLoading()
                selfObj.getIdeaDetails(selectedIdeaID: selectedIdeaID)
            }
        }) {[weak self] (httpStatus, errorCode) in
            // fail
            if let selfObj = self {
                selfObj.presenter.presentStopLoading()
                if errorCode == "no_internet_connection" {
                    selfObj.presenter.presentNoInternetAlert()
                }
            }
        }
    }
    
    /// update selected segment string
    func selectedSegmentIndex(index: Int) {
        if let presenterObj = presenter {
            switch index {
            case 0:
                presenterObj.presentTableViewBasedOnSegment(selectedSegment: COMMENTS)
            case 1:
                presenterObj.presentTableViewBasedOnSegment(selectedSegment: LIKES)
            default:
                return
            }
        }
    }
}
