//
//  ViewShowcase.swift
//  Showcase
//
//  Created by Jahyun Oh on 2019/10/30.
//  Copyright © 2019 Jahyun Oh. All rights reserved.
//

import UIKit
import SnapKit

protocol ViewShowcase {
    var name: String { get }
    func setUp(on stackView: UIStackView)
    func instantiate() -> UIViewController
}

extension ViewShowcase {
    func instantiate() -> UIViewController {
        let vc = StackViewController()
        vc.navigationItem.title = name
        setUp(on: vc.stackView)
        return vc
    }
}

// MARK: - VerticalStackViewController

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
