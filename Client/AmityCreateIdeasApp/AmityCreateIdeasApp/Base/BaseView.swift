//
//  BaseView.swift
//  AmityCreateIdeasApp
//
//  Created by Amsaraj Mariappan on 12/9/2563 BE.
//  Copyright © 2563 Amsaraj Mariyappan. All rights reserved.
//

import UIKit

class BaseView: UIView {

    ///  add cornerRadiusV new attributes for view
    @IBInspectable var cornerRadiusV: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    ///  add borderWidthV new attributes for view
    @IBInspectable var borderWidthV: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    ///  add borderColorV new attributes for view
    @IBInspectable var borderColorV: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
