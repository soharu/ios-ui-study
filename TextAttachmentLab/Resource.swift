//
//  Resource.swift
//  TextAttachmentLab
//
//  Created by Jahyun Oh on 01/05/2019.
//  Copyright © 2019 Jahyun Oh. All rights reserved.
//

import UIKit

enum Resource {
    static let font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    static let largeFont = UIFont.systemFont(ofSize: 40, weight: .semibold)
    static let squareImage = UIImage(named: "ThinkingCat")!
    static let portraitSolidColorImage = UIImage(color: .gray, size: CGSize(width: 50, height: 100))!
    static let landscapeSolidColorImage = UIImage(color: .gray, size: CGSize(width: 100, height: 50))!
    static let placeholderImage = UIImage(color: .lightGray, size: CGSize(width: 50, height: 50))!
    static let imageURL = URL(string: "https://avatars0.githubusercontent.com/u/1327853")!
}
