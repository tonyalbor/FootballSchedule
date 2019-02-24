//
//  HomeViewController.swift
//  FootballSchedule
//
//  Created by Tony Albor on 1/19/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import UIKit

class HomeViewController: UITabBarController {
    
    override func loadView() {
        super.loadView()
        let schedule = ScheduleViewController(competitionCode: "PL", schedule: ScheduleAPI())
        let standings = StandingsViewController(standings: StandingsAPI())
        let scorers = ScorersViewController(scorers: ScorersAPI())
        schedule.title = "Schedule"
        standings.title = "Standings"
        scorers.title = "Top Scorers"
        viewControllers = [schedule, standings, scorers]
//        viewControllers = [standings, schedule, scorers]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
