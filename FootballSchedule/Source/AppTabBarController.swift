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
    
    override func loadView() {
        super.loadView()
        
        schedule.title = "Schedule"
        standings.title = "Standings"
        scorers.title = "Top Scorers"
        team.title = "Man City"
        viewControllers = [schedule, standings, scorers, team]
    }
}
