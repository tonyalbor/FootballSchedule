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

    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    static let matchDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.timeZone = TimeZone(identifier: "America/Los_Angeles")
        return formatter
    }()
    
    var match: Match? { didSet { update(match: match) } }
    
    private func update(match newValue: Match?) {
        if let homeTeam = newValue?.homeTeam {
            homeLogo.image = teamLogos[homeTeam.id]?.asUIImage()
            homeName.text = shortTeamNames[homeTeam.id] ?? homeTeam.name
        } else {
            homeLogo.image = nil
            homeName.text = nil
        }
//        homeScore.text = newValue?.score.fullTime?.homeTeam?.stringValue // todo: if game is not done yet, use different score
        if let awayTeam = newValue?.awayTeam {
            awayLogo.image = teamLogos[awayTeam.id]?.asUIImage()
            awayName.text = shortTeamNames[awayTeam.id] ?? awayTeam.name
        } else {
            awayLogo.image = nil
            homeName.text = nil
        }
//        awayScore.text = newValue?.score.fullTime?.awayTeam?.stringValue // todo: if game is not done yet, use different score
        if let homeScore = newValue?.score.fullTime?.homeTeam?.stringValue, let awayScore = newValue?.score.fullTime?.awayTeam?.stringValue {
            score.text = homeScore + " - " + awayScore
        } else if let dateString = match?.date {
            if let date = Self.dateFormatter.date(from: dateString) {
                let printed = Self.matchDateFormatter.string(from: date)
                score.text = printed
            } else {
                score.text = nil
            }
        } else {
            score.text = nil
        }
    }

    private lazy var scoreStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private(set) lazy var homeLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private(set) lazy var homeName: UILabel = {
        let label = UILabel()
//        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var score: UILabel = {
        let label = UILabel()
//        label.textColor = .label
//        label.text = " - "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
//    private(set) lazy var homeScore: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    private(set) lazy var awayLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private(set) lazy var awayName: UILabel = {
        let label = UILabel()
//        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
//    private(set) lazy var awayScore: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    private(set) lazy var date: UILabel = {
        let label = UILabel()
//        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        backgroundColor = .systemBackground
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        contentView.addSubview(homeLogo)
        contentView.addSubview(homeName)
        contentView.addSubview(centerStack)
            centerStack.addArrangedSubview(score)
//                scoreStack.addArrangedSubview(homeScore)
//                scoreStack.addArrangedSubview(scoreDash)
//                scoreStack.addArrangedSubview(awayScore)
//        contentView.addSubview(date)

//        contentView.addSubview(homeScore)
        contentView.addSubview(awayName)
        contentView.addSubview(awayLogo)

//        contentView.addSubview(awayScore)
//        contentView.addSubview(date)
    }

    private lazy var centerStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private func setUpConstraints() {
        let logoSideLength: CGFloat = 24.0
        var constraints = [NSLayoutConstraint]()
        constraints += [
            homeLogo.widthAnchor.constraint(equalToConstant: logoSideLength),
            homeLogo.heightAnchor.constraint(equalToConstant: logoSideLength),
//            homeLogo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20.0),
            homeLogo.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            homeLogo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
        ]
        constraints += [
//            homeName.heightAnchor.constraint(equalToConstant: 21.0),
            homeName.topAnchor.constraint(equalTo: homeLogo.topAnchor),
            homeName.leadingAnchor.constraint(equalTo: homeLogo.trailingAnchor, constant: 8.0),
            // todo: trailing
        ]
//        constraints += [
//            homeScore.centerYAnchor.constraint(equalTo: homeName.centerYAnchor),
//            homeScore.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1.0 * 20.0),
//        ]
        constraints += [
            centerStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            centerStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            centerStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ]
        constraints += [
            awayLogo.widthAnchor.constraint(equalToConstant: logoSideLength),
            awayLogo.heightAnchor.constraint(equalToConstant: logoSideLength),
            awayLogo.centerYAnchor.constraint(equalTo: homeLogo.centerYAnchor),
//            awayLogo.topAnchor.constraint(equalTo: homeName.bottomAnchor, constant: 20.0),
//            awayLogo.leadingAnchor.constraint(equalTo: homeLogo.leadingAnchor),
            awayLogo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1.0 * 20.0),
        ]
        constraints += [
//            awayName.centerYAnchor.constraint(equalTo: awayLogo.centerYAnchor),
//            awayName.heightAnchor.constraint(equalToConstant: 21.0),
            awayName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            awayName.topAnchor.constraint(equalTo: awayLogo.topAnchor),
//            awayName.leadingAnchor.constraint(equalTo: homeName.leadingAnchor),
            // todo: trailing
//            awayName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1.0 * 20.0),
            awayName.trailingAnchor.constraint(equalTo: awayLogo.leadingAnchor, constant: -1.0 * 8.0),
        ]
        constraints += [
//            awayScore.centerYAnchor.constraint(equalTo: awayName.centerYAnchor),
//            awayScore.trailingAnchor.constraint(equalTo: homeScore.trailingAnchor),
        ]
        constraints += [
            // TODO: needs a leading
//            date.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            date.trailingAnchor.constraint(equalTo: homeScore.leadingAnchor, constant: -1.0 * 16.0),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
