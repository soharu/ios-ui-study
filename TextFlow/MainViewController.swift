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
    let texts = [
        "짧은 문장입니다.",
        "길을 걸었지 누군가 옆에 있다고 느꼈을 때 "
            + "나는 알아버렸네 이미 그대 떠난 후라는 걸 "
            + "나는 혼자 걷고 있던거지 갑자기 바람이 차가와지네.",
        "언젠가 가겠지 푸르른 이 청춘 지고 또 피는 꽃잎처럼"
            + "달밝은 밤이면 창가에 흐르는 내 젊은 영가가 구슬퍼.",
    ]
    let colors: [UIColor] = [.red, .green, .yellow]
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
                guard let ss = self else { return }
                let attributedText = NSAttributedString(
                    string: ss.texts[ss.currentIndex],
                    attributes: [
                        NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .medium),
                        NSAttributedString.Key.foregroundColor: UIColor.black,
                        NSAttributedString.Key.backgroundColor: ss.colors[ss.currentIndex]
                    ]
                )
                ss.currentIndex = (ss.currentIndex + 1) % ss.texts.count

                ss.textView.setAttributedText(attributedText)
                ss.textView.flow()
            })
            .disposed(by: disposeBag)
    }
}
