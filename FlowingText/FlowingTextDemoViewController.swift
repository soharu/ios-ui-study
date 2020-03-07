//
//  FlowingTextDemoViewController.swift
//  TextFlow
//
//  Created by Jahyun Oh on 04/08/2019.
//  Copyright © 2019 Jahyun Oh. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class FlowingTextDemoViewController: UIViewController {
    private lazy var texts: [NSAttributedString] = {
        let items: [(UIColor, String)] = [
            (
                .systemYellow,
                "화면 너비보다 짧으면 흐르지 않습니다."
            ),
            (
                .systemGreen,
                "언젠가 가겠지 푸르른 이 청춘 지고 또 피는 꽃잎처럼"
                    + "달밝은 밤이면 창가에 흐르는 내 젊은 영가가 구슬퍼."
            ),
            (
                .systemBlue,
                "길을 걸었지 누군가 옆에 있다고 느꼈을 때 "
                    + "나는 알아버렸네 이미 그대 떠난 후라는 걸 "
                    + "나는 혼자 걷고 있던거지 갑자기 바람이 차가와지네."
            ),
        ]
        return items.map { (backgroundColor, text) in
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 20, weight: .medium),
                .foregroundColor: UIColor.black,
                .backgroundColor: backgroundColor,
            ]
            return NSAttributedString(string: text, attributes: attributes)
        }
    }()
    private var currentIndex = 0

    private let textView = FlowingTextView()
    private let changeButton = UIButton(type: .custom)

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
        bind()
    }

    private func setUp() {
        view.backgroundColor = .white

        let stackView = UIStackView(arrangedSubviews: [textView, changeButton])
        stackView.axis = .vertical
        stackView.spacing = 10

        view.addSubview(stackView)
        stackView.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalToSuperview().inset(10)
            maker.center.equalToSuperview()
        }

        // textView
        textView.backgroundColor = .lightGray
        textView.setAttributedText(texts[currentIndex])

        // changeButton
        changeButton.setTitle("Change Text", for: .normal)
        changeButton.setTitleColor(UIColor.blue, for: .normal)
    }

    private func bind() {
        changeButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.currentIndex = (strongSelf.currentIndex + 1) % strongSelf.texts.count
                strongSelf.textView.setAttributedText(strongSelf.texts[strongSelf.currentIndex])
                strongSelf.textView.flow()
            })
            .disposed(by: disposeBag)
    }
}
