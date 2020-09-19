//
//  UIView+Extension.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 18/9/2563 BE.
//  Copyright © 2563 Amsaraj Mariyappan. All rights reserved.

import UIKit

extension UIView {
    
    /// apply shadows
    func applyShadow(color: UIColor = .black,
                     alpha: Float = 0.5, x: CGFloat = 0,
                     y: CGFloat = 2, blur: CGFloat = 4,
                     spread: CGFloat = 0)
    {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = alpha
        self.layer.shadowOffset = CGSize(width: x, height: y)
        self.layer.shadowRadius = blur / 2.0
        if spread == 0 {
            self.layer.shadowPath = nil
        } else {
            let dx = -spread
            let rect = self.layer.bounds.insetBy(dx: dx, dy: dx)
            self.layer.shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
