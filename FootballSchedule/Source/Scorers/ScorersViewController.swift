//
//  ScorersViewController.swift
//  FootballSchedule
//
//  Created by Tony Albor on 1/27/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import UIKit

class ScorersViewController: UIViewController {
    
    let scorers: ScorersAPI
    
    init(scorers: ScorersAPI) {
        self.scorers = scorers
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = ScorersView()
    }
    var contentView: ScorersView {
        return view as! ScorersView
    }
    var tableView: UITableView {
        return contentView.scorers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        getScorers()
    }
    
    private func getScorers() {
        scorers.getScorers(competitionCode: "PL") { [weak self] result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success:
                    self?.tableView.reloadData()
                case let .failure(error):
                    print(error) // TODO: show error
                }
            }
        }
    }
    
    private func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ScorersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scorers.scorers.count // needs better naming
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ScorerTableViewCell.self)
        cell.update(scorer: scorers.scorers[indexPath.row], rank: indexPath.row + 1)
        return cell
    }
}

extension ScorersViewController: UITableViewDelegate {
    
}
