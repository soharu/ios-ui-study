//
//  FlowingTextShowcase.swift
//  Showcase
//
//  Created by Jahyun Oh on 2019/10/30.
//  Copyright © 2019 Jahyun Oh. All rights reserved.
//

import UIKit
import SnapKit

struct FlowingTextShowcase: ViewShowcase {

    var name: String { "Flowing Text" }

    func setUp(on stackView: UIStackView) {
        stackView.axis = .vertical
        stackView.spacing = 10

        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 20, weight: .medium),
            .foregroundColor: UIColor.black,
            .backgroundColor: UIColor.systemYellow,
        ]

        FlowingTextDemo.texts
            .map { NSAttributedString(string: $0, attributes: attributes) }
            .forEach {
                let view = FlowingTextView()
                view.setAttributedText($0)
                stackView.addArrangedSubview(view)
            }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            stackView.arrangedSubviews
                .compactMap { $0 as? FlowingTextView }
                .forEach { $0.flow() }
        }
    }
}

extension FlowingTextShowcase: Showcase {}
