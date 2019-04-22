//
//  AppTabBarController.swift
//  FootballSchedule
//
//  Created by Tony Albor on 1/19/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import UIKit

class AppTabBarController: UITabBarController {
    
    let schedule = ScheduleViewController(competitionCode: "PL", schedule: ScheduleAPI())
    let standings = StandingsViewController(standings: StandingsAPI())
    let scorers = ScorersViewController(scorers: ScorersAPI())
    let team = TeamScheduleViewController(teamId: 65, schedule: TeamScheduleAPI())
    let admin = AdminViewController()
    
    override func loadView() {
        super.loadView()
        viewControllers = [schedule, standings, scorers, team, admin]
        schedule.tabBarItem.title = "Schedule"
        standings.tabBarItem.title = "Standings"
        scorers.tabBarItem.title = "Top Scorers"
        team.tabBarItem.title = "Man City"
        admin.tabBarItem.title = "Admin"
    }
}
