//
//  StandingsAPI.swift
//  FootballSchedule
//
//  Created by Tony Albor on 1/20/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import Foundation

class StandingsAPI {
    
    private let api = APIClient<EPLStandingsResponse>()
    private(set) var table = [Standing]()
    
    func getTable(completion: @escaping (Result<[Standing]>) -> Void) {
        let request = EPLStandingsRequest()
        api.request(request) { [weak self] result in
            switch result {
            case let .success(response):
                let totalStandings = response.standings.first { $0.type == "TOTAL" }?.table ?? [] // error if total not found?
                self?.table = totalStandings
                completion(.success(totalStandings))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
