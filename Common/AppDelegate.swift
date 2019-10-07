//
//  AppDelegate.swift
//  Samples
//
//  Created by Jahyun Oh on 21/08/2018.
//  Copyright © 2018 Jahyun Oh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)

        window?.rootViewController = MainViewController()
        window?.makeKeyAndVisible()

        return true
    }
}
