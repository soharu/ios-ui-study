//
//  NumberFieldView.swift
//  LocalizedNumberInputField
//
//  Created by Jahyun Oh on 2020/02/16.
//  Copyright © 2020 Jahyun Oh. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class NumberFieldView: UIView {
    private let maxValue: Int

    private let inputField = UITextField()

    private let digitFormatter = NumberFormatter.make(with: Locale(identifier: "EN"))
    private let currentFormatter = NumberFormatter.make(with: NSLocale.current)

    private let disposeBag = DisposeBag()

    init(maxValue: Int) {
        self.maxValue = maxValue

        super.init(frame: .zero)

        addSubview(inputField)
        inputField.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }

        inputField.keyboardType = .numberPad
        inputField.clearButtonMode = .whileEditing
        inputField.placeholder = "Input number (max: \(maxValue))"

        inputField.delegate = self

        // Event
        inputField.rx.controlEvent(.editingChanged)
            .asDriver()
            .drive(onNext: { [weak self] (_) in
                guard let strongSelf = self else { return }
                guard let text = strongSelf.inputField.text, text.isEmpty == false else { return }
                guard let digits = strongSelf.digitFormatter.number(from: text) else { return }
                strongSelf.inputField.text = strongSelf.currentFormatter.string(from: digits)
            })
            .disposed(by: disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NumberFieldView: UITextFieldDelegate {
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
        // 아라비아 숫자가 아닌 문자로 숫자가 입력될 경우, 포맷터를 이용해서 아라비아 숫자로 변환
        guard let digits = digitFormatter.number(from: newText) else {
            // 숫자로 변환할 수 없는 문자가 포함된 경우에는 허용하지 않음
            return false
        }
        return digits.intValue <= maxValue
    }
}
