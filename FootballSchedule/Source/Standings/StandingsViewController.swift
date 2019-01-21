//
//  StandingsViewController.swift
//  FootballSchedule
//
//  Created by Tony Albor on 1/20/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import UIKit

class StandingsContext {
    
    private let api = APIClient<EPLStandingsResponse>()
    private(set) var standings = [Standing]()
    
    func getStandings(completion: @escaping (Result<[Standing]>) -> Void) {
        let request = EPLStandingsRequest()
        api.request(request) { [weak self] result in
            switch result {
            case let .success(response):
                let totalStandings = response.standings.first { $0.type == "TOTAL" }?.table ?? [] // error if total not found?
                self?.standings = totalStandings
                completion(.success(totalStandings))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

class StandingsViewController: UIViewController {
    
    private let context: StandingsContext
    
    init(context: StandingsContext) {
        self.context = context
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
        context.getStandings { [weak self] result in
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
        return context.standings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(StandingTableViewCell.self)
        cell.standing = context.standings[indexPath.row]
        return cell
    }
}

extension StandingsViewController: UITableViewDelegate {
    
}
