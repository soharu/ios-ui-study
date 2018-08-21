//
//  MainViewController.swift
//  Hello
//
//  Created by Jahyun Oh on 21/08/2018.
//  Copyright © 2018 Jahyun Oh. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        let label = UILabel()
        view.addSubview(label)
        label.snp.makeConstraints { (maker) in
            maker.centerY.equalToSuperview()
            maker.leading.trailing.equalToSuperview().inset(20)
        }
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Hello, World"
    }
}
