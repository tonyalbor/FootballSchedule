//
//  StandingsViewController.swift
//  FootballSchedule
//
//  Created by Tony Albor on 1/20/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import UIKit

class StandingsViewController: UIViewController {
    
    private let standings: StandingsAPI
    
    init(standings: StandingsAPI) {
        self.standings = standings
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = StandingsView()
    }
    var contentView: StandingsView {
        return view as! StandingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStandings()
        getStandings()
    }
    
    private func setUpStandings() {
        contentView.standings.dataSource = self
        contentView.standings.delegate = self
        contentView.standings.estimatedRowHeight = 44.0
    }
    
    private func getStandings() {
        standings.getTable { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.contentView.standings.reloadData()
                case .failure:
                    break // todo: show error
                }
            }
        }
    }
}

extension StandingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return standings.table.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(StandingTableViewCell.self)
        cell.standing = standings.table[indexPath.row]
        return cell
    }
}

extension StandingsViewController: UITableViewDelegate {
    
}
