//
//  MainViewController.swift
//  LocalizedNumberInputField
//
//  Created by Jahyun Oh on 22/08/2018.
//  Copyright © 2018 Jahyun Oh. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxGesture

extension NumberFormatter {
    static func make(with locale: Locale) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = locale
        return formatter
    }
}

class MainViewController: UIViewController {
    private let numberFieldView = NumberFieldView(maxValue: 1_000_000)

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        // Layout
        view.addSubview(numberFieldView)
        numberFieldView.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalToSuperview().inset(30)
            maker.top.equalToSuperview().offset(250)
        }

        view.rx.tapGesture().when(.ended)
            .subscribe(onNext: { [weak numberFieldView] (_) in
                numberFieldView?.endEditing(true)
            })
            .disposed(by: disposeBag)
    }
}
