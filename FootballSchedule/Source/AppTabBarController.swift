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

    private lazy var scheduleNavigation = UINavigationController(rootViewController: schedule)
    private lazy var standingsNavigation = UINavigationController(rootViewController: standings)
    private lazy var scorersNavigation = UINavigationController(rootViewController: scorers)
    private lazy var teamNavigation = UINavigationController(rootViewController: team)
    private lazy var adminNavigation = UINavigationController(rootViewController: admin)
    
    override func loadView() {
        super.loadView()
        viewControllers = [scheduleNavigation,
                           standingsNavigation,
                           scorersNavigation,
                           teamNavigation,
                           adminNavigation]
        setUpTabBarItems()
        setUpNavigationItems()
        setUpLargeTitles()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }

    private func setUpTabBarItems() {
        scheduleNavigation.tabBarItem.title = "Schedule"
        standingsNavigation.tabBarItem.title = "Standings"
        scorersNavigation.tabBarItem.title = "Scorers"
        teamNavigation.tabBarItem.title = "Man City"
        adminNavigation.tabBarItem.title = "Admin"
    }

    private func setUpNavigationItems() {
        schedule.navigationItem.title = "Schedule"
        standings.navigationItem.title = "Standings"
        scorers.navigationItem.title = "Top Scorers"
        team.navigationItem.title = "Manchester City"
        admin.navigationItem.title = "Admin"
    }

    private func setUpLargeTitles() {
        scheduleNavigation.navigationBar.prefersLargeTitles = true
        standingsNavigation.navigationBar.prefersLargeTitles = true
        scorersNavigation.navigationBar.prefersLargeTitles = true
        teamNavigation.navigationBar.prefersLargeTitles = true
        adminNavigation.navigationBar.prefersLargeTitles = false
    }
}
