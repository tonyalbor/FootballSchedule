//
//  Reusable.swift
//  Football Schedule
//
//  Created by Tony Albor on 1/19/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import UIKit

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: type(of: self))
    }
}

extension UITableView {

    func register<Cell: UITableViewCell>(_: Cell.Type) where Cell: Reusable {
        register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
    }

    func dequeueReusableCell<Cell: UITableViewCell>(_: Cell.Type) -> Cell where Cell: Reusable {
        return dequeueReusableCell(withIdentifier: Cell.reuseIdentifier) as! Cell
    }
}
