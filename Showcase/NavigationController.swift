//
//  NavigationController.swift
//  Showcase
//
//  Created by Jahyun Oh on 2019/10/30.
//  Copyright © 2019 Jahyun Oh. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    init() {
        super.init(rootViewController: ShowcaseTableViewController())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

typealias MainViewController = NavigationController
