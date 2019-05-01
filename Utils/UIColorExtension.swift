//
//  UIColorExtension.swift
//  TextAttachmentLab
//
//  Created by Jahyun Oh on 01/05/2019.
//  Copyright © 2019 Jahyun Oh. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: Int) {
        assert(0...255 ~= red)
        assert(0...255 ~= green)
        assert(0...255 ~= blue)
        assert(0...255 ~= alpha)

        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(alpha) / 255.0)
    }

    convenience init(rgba: Int) {
        self.init(
            red: (rgba >> 24) & 0xFF,
            green: (rgba >> 16) & 0xFF,
            blue: (rgba >> 8) & 0xFF,
            alpha: rgba & 0xFF
        )
    }

    convenience init(rgb: Int) {
        self.init(rgba: (rgb << 8 | 0xFF))
    }
}
