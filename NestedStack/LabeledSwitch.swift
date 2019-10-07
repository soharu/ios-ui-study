//
//  LabeledSwitch.swift
//  NestedStack
//
//  Created by Jahyun Oh on 07/10/2019.
//  Copyright © 2019 Jahyun Oh. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class LabeledSwitch: UIView {
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let toggleSwitch = UISwitch()

    override init(frame: CGRect) {
        super.init(frame: frame)

        let contentsStack = UIStackView()
        contentsStack.axis = .horizontal
        contentsStack.spacing = 16
        contentsStack.alignment = .top

        do {
            let innerStack = UIStackView()
            innerStack.axis = .vertical
            innerStack.spacing = 5

            titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            titleLabel.textColor = .black
            titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
            innerStack.addArrangedSubview(titleLabel)

            descriptionLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
            descriptionLabel.textColor = .systemGray4
            descriptionLabel.numberOfLines = 3
            descriptionLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
            innerStack.addArrangedSubview(descriptionLabel)

            contentsStack.addArrangedSubview(innerStack)
        }
        contentsStack.addArrangedSubview(toggleSwitch)

        addSubview(contentsStack)
        contentsStack.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Reactive where Base: LabeledSwitch {
    var isOn: Observable<Bool> {
        return base.toggleSwitch.rx.controlEvent(.valueChanged)
            .map { [weak base] in base?.toggleSwitch.isOn ?? false }
            .startWith(base.toggleSwitch.isOn)
    }
}
