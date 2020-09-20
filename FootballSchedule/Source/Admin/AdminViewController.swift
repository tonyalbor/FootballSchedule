//
//  AdminViewController.swift
//  FootballSchedule
//
//  Created by Tony Albor on 4/21/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import UIKit

class AdminViewController: UIViewController {

    override func loadView() {
        view = AdminView()
    }
    private var contentView: AdminView { return view as! AdminView }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpActions()
    }

    private func setUpActions() {
        contentView.schedule.addTarget(self, action: #selector(handleScheduleTap), for: .touchUpInside)
        contentView.standings.addTarget(self, action: #selector(handleStandingsTap), for: .touchUpInside)
        contentView.scorers.addTarget(self, action: #selector(handleScorersTap), for: .touchUpInside)
        contentView.team.addTarget(self, action: #selector(handleTeamTap), for: .touchUpInside)
        contentView.all.addTarget(self, action: #selector(handleAllTap), for: .touchUpInside)
    }

    @objc
    private func handleScheduleTap() {
        deleteScheduleData()
    }

    @objc
    private func handleStandingsTap() {
        deleteStandingsData()
    }

    @objc
    private func handleScorersTap() {
        deleteScorersData()
    }

    @objc
    private func handleTeamTap() {
        deleteTeamData()
    }

    @objc
    private func handleAllTap() {
        deleteScheduleData()
        deleteStandingsData()
        deleteScorersData()
        deleteTeamData()
    }

    // TODO: move all these keys elsewhere
    private func deleteScheduleData() {
        Database<Season>().delete(key: "currentSeason:PL")
        Database<Season>().delete(key: "matches:PL:2") // TODO: delete current match day
    }
    private func deleteStandingsData() {
        Database<[Standing]>().delete(key: "currentStandings")
    }
    private func deleteScorersData() {
        Database<[Scorer]>().delete(key: "currentScorers")
    }
    private func deleteTeamData() {
        Database<[Match]>().delete(key: "currentManCityMatches")
    }
}
