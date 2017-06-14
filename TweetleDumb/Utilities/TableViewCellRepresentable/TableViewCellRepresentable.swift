//
//  TableViewCellRepresentable.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-13.
//  Copyright © 2017 Mustard. All rights reserved.
//

import UIKit

protocol TableViewCellRepresentable: TableViewCellViewModel {
    associatedtype TableViewCell: UITableViewCell
}

extension TableViewCellRepresentable where TableViewCell: Reusable {
    static func register(with tableView: UITableView) {
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseIdentifier)
    }
    func dequeue(from tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath)
    }
}

extension UITableView {
    func register(cells: [TableViewCellViewModel.Type]) {
        cells.forEach { $0.register(with: self) }
    }
}
