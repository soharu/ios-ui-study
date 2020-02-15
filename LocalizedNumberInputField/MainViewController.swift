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
    let minValue: Int = 1
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
        numberInputField.text = nil
        numberInputField.placeholder = "Input number (\(minValue) ~ \(maxValue))"
        numberInputField.delegate = self

        // Event
        numberInputField.rx.controlEvent(.editingChanged)
            .asDriver()
            .drive(onNext: { [weak self] (_) in
                guard let strongSelf = self else { return }
                guard let text = strongSelf.numberInputField.text, text.isEmpty == false else { return }
                guard let digits = strongSelf.digitFormatter.number(from: text) else { return }
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
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        guard newText.isEmpty == false else {
            // 문자열을 삭제한 경우는 허용
            return true
        }
        guard let digits = digitFormatter.number(from: newText) else {
            // 숫자로 변환할 수 없는 문자가 포함된 경우에는 허용하지 않음
            return false
        }
        return minValue ... maxValue ~= digits.intValue
    }
}
