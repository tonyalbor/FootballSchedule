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
    private var matchDays = [MatchDay]()

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
//    private let matchDateFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.timeStyle = .short
//        formatter.timeZone = TimeZone(identifier: "America/Los_Angeles")
//        return formatter
//    }()
    private let matchDayDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeZone = TimeZone(identifier: "America/Los_Angeles")
        return formatter
    }()
    
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
        contentView.matches.register(MatchTableViewCell2.self)
        contentView.matches.dataSource = self
        contentView.matches.delegate = self
        contentView.matches.estimatedRowHeight = 150.0
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
            matchDays.append(contentsOf: getMatchDays(matches: value))
            contentView.matches.reloadData()
        case let .failure(error):
            print(error.localizedDescription)
            print(error)
        }
    }
}

extension ScheduleViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return matchDays.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchDays[section].matches.count
//        return matches.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return matchDayDateFormatter.string(from: matchDays[section].date)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(MatchTableViewCell2.self)
        if indexPath.section < matchDays.count && indexPath.row < matchDays[indexPath.section].matches.count {
            cell.update(match: matchDays[indexPath.section].matches[indexPath.row])
        }
        return cell
    }
}

//extension Array where Element == Match {
//    func groupedBy(dateComponents: Set<Calendar.Component>) -> [Date: [Element]] {
//        let initial: [Date: [Element]] = [:]
//        let groupedByDateComponents = reduce(into: initial) { acc, cur in
//            let components = Calendar.current.dateComponents(dateComponents, from: cur.date)
//            let date = Calendar.current.date(from: components)!
//            let existing = acc[date] ?? []
//            acc[date] = existing + [cur]
//        }
//
//        return groupedByDateComponents
//    }
//}

extension ScheduleViewController: UITableViewDelegate {

    func getMatchDays(matches: [Match]) -> [MatchDay] {
        let groupedByDateComponents = matches.reduce(into: [Date: [Match]]()) { acc, cur in
            if let date = dateFormatter.date(from: cur.date) {
                let components = Calendar.current.dateComponents([.year, .month, .day], from: date)
                if let newDate = Calendar.current.date(from: components) {
                    let existing = acc[newDate] ?? []
                    acc[newDate] = existing + [cur]
                }
            }
        }

        return groupedByDateComponents.map(MatchDay.init).sorted()

//        return groupedByDateComponents.map { (date, matches) -> MatchDay in
//            return MatchDay(matches: matches, date: date)
//        }


//
//        var holder = [[Match]]()
//        var groups = [MatchDay]()
//        for match in matches {
//            if let date = dateFormatter.date(from: match.date) {
//                if holder.isEmpty {
//                    holder.append([match])
//                    continue
//                } else {
//
//                }
//
//
//
//
//                if groups.isEmpty {
//
//                }
////                let comparison = date.compare(Date())
////                Calendar.current.isDate(<#T##date1: Date##Date#>, inSameDayAs: <#T##Date#>)
//            }
//        }
//        return groups
    }

}


struct MatchDay: Equatable, Hashable {
    let date: Date
    let matches: [Match]
}

extension MatchDay: Comparable {
    static func <(lhs: MatchDay, rhs: MatchDay) -> Bool {
        return lhs.date < rhs.date
    }
    static func >(lhs: MatchDay, rhs: MatchDay) -> Bool {
        return lhs.date > rhs.date
    }
}


class MatchDayHeader: UIView {

    func setDateString(_ text: String) {
        date.text = text
    }

    private lazy var date: UILabel = {
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
        addSubview(date)
    }

    private func setUpConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints += [
            date.centerYAnchor.constraint(equalTo: centerYAnchor),

        ]
        NSLayoutConstraint.activate(constraints)
    }
}
