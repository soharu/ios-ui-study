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

        contentView.addSubview(textLabel)
        textLabel.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview()
            maker.top.bottom.trailing.equalToSuperview()
            maker.width.greaterThanOrEqualTo(scrollView.snp.width)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setAttributedText(_ text: NSAttributedString) {
        scrollView.layer.removeAllAnimations()
        scrollView.contentOffset = .zero
        textLabel.attributedText = text
    }

    func flow() {
        guard scrollView.contentOffset.x == 0 else { assertionFailure(); return }
        guard textLabel.bounds.width > scrollView.bounds.width else { return }

        let pixelPerSeconds: CGFloat = 100
        let x = textLabel.bounds.width - scrollView.bounds.width
        let duration = x / pixelPerSeconds

        UIView.animate(
            withDuration: TimeInterval(duration),
            delay: 0,
            options: [ .curveLinear ],
            animations: { [weak self] in
                self?.scrollView.contentOffset = CGPoint(x: x, y: 0)
            })
    }
}
