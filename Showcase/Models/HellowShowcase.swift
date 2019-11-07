//
//  HellowShowcase.swift
//  Showcase
//
//  Created by Jahyun Oh on 2019/10/30.
//  Copyright © 2019 Jahyun Oh. All rights reserved.
//

import UIKit

struct HelloShowcase: Showcase {
    var name: String { "Hello, World" }

    func instantiate() -> UIViewController {
        let viewController = HelloViewController()
        viewController.navigationItem.title = name
        return viewController
    }
}
