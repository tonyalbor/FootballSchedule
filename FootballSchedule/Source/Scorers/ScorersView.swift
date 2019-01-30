//
//  ScorersView.swift
//  FootballSchedule
//
//  Created by Tony Albor on 1/29/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import UIKit

class ScorersView: UIView {
    
    private(set) lazy var scorers: UITableView = {
        let tableView = UITableView()
        tableView.register(ScorerTableViewCell.self)
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
        addSubview(scorers)
    }
    
    private func setUpConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints += [
            scorers.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            scorers.leadingAnchor.constraint(equalTo: leadingAnchor),
            scorers.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            scorers.trailingAnchor.constraint(equalTo: trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
