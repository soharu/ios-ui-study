//
//  MainViewController.swift
//  TextAttachmentLab
//
//  Created by Jahyun Oh on 01/05/2019.
//  Copyright © 2019 Jahyun Oh. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        KingfisherManager.shared.cache.clearDiskCache() // clear cache for testing

        view.backgroundColor = .white

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fillProportionally

        stackView.addArrangedSubview(makeLabel(text: "Hello, world!"))
        stackView.addArrangedSubview(makeLabel(image: Resource.portraitSolidColorImage))
        stackView.addArrangedSubview(makeLabel(image: Resource.landscapeSolidColorImage, text: "Color Image"))
        stackView.addArrangedSubview(makeLabel(image: Resource.squareImage, text: "Image from Resource"))

        let textView = makeTextView([
            Resource.imageURL, "Hello, World!\n",
            "Read ",
            URL(string: "https://www.tuestudy.org/images/jmbook2.png")!, ", ",
            URL(string: "https://www.tuestudy.org/images/500l-lines.png")!, ", & ",
            URL(string: "https://www.tuestudy.org/images/aosabook-vol.2.jpg")!,
            ])
        stackView.addArrangedSubview(textView)
        textView.snp.makeConstraints { (maker) in
            maker.height.greaterThanOrEqualTo(200)
            maker.bottom.equalToSuperview()
        }

        let arrangedViewCount = stackView.arrangedSubviews.count
        stackView.arrangedSubviews.enumerated().forEach {
            $0.element.backgroundColor = UIColor(rgb: 0xFF0000 | (($0.offset * (255 / arrangedViewCount)) % 255))
        }

        view.addSubview(stackView)
        stackView.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
            maker.width.equalToSuperview().inset(20)
            maker.height.greaterThanOrEqualToSuperview().dividedBy(2)
            maker.top.greaterThanOrEqualTo(view.safeAreaLayoutGuide.snp.top)
            maker.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }

    private func makeLabel(text: String) -> UILabel {
        let label = UILabel()
        label.font = Resource.font
        label.textAlignment = .center
        label.textColor = .white
        label.text = text
        return label
    }

    private func makeLabel(image: UIImage) -> UILabel {
        let imageAttachment = NSTextAttachment(image: image)
        let label = UILabel()
        label.textAlignment = .center
        label.attributedText = NSAttributedString(attachment: imageAttachment)
        return label
    }

    private func makeLabel(image: UIImage, text: String) -> UILabel {
        let imageAttachment = NSTextAttachment(image: image, fitTo: Resource.font)

        let attributedText = NSMutableAttributedString()
        attributedText.append(NSAttributedString(attachment: imageAttachment))
        attributedText.append(NSAttributedString(string: " " + text))
        attributedText.addAttributes(
            [
                NSAttributedString.Key.font: Resource.font,
                NSAttributedString.Key.foregroundColor: UIColor.white,
            ],
            range: NSRange(location: 0, length: attributedText.length)
        )

        let label = UILabel()
        label.textAlignment = .center
        label.attributedText = attributedText
        return label
    }

    private func makeTextView(_ items: [Any]) -> UITextView {
        let attributedText = NSMutableAttributedString()

        items.forEach { item in
            switch item {
            case let text as String:
                attributedText.append(NSAttributedString(string: "\(text)"))
            case let url as URL:
                let imageAttachment = URLImageTextAttachment(
                    url: url,
                    placeholderImage: Resource.placeholderImage,
                    fitTo: Resource.largeFont
                )
                attributedText.append(NSAttributedString(attachment: imageAttachment))
            default:
                break
            }
            attributedText.append(NSAttributedString(string: " "))
        }

        attributedText.addAttributes(
            [
                NSAttributedString.Key.font: Resource.largeFont,
                NSAttributedString.Key.foregroundColor: UIColor.white,
            ],
            range: NSRange(location: 0, length: attributedText.length)
        )

        let textView = UITextView()
        textView.attributedText = attributedText
        textView.textAlignment = .center
        return textView
    }
}
