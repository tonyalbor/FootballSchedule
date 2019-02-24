//
//  ScorerTableViewCell.swift
//  FootballSchedule
//
//  Created by Tony Albor on 1/29/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import UIKit

class ScorerTableViewCell: UITableViewCell, Reusable {
    
    func update(scorer: Scorer, rank rankPosition: Int) {
        rank.text = rankPosition.stringValue
        nationality.text = scorer.player.emojiNationalityFlag()
        name.text = scorer.player.name
        team.image = teamLogos[scorer.team.id]?.asUIImage()
//        team.text = shortTeamNames[scorer.team.id]
        goals.text = scorer.numberOfGoals.stringValue
    }
    
    private(set) lazy var rank: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) lazy var nationality: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) lazy var name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) lazy var team: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private(set) lazy var goals: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        contentView.addSubview(rank)
        contentView.addSubview(nationality)
        contentView.addSubview(name)
        contentView.addSubview(team)
        contentView.addSubview(goals)
    }
    
    private func setUpConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints += [
            rank.widthAnchor.constraint(equalToConstant: 24.0),
            rank.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0),
            rank.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            rank.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1.0 * 16.0),
        ]
        constraints += [
            team.widthAnchor.constraint(equalToConstant: 24.0),
            team.heightAnchor.constraint(equalToConstant: 24.0),
            team.topAnchor.constraint(equalTo: rank.topAnchor),
            team.leadingAnchor.constraint(equalTo: rank.trailingAnchor, constant: 24.0),
            team.bottomAnchor.constraint(equalTo: rank.bottomAnchor),
        ]
        constraints += [
            nationality.topAnchor.constraint(equalTo: rank.topAnchor),
            nationality.leadingAnchor.constraint(equalTo: team.trailingAnchor, constant: 8.0),
            nationality.bottomAnchor.constraint(equalTo: rank.bottomAnchor),
        ]
        constraints += [
            name.topAnchor.constraint(equalTo: rank.topAnchor),
            name.leadingAnchor.constraint(equalTo: nationality.trailingAnchor, constant: 8.0),
        ]
        constraints += [
            goals.topAnchor.constraint(equalTo: rank.topAnchor),
            goals.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1.0 * 24.0),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
