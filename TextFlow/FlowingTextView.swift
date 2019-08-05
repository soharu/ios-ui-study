//
//  FlowingTextView.swift
//  TextFlow
//
//  Created by Jahyun Oh on 05/08/2019.
//  Copyright © 2019 Jahyun Oh. All rights reserved.
//

import UIKit
import SnapKit

class FlowingTextView: UIView {
    let scrollView = UIScrollView()
    let contentView = UIView()
    let blankView = UIView()
    let textLabel = UILabel()

    init() {
        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false

        addSubview(scrollView)
        scrollView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }

        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
            maker.height.equalToSuperview().priority(.low)
            maker.width.equalToSuperview().priority(.low)
        }
        contentView.backgroundColor = .red

        contentView.addSubview(blankView)
        blankView.snp.makeConstraints { (maker) in
            maker.leading.top.bottom.equalToSuperview()
            maker.width.equalTo(scrollView)
        }
        blankView.backgroundColor = .green

        contentView.addSubview(textLabel)
        textLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(blankView.snp.trailing)
            maker.top.bottom.trailing.equalToSuperview()
        }
    }

    func setAttributedText(_ text: NSAttributedString) {
        textLabel.attributedText = text
    }

    func flow() {
        let x: CGFloat = {
            if scrollView.contentOffset.x != 0 {
                return 0
            } else {
                return textLabel.bounds.width
            }
        }()

        UIView.animate(
            withDuration: 5.0,
            delay: 0,
            options: [ .curveLinear ],
            animations: { [weak self] in
                self?.scrollView.contentOffset = CGPoint(x: x, y: 0)
        })
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
