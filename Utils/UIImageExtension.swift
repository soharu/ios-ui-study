//
//  UIImageExtension.swift
//  TextAttachmentLab
//
//  Created by Jahyun Oh on 01/05/2019.
//  Copyright © 2019 Jahyun Oh. All rights reserved.
//

import UIKit

extension UIImage {
    convenience init?(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        defer { UIGraphicsEndImageContext() }

        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()

        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }

    func sizeThatFits(font: UIFont) -> CGRect {
        guard size.width > 0 && size.height > 0 else { return .zero }

        let ratio = font.lineHeight / size.height
        return CGRect(
            x: 0,
            y: font.descender,
            width: size.width * ratio,
            height: size.height * ratio
        )
    }
}
