//
//  MainViewController.swift
//  NumberInputField
//
//  Created by Jahyun Oh on 21/08/2018.
//  Copyright © 2018 Jahyun Oh. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    let disposeBag = DisposeBag()
    let numberInputField = UITextField()
    let maxValue: Int = 10_000

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
        numberInputField.text = "0"
        numberInputField.keyboardType = .numberPad
        numberInputField.delegate = self

        // Event
        numberInputField.rx.controlEvent(.editingChanged)
            .asDriver()
            .drive(onNext: { [weak self] (_) in
                guard let field = self?.numberInputField else { return }
                let text = field.text ?? ""
                field.text = String(Int(text) ?? 0)
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
        let number = Int(newText) ?? 0
        return number <= maxValue
    }
}
