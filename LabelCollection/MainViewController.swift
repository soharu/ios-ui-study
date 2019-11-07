//
//  MainViewController.swift
//  LabelCollection
//
//  Created by Jahyun Oh on 05/09/2019.
//  Copyright © 2019 Jahyun Oh. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    typealias Cell = UITableViewCell

    private let collectionView = LabelCollectionView()

    private let tableView = UITableView()

    private let items = "An object that manages an ordered collection of data "
        + "items and presents them using customizable layouts"
        .split(separator: " ")
        .map { String($0) }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (maker) in
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            maker.leading.trailing.equalToSuperview()
            maker.height.equalTo(50)
        }
        collectionView.backgroundColor = .green
        collectionView.dataSource = self
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return items.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: LabelCollectionView.Cell.reuseIdentifier,
            for: indexPath) as? LabelCollectionView.Cell

        cell?.setLabel(text: items[indexPath.row])

        return cell!
    }
}
