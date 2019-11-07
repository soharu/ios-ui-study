//
//  MainViewController.swift
//  TextFlow
//
//  Created by Jahyun Oh on 04/08/2019.
//  Copyright © 2019 Jahyun Oh. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    let texts = FlowingTextDemo.texts
    let colors: [UIColor] = [
        .systemRed,
        .systemGreen,
        .systemYellow,
    ]
    var currentIndex = 0

    let disposeBag = DisposeBag()

    let textView = FlowingTextView()
    let flowButton = UIButton(type: .custom)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        let stackView = UIStackView(arrangedSubviews: [textView, flowButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center

        view.addSubview(stackView)
        stackView.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalToSuperview()
            maker.center.equalToSuperview()
        }

        // textView
        textView.snp.makeConstraints { (maker) in
            maker.width.equalToSuperview().inset(20)
        }
        textView.backgroundColor = .lightGray

        // flowButton
        flowButton.setTitle("Flow", for: .normal)
        flowButton.setTitleColor(UIColor.blue, for: .normal)

        flowButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let strongSelf = self else { return }
                let attributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 20, weight: .medium),
                    .foregroundColor: UIColor.black,
                    .backgroundColor: strongSelf.colors[strongSelf.currentIndex],
                ]
                let attributedText = NSAttributedString(
                    string: strongSelf.texts[strongSelf.currentIndex],
                    attributes: attributes
                )
                strongSelf.currentIndex = (strongSelf.currentIndex + 1) % strongSelf.texts.count

                strongSelf.textView.setAttributedText(attributedText)
                strongSelf.textView.flow()
            })
            .disposed(by: disposeBag)
    }
}
