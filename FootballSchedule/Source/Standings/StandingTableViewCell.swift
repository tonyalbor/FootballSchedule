//
//  StandingTableViewCell.swift
//  FootballSchedule
//
//  Created by Tony Albor on 1/20/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import UIKit

class StandingTableViewCell: UITableViewCell, Reusable {
    
    var standing: Standing? { didSet { update(standing: standing) } }
    
    private lazy var position: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var logo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private lazy var team: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var matchesPlayed: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
//    private lazy var won: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    private lazy var draw: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    private lazy var lost: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    private lazy var points: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: label.font.pointSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
//    private lazy var goalsFor: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    private lazy var goalsAgainst: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    private lazy var goalDifference: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.setContentHuggingPriority(.required, for: .horizontal)
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
        contentView.addSubview(position)
        contentView.addSubview(logo)
        contentView.addSubview(team)
        contentView.addSubview(matchesPlayed)
//        contentView.addSubview(won)
//        contentView.addSubview(draw)
//        contentView.addSubview(lost)
        contentView.addSubview(points)
//        contentView.addSubview(goalsFor)
//        contentView.addSubview(goalsAgainst)
        contentView.addSubview(goalDifference)
    }
    
    private func setUpConstraints() {
        var constraints = [NSLayoutConstraint]()
        let itemSpacing: CGFloat = 0.0
        let itemWidth: CGFloat = 32.0
        constraints += [
            // todo: add width, and center position text so they all line up in the column
            //       maybe same thing for all the other labels (except team)
            position.widthAnchor.constraint(equalToConstant: 21.0),
            position.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            position.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            position.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1.0 * 8.0),
        ]
        constraints += [
            logo.heightAnchor.constraint(equalToConstant: 24.0),
            logo.widthAnchor.constraint(equalToConstant: 24.0),
            logo.centerYAnchor.constraint(equalTo: position.centerYAnchor),
            logo.leadingAnchor.constraint(equalTo: position.trailingAnchor, constant: 16.0),
        ]
        constraints += [
            team.centerYAnchor.constraint(equalTo: position.centerYAnchor),
            team.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 8.0),
            team.trailingAnchor.constraint(equalTo: matchesPlayed.leadingAnchor, constant: -1.0 * 12.0),
        ]
        constraints += [
            matchesPlayed.widthAnchor.constraint(equalToConstant: itemWidth),
            matchesPlayed.centerYAnchor.constraint(equalTo: position.centerYAnchor),
            matchesPlayed.trailingAnchor.constraint(equalTo: points.leadingAnchor, constant: -1.0 * itemSpacing),
        ]
//        constraints += [
//            won.widthAnchor.constraint(equalToConstant: itemWidth),
//            won.centerYAnchor.constraint(equalTo: position.centerYAnchor),
//            won.trailingAnchor.constraint(equalTo: draw.leadingAnchor, constant: -1.0 * itemSpacing),
//        ]
//        constraints += [
//            draw.widthAnchor.constraint(equalToConstant: itemWidth),
//            draw.centerYAnchor.constraint(equalTo: position.centerYAnchor),
//            draw.trailingAnchor.constraint(equalTo: lost.leadingAnchor, constant: -1.0 * itemSpacing),
//        ]
//        constraints += [
//            lost.widthAnchor.constraint(equalToConstant: itemWidth),
//            lost.centerYAnchor.constraint(equalTo: position.centerYAnchor),
//            lost.trailingAnchor.constraint(equalTo: points.leadingAnchor, constant: -1.0 * itemSpacing),
//        ]
        constraints += [
            points.widthAnchor.constraint(equalToConstant: itemWidth),
            points.centerYAnchor.constraint(equalTo: position.centerYAnchor),
            points.trailingAnchor.constraint(equalTo: goalDifference.leadingAnchor, constant: -1.0 * itemSpacing),
        ]
//        constraints += [
//            goalsFor.widthAnchor.constraint(equalToConstant: itemWidth),
//            goalsFor.centerYAnchor.constraint(equalTo: position.centerYAnchor),
//            goalsFor.trailingAnchor.constraint(equalTo: goalsAgainst.leadingAnchor, constant: -1.0 * itemSpacing),
//        ]
//        constraints += [
//            goalsAgainst.widthAnchor.constraint(equalToConstant: itemWidth),
//            goalsAgainst.centerYAnchor.constraint(equalTo: position.centerYAnchor),
//            goalsAgainst.trailingAnchor.constraint(equalTo: goalDifference.leadingAnchor, constant: -1.0 * itemSpacing),
//        ]
        constraints += [
            goalDifference.widthAnchor.constraint(equalToConstant: itemWidth),
            goalDifference.centerYAnchor.constraint(equalTo: position.centerYAnchor),
            goalDifference.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1.0 * 20),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func update(standing newValue: Standing?) {
        position.text = newValue?.position.stringValue
        if let teamModel = newValue?.team {
            logo.image = teamLogos[teamModel.id]?.asUIImage()
            team.text = shortTeamNames[teamModel.id]
        } else {
            logo.image = nil
            team.text = newValue?.team.name
        }
        matchesPlayed.text = newValue?.playedGames.stringValue
//        won.text = newValue?.won.stringValue
//        draw.text = newValue?.draw.stringValue
//        lost.text = newValue?.lost.stringValue
        points.text = newValue?.points.stringValue
        if let gdnum = newValue?.goalDifference, let numstring = gdnum.stringValue, gdnum > 0 {
            goalDifference.text = "+" + numstring
        } else {
            goalDifference.text = newValue?.goalDifference.stringValue
        }
    }
}
