//
//  TableViewCellViewModel.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-13.
//  Copyright © 2017 Mustard. All rights reserved.
//

import UIKit

protocol TableViewCellViewModel {
    static func register(with tableView: UITableView)
    func dequeue(from tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
    func selected()
}

extension TableViewCellViewModel {
    func selected() { }
}
