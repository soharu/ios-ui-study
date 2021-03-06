//
//  ShowcaseTableViewController.swift
//  Showcase
//
//  Created by Jahyun Oh on 2019/10/30.
//  Copyright © 2019 Jahyun Oh. All rights reserved.
//

import UIKit

class ShowcaseTableViewController: UITableViewController {
    typealias Cell = ShowcaseTableViewCell

    private let items: [Showcase] = [
        HelloShowcase(),
        FlowingTextShowcase(),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Showcase"
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.reuseID)
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseID, for: indexPath)
        cell.textLabel?.text = items[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewController = items[indexPath.row].instantiate()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
