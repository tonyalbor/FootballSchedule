//
//  ScheduleView.swift
//  Football Schedule
//
//  Created by Tony Albor on 1/19/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import UIKit

class ScheduleView: UIView {
    
    private(set) lazy var matches: UITableView = {
        let tableView = UITableView()
        tableView.register(MatchTableViewCell.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        addSubview(matches)
    }
    
    private func setUpConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints += [
            matches.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            matches.leadingAnchor.constraint(equalTo: leadingAnchor),
            matches.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            matches.trailingAnchor.constraint(equalTo: trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
