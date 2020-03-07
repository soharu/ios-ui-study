//
//  FlowingTextShowcase.swift
//  Showcase
//
//  Created by Jahyun Oh on 2019/10/30.
//  Copyright © 2019 Jahyun Oh. All rights reserved.
//

import UIKit

struct FlowingTextShowcase: Showcase {
    var name: String { "Flowing Text" }

    func instantiate() -> UIViewController {
        let viewController = FlowingTextDemoViewController()
        viewController.navigationItem.title = name
        return viewController
    }
}
