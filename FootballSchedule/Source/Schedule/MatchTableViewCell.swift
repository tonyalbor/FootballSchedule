//
//  MatchTableViewCell.swift
//  FootballSchedule
//
//  Created by Tony Albor on 1/19/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import UIKit

extension Int {
    var stringValue: String? {
        return String(self)
    }
}

class MatchTableViewCell: UITableViewCell, Reusable {
    
    var match: Match? { didSet { update(match: match) } }
    
    private func update(match newValue: Match?) {
        homeLogo.image = nil // todo
        homeName.text = newValue?.homeTeam.name
        homeScore.text = newValue?.score.fullTime?.homeTeam?.stringValue // todo: if game is not done yet, use different score
        awayLogo.image = nil // todo
        awayName.text = newValue?.awayTeam.name
        awayScore.text = newValue?.score.fullTime?.awayTeam?.stringValue // todo: if game is not done yet, use different score
    }
    
    private(set) lazy var homeLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private(set) lazy var homeName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var homeScore: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private(set) lazy var awayLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private(set) lazy var awayName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var awayScore: UILabel = {
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
//        translatesAutoresizingMaskIntoConstraints = false
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.addSubview(homeLogo)
        contentView.addSubview(homeName)
        contentView.addSubview(homeScore)
//        contentView.addSubview(awayLogo)
        contentView.addSubview(awayName)
        contentView.addSubview(awayScore)
    }
    
    private func setUpConstraints() {
        let logoSideLength: CGFloat = 16.0
//        var margins = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
//        margins = .zero
        var constraints = [NSLayoutConstraint]()
//        constraints += [
//            homeLogo.widthAnchor.constraint(equalToConstant: logoSideLength),
//            homeLogo.heightAnchor.constraint(equalToConstant: logoSideLength),
//            homeLogo.topAnchor.constraint(equalTo: topAnchor, constant: margins.top),
//            homeLogo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margins.left),
//        ]
        constraints += [
//            homeName.heightAnchor.constraint(equalToConstant: 21.0),
            homeName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20.0),
            homeName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            // todo: trailing
        ]
        constraints += [
            homeScore.centerYAnchor.constraint(equalTo: homeName.centerYAnchor),
            homeScore.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1.0 * 20.0),
        ]
//        constraints += [
//            awayLogo.widthAnchor.constraint(equalToConstant: logoSideLength),
//            awayLogo.heightAnchor.constraint(equalToConstant: logoSideLength),
//            //            awayLogo.topAnchor.constraint(equalTo: homeLogo.bottomAnchor, constant: margins.bottom), // todo: put this back in when images are in
//            awayLogo.leadingAnchor.constraint(equalTo: homeLogo.leadingAnchor),
//        ]
        constraints += [
//            awayName.centerYAnchor.constraint(equalTo: awayLogo.centerYAnchor),
//            awayName.heightAnchor.constraint(equalToConstant: 21.0),
            awayName.topAnchor.constraint(equalTo: homeName.bottomAnchor, constant: 20.0), // todo: when images are in, use centerY instead of this constraint
            awayName.leadingAnchor.constraint(equalTo: homeName.leadingAnchor),
            // todo: trailing
            awayName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1.0 * 20.0),
        ]
        constraints += [
            awayScore.centerYAnchor.constraint(equalTo: awayName.centerYAnchor),
            awayScore.trailingAnchor.constraint(equalTo: homeScore.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}