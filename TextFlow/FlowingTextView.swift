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
            maker.width.greaterThanOrEqualTo(scrollView.snp.width)
        }
    }

    func setAttributedText(_ text: NSAttributedString) {
        // FIXME: 애니메이션 삭제가 바로 안되는 것 같다. 아래 completion에서 finished가 항상 true로 옴
        scrollView.layer.removeAllAnimations()

        textLabel.attributedText = text
        scrollView.contentOffset = .zero
    }

    func flow() {
        let pixelPerSeconds: CGFloat = 100
        let x: CGFloat = {
            if scrollView.contentOffset.x != 0 {
                return 0
            } else {
                return textLabel.bounds.width
            }
        }()
        let duration = x / pixelPerSeconds

        let id = UUID()

        print("ani started: \(id) \(textLabel.attributedText?.string)")
        UIView.animate(
            withDuration: TimeInterval(duration),
            delay: 0,
            options: [ .curveLinear ],
            animations: { [weak self] in
                self?.scrollView.contentOffset = CGPoint(x: x, y: 0)
            },
            completion: { [weak self] (finished) in
                print("ani completion: \(id): \(finished) \(self!.scrollView.contentOffset)" )
        })
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
