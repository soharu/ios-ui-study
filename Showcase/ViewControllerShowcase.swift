//
//  ViewControllerShowcase.swift
//  Showcase
//
//  Created by Jahyun Oh on 2019/10/30.
//  Copyright © 2019 Jahyun Oh. All rights reserved.
//

import UIKit

protocol ViewControllerShowcase {
    var name: String { get }
    func instantiate() -> UIViewController
}

struct HelloShowcase: ViewControllerShowcase {
    var name: String { "Hello, World" }

    func instantiate() -> UIViewController {
        return HelloViewController()
    }
}
