//
//  ScheduleViewController.swift
//  Football Schedule
//
//  Created by Tony Albor on 1/19/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import UIKit

class ScheduleContext {

    private let api = APIClient<EPLScheduleResponse>()
    private(set) var matches = [Match]()
    
    func getMatches(completion: @escaping (Result<[Match]>) -> Void) {
        let request = EPLScheduleRequest(matchday: 23) // todo: paginate; matchday param
        api.request(request) { [weak self] result in
            switch result {
            case let .success(response):
                self?.matches = response.matches
                completion(.success(response.matches))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

class ScheduleViewController: UIViewController {
    
    private let context: ScheduleContext
    
    init(context: ScheduleContext) {
        self.context = context
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = ScheduleView()
    }
    var contentView: ScheduleView { return view as! ScheduleView }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        getSchedule()
    }
    
    private func setUpTableView() {
        contentView.matches.dataSource = self
        contentView.matches.delegate = self
        contentView.matches.estimatedRowHeight = 100.0
    }
    
    private func getSchedule() {
        context.getMatches { [weak self] result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success:
                    self?.contentView.matches.reloadData()
                case let .failure(error):
                    print(error.localizedDescription)
                    print(error)
                }
            }
        }
    }
}

extension ScheduleViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return context.matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(MatchTableViewCell.self)
        cell.match = context.matches[indexPath.row]
        return cell
    }
}

extension ScheduleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
