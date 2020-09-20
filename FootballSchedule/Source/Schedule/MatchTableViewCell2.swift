//
//  MatchTableViewCell2.swift
//  FootballSchedule
//
//  Created by Tony Albor on 9/20/20.
//  Copyright © 2020 Tony Albor. All rights reserved.
//

import UIKit

class BasicTeamView: UIView {

    private lazy var logo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private lazy var name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpViews() {
        addSubview(logo)
        addSubview(name)
    }

    private func setUpConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints += [
            logo.widthAnchor.constraint(equalToConstant: 24.0),
            logo.heightAnchor.constraint(equalTo: logo.widthAnchor),
            logo.topAnchor.constraint(equalTo: topAnchor),
            logo.leadingAnchor.constraint(equalTo: leadingAnchor),
            logo.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]
        constraints += [
            name.centerYAnchor.constraint(equalTo: logo.centerYAnchor),
            name.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 8.0),
            name.trailingAnchor.constraint(equalTo: trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }


    func update(team: Team) {
        logo.image = teamLogos[team.id]?.asUIImage()
        name.text = shortTeamNames[team.id] ?? team.name
    }

    func prepareForReuse() {
        logo.image = nil
        name.text = nil
    }
}

class MatchTableViewCell2: UITableViewCell, Reusable {

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


    private lazy var horizontalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var teamsContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var home: BasicTeamView = {
        let team = BasicTeamView()
        team.translatesAutoresizingMaskIntoConstraints = false
        return team
    }()
    private lazy var away: BasicTeamView = {
        let team = BasicTeamView()
        team.translatesAutoresizingMaskIntoConstraints = false
        return team
    }()
    private lazy var infoStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var score: UIStackView = {
        let stackView = UIStackView()
        stackView.isHidden = true
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var homeScore: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var awayScore: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var time: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    override func prepareForReuse() {
        super.prepareForReuse()
        home.prepareForReuse()
        away.prepareForReuse()
        score.isHidden = true
        homeScore.text = nil
        awayScore.text = nil
        time.text = nil
        time.isHidden = true
    }


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpViews() {
        contentView.addSubview(horizontalStack)
            horizontalStack.addArrangedSubview(teamsContainer)
                teamsContainer.addSubview(home)
                teamsContainer.addSubview(away)
            horizontalStack.addArrangedSubview(infoStack)
                infoStack.addArrangedSubview(score)
                    score.addArrangedSubview(homeScore)
                    score.addArrangedSubview(awayScore)
                infoStack.addArrangedSubview(time)
    }

    private func setUpConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints += [
            horizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0),
            horizontalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            horizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1.0 * 16.0),
            horizontalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1.0 * 20),
        ]
        constraints += [
            home.topAnchor.constraint(equalTo: teamsContainer.topAnchor),
            home.leadingAnchor.constraint(equalTo: teamsContainer.leadingAnchor),
            home.trailingAnchor.constraint(equalTo: teamsContainer.trailingAnchor),
        ]
        constraints += [
            away.topAnchor.constraint(equalTo: home.bottomAnchor, constant: 12.0),
            away.leadingAnchor.constraint(equalTo: home.leadingAnchor),
            away.bottomAnchor.constraint(equalTo: teamsContainer.bottomAnchor),
            away.trailingAnchor.constraint(equalTo: home.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }


    func update(match: Match) {
        home.update(team: match.homeTeam)
        away.update(team: match.awayTeam)
        if let homeScoreText = match.score.fullTime?.homeTeam?.stringValue,
           let awayScoreText = match.score.fullTime?.awayTeam?.stringValue {
            homeScore.text = homeScoreText
            awayScore.text = awayScoreText
            time.text = "FT"
            score.isHidden = false
            time.isHidden = false
        } else {
            let dateString = match.date
            if let date = Self.dateFormatter.date(from: dateString) {
                let printed = Self.matchDateFormatter.string(from: date)
                time.text = printed
                time.isHidden = false
                score.isHidden = true
            } else {
                time.isHidden = true
            }
        }
    }
}
