//
//  StandingTableViewCell.swift
//  FootballSchedule
//
//  Created by Tony Albor on 1/20/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import UIKit

// todo: break out into own files
class StandingSubView: UIView {
    
    private(set) lazy var won: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) lazy var draw: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) lazy var lost: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        addSubview(won)
        addSubview(draw)
        addSubview(lost)
    }
    
    private func setUpConstraints() {
        var constraints = [NSLayoutConstraint]()
        let itemSpacing: CGFloat = 0.0
        let itemWidth: CGFloat = 32.0
        constraints += [
            won.widthAnchor.constraint(equalToConstant: itemWidth),
            won.topAnchor.constraint(equalTo: topAnchor, constant: 8.0),
            won.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1.0 * 8.0),
            won.trailingAnchor.constraint(equalTo: draw.leadingAnchor, constant: -1.0 * itemSpacing),
        ]
        constraints += [
            draw.widthAnchor.constraint(equalToConstant: itemWidth),
            draw.centerYAnchor.constraint(equalTo: won.centerYAnchor),
            draw.trailingAnchor.constraint(equalTo: lost.leadingAnchor, constant: -1.0 * itemSpacing),
        ]
        constraints += [
            lost.widthAnchor.constraint(equalToConstant: itemWidth),
            lost.centerYAnchor.constraint(equalTo: won.centerYAnchor),
            lost.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1.0 * 20),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

class StandingMainView: UIView {

    private(set) lazy var position: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) lazy var logo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private(set) lazy var team: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) lazy var matchesPlayed: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) lazy var points: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: label.font.pointSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) lazy var goalDifference: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        addSubview(position)
        addSubview(logo)
        addSubview(team)
        addSubview(matchesPlayed)
        addSubview(points)
        addSubview(goalDifference)
    }
    
    private func setUpConstraints() {
        var constraints = [NSLayoutConstraint]()
        let itemSpacing: CGFloat = 0.0
        let itemWidth: CGFloat = 32.0
        constraints += [
            // todo: add width, and center position text so they all line up in the column
            //       maybe same thing for all the other labels (except team)
            position.widthAnchor.constraint(equalToConstant: 21.0),
            position.topAnchor.constraint(equalTo: topAnchor, constant: 8.0),
            position.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
            position.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1.0 * 8.0),
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
        constraints += [
            points.widthAnchor.constraint(equalToConstant: itemWidth),
            points.centerYAnchor.constraint(equalTo: position.centerYAnchor),
            points.trailingAnchor.constraint(equalTo: goalDifference.leadingAnchor, constant: -1.0 * itemSpacing),
        ]
        constraints += [
            goalDifference.widthAnchor.constraint(equalToConstant: itemWidth),
            goalDifference.centerYAnchor.constraint(equalTo: position.centerYAnchor),
            goalDifference.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1.0 * 20),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

class StandingTableViewCell: UITableViewCell, Reusable {
    
    var standing: Standing? { didSet { update(standing: standing) } }

    private(set) lazy var container: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private(set) lazy var mainView: StandingMainView = {
        let view = StandingMainView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private(set) lazy var subview: StandingSubView = {
        let view = StandingSubView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        let duration: TimeInterval = selected ? 0.3 : 0.15
        UIView.animate(withDuration: duration) {
            self.subview.alpha = selected ? 1.0 : 0.0
            self.subview.isHidden = !selected
        }
    }
    
    private func setUpViews() {
        selectedBackgroundView = {
            let view = UIView()
            view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
            return view
        }()
        contentView.addSubview(container)
            container.addArrangedSubview(mainView)
            container.addArrangedSubview(subview)
    }
    
    private func setUpConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints += [
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]
        constraints += [
            mainView.topAnchor.constraint(equalTo: container.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
        ]
        constraints += [
            subview.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            subview.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            subview.trailingAnchor.constraint(equalTo: container.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func update(standing newValue: Standing?) {
        mainView.position.text = newValue?.position.stringValue
        if let teamModel = newValue?.team {
            mainView.logo.image = teamLogos[teamModel.id]?.asUIImage()
            mainView.team.text = shortTeamNames[teamModel.id]
        } else {
            mainView.logo.image = nil
            mainView.team.text = newValue?.team.name
        }
        mainView.matchesPlayed.text = newValue?.playedGames.stringValue
        subview.won.text = newValue?.won.stringValue
        subview.draw.text = newValue?.draw.stringValue
        subview.lost.text = newValue?.lost.stringValue
        mainView.points.text = newValue?.points.stringValue
        if let gdnum = newValue?.goalDifference, let numstring = gdnum.stringValue, gdnum > 0 {
            mainView.goalDifference.text = "+" + numstring
        } else {
            mainView.goalDifference.text = newValue?.goalDifference.stringValue
        }
    }
}
