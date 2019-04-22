//
//  AdminView.swift
//  FootballSchedule
//
//  Created by Tony Albor on 4/21/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import UIKit

class AdminView: UIView {

    private lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private func createButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 10.0
        button.setTitle(title, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    private(set) lazy var schedule: UIButton = {
        return createButton(title: "Delete Schedule Data")
    }()
    private(set) lazy var standings: UIButton = {
        return createButton(title: "Delete Standings Data")
    }()
    private(set) lazy var scorers: UIButton = {
        return createButton(title: "Delete Scorers Data")
    }()
    private(set) lazy var team: UIButton = {
        return createButton(title: "Delete Team Data")
    }()
    private(set) lazy var all: UIButton = {
        return createButton(title: "Delete All Data")
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
        backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        addSubview(container)
        container.addSubview(schedule)
        container.addSubview(standings)
        container.addSubview(scorers)
        container.addSubview(team)
        container.addSubview(all)
    }

    private func setUpConstraints() {
        let buttonHeight: CGFloat = 60.0
        let buttonSpacing: CGFloat = 16.0
        var constraints = [NSLayoutConstraint]()
        constraints += [
            container.centerXAnchor.constraint(equalTo: centerXAnchor),
            container.centerYAnchor.constraint(equalTo: centerYAnchor),
            container.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
        ]
        constraints += [
            schedule.heightAnchor.constraint(equalToConstant: buttonHeight),
            schedule.topAnchor.constraint(equalTo: container.topAnchor),
            schedule.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            schedule.trailingAnchor.constraint(equalTo: container.trailingAnchor),
        ]
        constraints += [
            standings.heightAnchor.constraint(equalTo: schedule.heightAnchor),
            standings.topAnchor.constraint(equalTo: schedule.bottomAnchor, constant: buttonSpacing),
            standings.leadingAnchor.constraint(equalTo: schedule.leadingAnchor),
            standings.trailingAnchor.constraint(equalTo: schedule.trailingAnchor),
        ]
        constraints += [
            scorers.heightAnchor.constraint(equalTo: standings.heightAnchor),
            scorers.topAnchor.constraint(equalTo: standings.bottomAnchor, constant: buttonSpacing),
            scorers.leadingAnchor.constraint(equalTo: standings.leadingAnchor),
            scorers.trailingAnchor.constraint(equalTo: standings.trailingAnchor),
        ]
        constraints += [
            team.heightAnchor.constraint(equalTo: scorers.heightAnchor),
            team.topAnchor.constraint(equalTo: scorers.bottomAnchor, constant: buttonSpacing),
            team.leadingAnchor.constraint(equalTo: scorers.leadingAnchor),
            team.trailingAnchor.constraint(equalTo: scorers.trailingAnchor),
        ]
        constraints += [
            all.heightAnchor.constraint(equalTo: team.heightAnchor),
            all.topAnchor.constraint(equalTo: team.bottomAnchor, constant: buttonSpacing),
            all.leadingAnchor.constraint(equalTo: team.leadingAnchor),
            all.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            all.trailingAnchor.constraint(equalTo: team.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
