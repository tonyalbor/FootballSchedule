//
//  Reusable.swift
//  FootballSchedule
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

    func register<Cell: UITableViewCell>(_ cellType: Cell.Type) where Cell: Reusable {
        register(cellType, forCellReuseIdentifier: cellType.reuseIdentifier)
    }

    func dequeueReusableCell<Cell: UITableViewCell>(_ cellType: Cell.Type) -> Cell where Cell: Reusable {
        return dequeueReusableCell(withIdentifier: cellType.reuseIdentifier) as! Cell
    }
}
