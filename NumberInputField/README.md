# NumberInputField

## Goal

Make UITextField that accepts only a valid positive decimal number in the specific range

## Solution

Use numberPad keyboard

```swift
numberInputField.keyboardType = .numberPad
```

Implement a delegate method to prevent invalid characters and to check that the new value is in the valid range

```swift
numberInputField.delegate = self

// ...

func textField(
  _ textField: UITextField,
  shouldChangeCharactersIn range: NSRange,
  replacementString string: String) -> Bool {
  let currentText = textField.text
  let newText = (currentText as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
  let number = Int(newText) ?? 0
  return minValue ... maxValue ~= number
}
```

Replace the text to a single zero for:

- Clear all text
- Enter only zero consecutively

```swift
numberInputField.rx.controlEvent(.editingChanged)
    .asDriver()
    .drive(onNext: { [weak self] (_) in
        guard let field = self?.numberInputField else { return }
        let text = field.text ?? ""
        field.text = String(Int(text) ?? 0)
    })
    .disposed(by: disposeBag)
```
