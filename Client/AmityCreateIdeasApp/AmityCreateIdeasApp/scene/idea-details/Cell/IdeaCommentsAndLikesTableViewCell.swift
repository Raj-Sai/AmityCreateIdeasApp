//
//  IdeaCommentsAndLikesTableViewCell.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 13/9/2563 BE.
//  Copyright © 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit

class IdeaCommentsAndLikesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backView: UIView?
    @IBOutlet weak var nameBackView: BaseView?
    @IBOutlet weak var nameInitialLabel: UILabel?

    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var daysLabel: UILabel?
    @IBOutlet weak var commentsLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /// update cell idea information
    func setupCell(ideaComments: [IdeasModel.Response.IdeaComments],
                   ideaLikes: [IdeasModel.Response.IdeaLikes],
                   withSelectedSegment selectedSegment: String,
                   selectedIndex: Int) {
        if let view = backView {
            view.applyShadow(color: UIColor(red: 0, green: 0, blue: 0, alpha: 1.0), alpha: 0.1, x: 0, y: 10, blur: 15, spread: 0)
            view.layer.cornerRadius = 5
            view.layer.masksToBounds = false
        }
        self.selectionStyle = .none
        
        if selectedSegment == "comments" {
            let model = ideaComments[selectedIndex]
            self.nameInitialLabel?.text = model.comment_by?.prefix(2).uppercased()
            self.nameLabel?.text = model.comment_by
            self.commentsLabel?.text = model.comment
             let dateString = model.comment_timestamp?.daysBetweenCurrentDate()
            daysLabel?.text = dateString
        } else {
          let model = ideaLikes[selectedIndex]
            self.nameInitialLabel?.text = model.like_by?.prefix(2).uppercased()
            self.nameLabel?.text = model.like_by
            self.commentsLabel?.text = "Liked by \(model.like_by ?? "")"
            let dateString = model.like_timestamp?.daysBetweenCurrentDate()
            daysLabel?.text = dateString
        }
    }
}
