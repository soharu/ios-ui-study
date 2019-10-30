//
//  Showcase.swift
//  Showcase
//
//  Created by Jahyun Oh on 2019/10/30.
//  Copyright © 2019 Jahyun Oh. All rights reserved.
//

import UIKit

protocol Showcase {
    var name: String { get }
    func instantiate() -> UIViewController
}
