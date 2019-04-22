//
//  ScheduleViewController.swift
//  FootballSchedule
//
//  Created by Tony Albor on 1/19/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    private let competitionCode: String
    private let schedule: ScheduleAPI
    private var matches = [Match]()
    
    init(competitionCode: String, schedule: ScheduleAPI) {
        self.competitionCode = competitionCode
        self.schedule = schedule
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = ScheduleView()
    }
    var contentView: ScheduleView {
        return view as! ScheduleView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSchedule()
        getSchedule()
    }
    
    private func setUpSchedule() {
        contentView.matches.dataSource = self
        contentView.matches.delegate = self
        contentView.matches.estimatedRowHeight = 100.0
    }
    
    private func getSchedule() {
        schedule.getCurrentMatches(competitionCode: competitionCode) { [weak self] result in
            DispatchQueue.main.async { [weak self] in
                self?.handleScheduleResponse(result)
            }
        }
    }

    private func handleScheduleResponse(_ result: Result<[Match]>) {
        switch result {
        case let .success(value):
            matches.append(contentsOf: value)
            contentView.matches.reloadData()
        case let .failure(error):
            print(error.localizedDescription)
            print(error)
        }
    }
}

extension ScheduleViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(MatchTableViewCell.self)
        cell.match = matches[indexPath.row]
        return cell
    }
}

extension ScheduleViewController: UITableViewDelegate {

}
