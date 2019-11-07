//
//  Showcase.swift
//  Showcase
//
//  Created by Jahyun Oh on 2019/10/30.
//  Copyright © 2019 Jahyun Oh. All rights reserved.
//

import UIKit
import SnapKit

protocol Showcase {
    var name: String { get }
    func instantiate() -> UIViewController
}

protocol ViewShowcase: Showcase {
    func setUp(on stackView: UIStackView)
}

extension ViewShowcase {
    func instantiate() -> UIViewController {
        let viewController = StackViewController()
        viewController.navigationItem.title = name
        setUp(on: viewController.stackView)
        return viewController
    }
}

// MARK: - StackViewController

private class StackViewController: UIViewController {
    let stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }

        let contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalTo(view)
            maker.top.bottom.equalToSuperview()
        }

        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview().inset(15)
        }
    }
}
