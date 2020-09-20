//
//  StandingsView.swift
//  FootballSchedule
//
//  Created by Tony Albor on 1/20/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import UIKit

class StandingsView: UIView {
    
    private(set) var standings: UITableView = {
        let tableView = UITableView()
        tableView.register(StandingTableViewCell.self)
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
        addSubview(standings)
    }
    
    private func setUpConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints += [
            standings.topAnchor.constraint(equalTo: topAnchor),
            standings.leadingAnchor.constraint(equalTo: leadingAnchor),
            standings.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            standings.trailingAnchor.constraint(equalTo: trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
