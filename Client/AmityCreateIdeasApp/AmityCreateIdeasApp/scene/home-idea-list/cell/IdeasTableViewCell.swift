//
//  IdeasTableViewCell.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 12/9/2563 BE.
//  Copyright © 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit

class IdeasTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var nameBackView: BaseView!
    @IBOutlet weak var nameInitialLabel: UILabel!
    @IBOutlet weak var ideaTitleLabel: UILabel!
    
    @IBOutlet weak var ideaCategoryLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var commentImageView: UIImageView!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var postDayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /// update cell idea information
    func setupCell(_ data: IdeasModel.Response.Idea) {
        self.backView.applyShadow(color: UIColor(red: 0, green: 0, blue: 0, alpha: 1.0), alpha: 0.1, x: 0, y: 10, blur: 15, spread: 0)
        self.ideaTitleLabel.text = data.idea_title!
        self.selectionStyle = .none
        self.backView.layer.cornerRadius = 5;
        self.backView.layer.masksToBounds = false
        self.ideaCategoryLabel.text = data.idea_category
        self.likeCountLabel.text = "\(data.idea_likes.count)"
        self.commentCountLabel.text = "\(data.idea_comments.count)"
        self.userNameLabel.text = data.user_name
        self.nameInitialLabel.text = data.user_name?.prefix(2).uppercased()
        let dateString = data.created_time_stamp?.daysBetweenCurrentDate()
        self.postDayLabel.text = dateString
    }
}
