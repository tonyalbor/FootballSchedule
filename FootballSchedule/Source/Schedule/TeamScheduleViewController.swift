//
//  TeamScheduleViewController.swift
//  FootballSchedule
//
//  Created by Tony Albor on 3/17/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import UIKit

class TeamScheduleViewController: UIViewController {
    
    private let teamId: Int
    private let schedule: TeamScheduleAPI
    
    init(teamId: Int, schedule: TeamScheduleAPI) {
        self.teamId = teamId
        self.schedule = schedule
        super.init(nibName: nil, bundle: nil)
    }

    private let matchDayDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeZone = TimeZone(identifier: "America/Los_Angeles")
        return formatter
    }()

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    private let datePrinter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .medium
        formatter.timeZone = TimeZone(identifier: "America/Los_Angeles")
        return formatter
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var contentView = { ScheduleView() }()
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSchedule()
        getSchedule()
    }
    
    private func setUpSchedule() {
        contentView.matches.register(MatchTableViewCell2.self)
        contentView.matches.dataSource = self
        contentView.matches.delegate = self
        contentView.matches.estimatedRowHeight = 150.0
    }

    private var formattedDates: [Int: String] = [:]
    
    private func getSchedule() {
        schedule.getMatches(teamId: teamId) { [weak self] result in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                switch result {
                case let .success(value):
                    for match in value {
                        if let date = self.dateFormatter.date(from: match.date) {
                            let formatted = self.matchDayDateFormatter.string(from: date)
                            self.formattedDates[match.id] = formatted
                        }
                    }
                    self.contentView.matches.reloadData()
                case let .failure(error):
                    print(error.localizedDescription)
                    print(error)
                }
            }
        }
    }
}

extension TeamScheduleViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return schedule.matches.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(MatchTableViewCell2.self)
        if indexPath.section < schedule.matches.count {
            cell.update(match: schedule.matches[indexPath.section])
        }
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section < schedule.matches.count else {
            return nil
        }
        return formattedDates[schedule.matches[section].id]
    }
}

extension TeamScheduleViewController: UITableViewDelegate {
    
}
