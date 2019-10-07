//
//  MainViewController.swift
//  NestedStack
//
//  Created by Jahyun Oh on 07/10/2019.
//  Copyright © 2019 Jahyun Oh. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    private let colorInfos: [ColorInfo] = [ .red, .green, .blue, .pink ]
    private var colorSwitches: [LabeledSwitch] = []
    private let colorStack = UIStackView()

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
        bind()
    }

    private func setUp() {
        view.backgroundColor = .systemYellow

        let containerView = UIView()
        view.addSubview(containerView)
        containerView.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
        }
        containerView.backgroundColor = .white
        containerView.applyRound(raidus: 5)

        let contentsStack = UIStackView()
        contentsStack.axis = .vertical
        contentsStack.spacing = 15

        let headlineLabel = UILabel()
        headlineLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        headlineLabel.textAlignment = .center
        headlineLabel.text = "Color Switches"
        contentsStack.addArrangedSubview(headlineLabel)

        let lineView = UIView()
        lineView.snp.makeConstraints { (maker) in
            maker.height.equalTo(1)
        }
        lineView.backgroundColor = .systemGray3
        contentsStack.addArrangedSubview(lineView)

        colorInfos.forEach { (info) in
            let view = LabeledSwitch.make(with: info)
            contentsStack.addArrangedSubview(view)
            colorSwitches.append(view)
        }

        colorStack.axis = .horizontal
        colorStack.spacing = 2
        colorStack.distribution = .fillEqually
        colorInfos.forEach { (info) in
            let view = UIView()
            view.backgroundColor = info.color
            colorStack.addArrangedSubview(view)
        }
        contentsStack.addArrangedSubview(colorStack)
        colorStack.snp.makeConstraints { (maker) in
            maker.height.equalTo(50)
        }

        containerView.addSubview(contentsStack)
        contentsStack.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview().inset(15)
            maker.width.equalTo(250)
        }
    }

    private func bind() {
        zip(colorSwitches, colorStack.arrangedSubviews).forEach { (colorSwitch, colorView) in
            colorSwitch.rx.isOn
                .subscribe(onNext: { [weak self] (isOn) in
                    guard let colorStack = self?.colorStack else { return }
                    colorView.isHidden = (isOn == false)
                    colorStack.isHidden = colorStack.arrangedSubviews.allSatisfy({ $0.isHidden })
                })
                .disposed(by: disposeBag)
        }
    }
}

extension LabeledSwitch {
    static func make(with colorInfo: ColorInfo) -> LabeledSwitch {
        let view = LabeledSwitch()

        view.titleLabel.text = "Turn on \(colorInfo.name)"
        view.descriptionLabel.text = colorInfo.description
        view.toggleSwitch.onTintColor = colorInfo.color

        return view
    }
}

extension UIView {
    func applyRound(raidus: CGFloat) {
        self.layer.cornerRadius = raidus
        self.clipsToBounds = true
    }
}
