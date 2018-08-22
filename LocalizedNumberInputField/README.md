# LocalizedNumberInputField

## Goal

`NumberInputField` does not work with arabic number characters(١٢٣٤٥٦٧٨٩٠).

Add language support to `UITextField`

## Solution

We need two number formatters:

- `digitFormatter` converts _a localized number text_ to _digits_.
- `currentFormatter` converts _digits_ to _a localized number text_.

I added an extension of `NumberFormatter` to make the formatter easier.

```swift
extension NumberFormatter {
    static func make(with locale: Locale) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = locale
        return formatter
    }
}
```

And there are formatters here:

```swift
let digitFormatter = NumberFormatter.make(with: Locale(identifier: "EN"))
let currentFormatter = NumberFormatter.make(with: NSLocale.current)
```

The `text` of `UITextField` is converted to digits as follows:

```swift
let text = ss.numberInputField.text ?? ""
let digits = ss.digitFormatter.number(from: text) ?? 0
```

And the digits are converted back to a localized string:

```swift
ss.numberInputField.text = ss.currentFormatter.string(from: digits)
```

The `digitFormatter` is enough to check the number is in the valid range:

```swift
let currentText = textField.text
let newText = (currentText as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
let digits = digitFormatter.number(from: newText) ?? 0
return minValue ... maxValue ~= digits.intValue
```

Surprisingly, the `digitFormatter` converts `١٥٨8` to `1588`.

----

Note that I tested this code __only for Arabic__. I will test another locale later.
