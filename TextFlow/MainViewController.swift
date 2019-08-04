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
    let button = UIButton(type: .custom)

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.addSubview(textView)
        view.addSubview(button)

        // textView
        textView.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalToSuperview().inset(20)
            maker.centerY.equalToSuperview()
        }

        textView.backgroundColor = .yellow
        let text = NSAttributedString(
            string: "마하반야바라밀다심경"
                + "관자재보살 행심반야바라밀다시 조견오온개공 도일체고액"
                + "사리자 색불이공 공불이색 색즉시공 공즉시색 수상행식 역부여시",
            attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .medium),
                NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.backgroundColor: UIColor.green
            ]
        )
        textView.setAttributedText(text)

        // button
        button.snp.makeConstraints { (maker) in
            maker.width.equalToSuperview().dividedBy(2)
            maker.centerX.equalToSuperview()
            maker.top.equalTo(textView.snp.bottom).offset(20)
        }

        button.setTitle("Flow", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)

        button.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.textView.flow()
            })
            .disposed(by: disposeBag)
    }
}

class FlowingTextView: UIScrollView {
    let contentView = UIView()
    let textLabel = UILabel()

    init() {
        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false

        addSubview(contentView)
        contentView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
            maker.height.equalToSuperview().priority(.low)
            maker.width.equalToSuperview().priority(.low)
        }
        contentView.backgroundColor = .red

        contentView.addSubview(textLabel)
        textLabel.snp.makeConstraints { (maker) in
             maker.edges.equalToSuperview()
        }
    }

    func setAttributedText(_ text: NSAttributedString) {
        textLabel.attributedText = text
    }

    func flow() {
        let x: CGFloat = {
            if contentOffset.x != 0 {
                return 0
            } else {
                return textLabel.bounds.width - self.bounds.width
            }
        }()

        UIView.animate(
            withDuration: 5,
            delay: 0,
            options: [ .curveLinear ],
            animations: { [weak self] in
                self?.contentOffset = CGPoint(x: x, y: 0)
        })
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

