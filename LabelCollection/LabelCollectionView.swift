//
//  LabelCollectionView.swift
//  LabelCollection
//
//  Created by Jahyun Oh on 06/09/2019.
//  Copyright © 2019 Jahyun Oh. All rights reserved.
//

import UIKit
import SnapKit

class LabelCollectionView: UICollectionView {
    typealias Cell = LabelCollectionViewCell

    init() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        flowLayout.minimumLineSpacing = 20

        super.init(frame: .zero, collectionViewLayout: flowLayout)

        register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
        isMultipleTouchEnabled = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LabelCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: LabelCollectionViewCell.self)

    private let label = UILabel()
    private let lineView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .white

        contentView.addSubview(label)
        label.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview().inset(5)
        }
        label.setContentCompressionResistancePriority(.required, for: .horizontal)

        contentView.addSubview(lineView)
        lineView.snp.makeConstraints { (maker) in
            maker.width.equalToSuperview()
            maker.height.equalTo(2)
            maker.bottom.equalToSuperview()
        }
        lineView.backgroundColor = .black
        lineView.isHidden = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setLabel(text: String) {
        label.text = text
    }

    override var isSelected: Bool {
        didSet {
            lineView.isHidden = !isSelected
        }
    }
}
