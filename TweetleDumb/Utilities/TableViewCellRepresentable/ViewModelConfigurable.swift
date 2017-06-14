//
//  ViewModelConfigurable.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-13.
//  Copyright © 2017 Mustard. All rights reserved.
//

import UIKit

protocol ViewModelConfigurable {
    associatedtype ViewModel

    func configure(with viewModel: ViewModel)
}

extension TableViewCellRepresentable where TableViewCell: ViewModelConfigurable & Reusable, TableViewCell.ViewModel == Self {
    func dequeue(from tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath) as? TableViewCell
            else { fatalError("Unable to dequeue a cell of type '\(TableViewCell.self)'") }

        cell.configure(with: self)

        return cell
    }
}
