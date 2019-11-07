//
//  URLImageTextAttachment.swift
//  TextAttachmentLab
//
//  Created by Jahyun Oh on 01/05/2019.
//  Copyright © 2019 Jahyun Oh. All rights reserved.
//

import UIKit
import Kingfisher

extension NSTextAttachment {
    convenience init(image: UIImage) {
        self.init(data: nil, ofType: nil)

        self.image = image
    }

    convenience init(image: UIImage, fitTo font: UIFont) {
        self.init(data: nil, ofType: nil)

        self.image = image
        self.bounds = image.sizeThatFits(font: font)
    }
}

class URLImageTextAttachment: NSTextAttachment {
    private let url: URL
    private let placeholderImage: UIImage
    private let font: UIFont
    private weak var textContainer: NSTextContainer?
    private var downloadTask: DownloadTask?

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(url: URL, placeholderImage: UIImage, fitTo font: UIFont) {
        self.url = url
        self.placeholderImage = placeholderImage
        self.font = font

        super.init(data: nil, ofType: nil)
    }

    override func image(
        forBounds imageBounds: CGRect,
        textContainer: NSTextContainer?,
        characterIndex charIndex: Int
    ) -> UIImage? {
        assert(textContainer != nil)

        if let image = image {
            return image
        }

        self.textContainer = textContainer
        loadImageIfNeeded()
        return placeholderImage
    }

    override func attachmentBounds(
        for textContainer: NSTextContainer?,
        proposedLineFragment lineFrag: CGRect,
        glyphPosition position: CGPoint,
        characterIndex charIndex: Int
    ) -> CGRect {
        if let image = image {
            return image.sizeThatFits(font: font)
        } else {
            return placeholderImage.sizeThatFits(font: font)
        }
    }

    private func loadImageIfNeeded() {
        guard image == nil && downloadTask == nil else { return }

        downloadTask = KingfisherManager.shared.retrieveImage(with: url) { [weak self] (result) in
            guard let strongSelf = self else { return }

            switch result {
            case .success(let value):
                strongSelf.image = value.image
                strongSelf.redraw()

            case .failure(let error):
                print(error.localizedDescription)
            }

            strongSelf.downloadTask = nil
        }
    }

    private func redraw() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.textContainer?.layoutManager?.invalidate(for: strongSelf)
        }
    }
}

private extension NSLayoutManager {
    // This method is the minimized version of original source code from:
    //  - https://github.com/Cocoanetics/Swift-Examples/blob/master/Attachments/Attachments/NSLayoutManager%2BAttachments.swift
    // And it is specialized for URLImageTextAttachment
    func invalidate(for attachment: URLImageTextAttachment) {
        guard let attributedString = textStorage else { return }

        let fullRange = NSRange(location: 0, length: attributedString.length)

        var refreshRanges = [NSRange]()
        attributedString.enumerateAttribute(
            NSAttributedString.Key.attachment,
            in: fullRange,
            options: [],
            using: { (value, range, _) in
                if let foundAttachment = value as? NSTextAttachment, foundAttachment == attachment {
                    refreshRanges.append(range)
                }
            }
        )

        // See below the blog article for the reason for using that function:
        //  https://www.cocoanetics.com/2016/09/asynchronous-nstextattachments-22/
        //  > The reverse() in both functions has a special purpose:
        //  > without it I found that UIKit would sometimes crash in an endless loop
        //  > if I had dozens of ranges. Maybe Apple doesn’t unit test the invalidation
        //  > functions being called in a tight loop dozens of times.
        refreshRanges.reversed().forEach {
            invalidateLayout(forCharacterRange: $0, actualCharacterRange: nil)
            invalidateDisplay(forCharacterRange: $0)
        }
    }
}
