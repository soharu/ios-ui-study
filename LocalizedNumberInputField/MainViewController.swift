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

extension NumberFormatter {
    static func make(with locale: Locale) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = locale
        return formatter
    }
}

class MainViewController: UIViewController {
    let disposeBag = DisposeBag()
    let numberInputField = UITextField()
    let minValue: Int = 0
    let maxValue: Int = 10_000
    let digitFormatter = NumberFormatter.make(with: Locale(identifier: "EN"))
    let currentFormatter = NumberFormatter.make(with: NSLocale.current)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        // Layout
        view.addSubview(numberInputField)
        numberInputField.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalToSuperview().inset(30)
            maker.top.equalToSuperview().offset(250)
        }

        // Appearance
        numberInputField.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        numberInputField.textAlignment = .center
        numberInputField.textColor = .black

        // Configuration
        numberInputField.text = currentFormatter.string(from: 0)
        numberInputField.keyboardType = .numberPad
        numberInputField.delegate = self

        // Event
        numberInputField.rx.controlEvent(.editingChanged)
            .asDriver()
            .drive(onNext: { [weak self] (_) in
                guard let strongSelf = self else { return }
                let text = strongSelf.numberInputField.text ?? ""
                let digits = strongSelf.digitFormatter.number(from: text) ?? 0
                strongSelf.numberInputField.text = strongSelf.currentFormatter.string(from: digits)
            })
            .disposed(by: disposeBag)

        numberInputField.becomeFirstResponder()
    }
}

extension MainViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String) -> Bool {
        let currentText = textField.text
        let newText = (currentText as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        let digits = digitFormatter.number(from: newText) ?? 0
        return minValue ... maxValue ~= digits.intValue
    }
}
