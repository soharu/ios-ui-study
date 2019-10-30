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

        let texts = [
            "짧은 문장입니다.",
            "언젠가 가겠지 푸르른 이 청춘 지고 또 피는 꽃잎처럼"
                + "달밝은 밤이면 창가에 흐르는 내 젊은 영가가 구슬퍼.",
            "길을 걸었지 누군가 옆에 있다고 느꼈을 때 "
                + "나는 알아버렸네 이미 그대 떠난 후라는 걸 "
                + "나는 혼자 걷고 있던거지 갑자기 바람이 차가와지네.",
        ]

        texts.forEach { (text) in
            let attributedText = NSAttributedString(
                string: text,
                attributes: [
                    NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .medium),
                    NSAttributedString.Key.foregroundColor: UIColor.black,
                    NSAttributedString.Key.backgroundColor: UIColor.systemYellow
                ]
            )
            let view = FlowingTextView()
            view.setAttributedText(attributedText)
            stackView.addArrangedSubview(view)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                view.flow()
            }
        }
    }
}

extension FlowingTextShowcase: Showcase {}
