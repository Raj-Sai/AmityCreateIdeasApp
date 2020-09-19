//
//  IdeasInteractor.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 12/9/2563 BE.
//  Copyright (c) 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit

protocol IdeasInteractorDelegate
{
    func userLandingScreen()
    func getIdeas()
    func selectedSegment(_ index: Int, withIdeas ideas: inout IdeasModel.Response.Ideas)
}

class IdeasInteractor: IdeasInteractorDelegate
{
    var presenter: IdeasPresenterDelegate!
    var worker = IdeasWorker(with: IdeasService())
    
    /// set user landing screen based on user status
    func userLandingScreen() {
        let userHasSigIn = UserDefaults.standard.bool(forKey: HAS_SIGN_IN)
        let userViewedAppInfo = UserDefaults.standard.bool(forKey: HAS_VIEWED_APP_INFO)
        
        if userHasSigIn {
            /// user sign in already :- load ideas
            self.getIdeas()
        } else if userViewedAppInfo {
            
            /// user not viewed onboarding screens
            if let presenterObj = presenter {
                presenterObj.presentToLandLoginScreen()
            }
        } else {
            /// user not sign in
            if let presenterObj = presenter {
                presenterObj.presentToLandOnboardScreen()
            }
        }
    }
    
    /// get all ideas from firestore
    func getIdeas() {
        presenter.presentStartLoading()
        worker.getIdeas(resquest: IdeasModel.Request(), completion: { [weak self] (json) in
            // success
            if let selfObj = self {
                selfObj.presenter.presentStopLoading()
                var ideaList = IdeasModel.Response.Ideas.init(json: json)
                selfObj.ideasSortByDates(list: &ideaList)
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
    
    /// get the selected segment based on that show the ideas
    func selectedSegment(_ index: Int, withIdeas ideas: inout IdeasModel.Response.Ideas) {
        switch index {
        /// segement 1 is sort by date
        case 0:
            self.ideasSortByDates(list: &ideas)
        /// segement 2 is sort by comments
        case 1:
            self.ideasSortByComments(list: &ideas)
        /// segement 3 is sort by likes
        case 2:
            self.ideasSortByLike(list: &ideas)
        default:
            break
        }
    }
    
    /// sort the ideas by current date
    private func ideasSortByDates(list: inout IdeasModel.Response.Ideas) {
        let ideas = list.idea.sorted(by: { $0.created_time_stamp! > $1.created_time_stamp!})
        list.idea = ideas
        self.presenter.presentIdeasList(ideaListModel: list)
    }
    
    /// sort the idea list by top comments
    private func ideasSortByComments(list: inout IdeasModel.Response.Ideas) {
        let ideas = list.idea.sorted(by: { $0.idea_comments.count > $1.idea_comments.count})
        list.idea = ideas
        self.presenter.presentIdeasList(ideaListModel: list)
    }
    
    /// sort the idea list by top likes
    private func ideasSortByLike(list: inout IdeasModel.Response.Ideas) {
        let ideas = list.idea.sorted(by: { $0.idea_likes.count > $1.idea_likes.count})
        list.idea = ideas
        self.presenter.presentIdeasList(ideaListModel: list)
    }
}
