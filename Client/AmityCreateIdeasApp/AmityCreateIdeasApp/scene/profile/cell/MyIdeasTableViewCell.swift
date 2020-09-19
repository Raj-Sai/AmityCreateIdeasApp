//
//  MyIdeasTableViewCell.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 13/9/2563 BE.
//  Copyright © 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit

class MyIdeasTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /// update cell idea information
    func setupCell(_ data: ProfileModel.Ideas) {
        self.backView.applyShadow(color: UIColor(red: 0, green: 0, blue: 0, alpha: 1.0), alpha: 0.1, x: 0, y: 10, blur: 15, spread: 0)
        self.selectionStyle = .none
        self.backView.layer.cornerRadius = 5;
        self.backView.layer.masksToBounds = false
        self.titleLabel.text = data.idea_title
        self.likesLabel.text = "\(data.idea_likes?.count ?? 0)"
        self.commentsLabel.text = "\(data.idea_comments?.count ?? 0)"
        self.categoryLabel.text = data.idea_category
    }
    
}
