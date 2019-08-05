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
    let textView = FlowingTextView()
    let flowButton = UIButton(type: .custom)
    let changeButton = UIButton(type: .custom)

    let texts = [
        "길을 걸었지 누군가 옆에 있다고 느꼈을 때 "
            + "나는 알아버렸네 이미 그대 떠난 후라는 걸 "
            + "나는 혼자 걷고 있던거지 갑자기 바람이 차가와지네",
        "언젠가 가겠지 푸르른 이 청춘 지고 또 피는 꽃잎처럼"
            + "달밝은 밤이면 창가에 흐르는 내 젊은 영가가 구슬퍼",
    ]
    var currentTextIndex = 0

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.addSubview(textView)

        // textView
        textView.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalToSuperview().inset(20)
            maker.centerY.equalToSuperview()
        }

        textView.backgroundColor = .yellow
        let attributedText = NSAttributedString(
            string: texts[currentTextIndex],
            attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .medium),
                NSAttributedString.Key.foregroundColor: UIColor.black
            ]
        )
        textView.setAttributedText(attributedText)

        let stackView = UIStackView(arrangedSubviews: [flowButton, changeButton])
        stackView.axis = .vertical
        stackView.spacing = 10

        view.addSubview(stackView)
        stackView.snp.makeConstraints { (maker) in
            maker.width.equalToSuperview().dividedBy(2)
            maker.centerX.equalToSuperview()
            maker.top.equalTo(textView.snp.bottom).offset(20)
        }

        // flowButton
        flowButton.setTitle("Flow Text", for: .normal)
        flowButton.setTitleColor(UIColor.blue, for: .normal)

        flowButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.textView.flow()
            })
            .disposed(by: disposeBag)

        // changeButton
        changeButton.setTitle("Change Text", for: .normal)
        changeButton.setTitleColor(UIColor.blue, for: .normal)

        changeButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let ss = self else { return }
                ss.currentTextIndex = (ss.currentTextIndex + 1) % ss.texts.count
                let attributedText = NSAttributedString(
                    string: ss.texts[ss.currentTextIndex],
                    attributes: [
                        NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .medium),
                        NSAttributedString.Key.foregroundColor: UIColor.black
                    ]
                )
                ss.textView.setAttributedText(attributedText)
            })
            .disposed(by: disposeBag)
    }
}
