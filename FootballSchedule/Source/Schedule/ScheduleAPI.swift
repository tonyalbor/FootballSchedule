//
//  ScheduleAPI.swift
//  FootballSchedule
//
//  Created by Tony Albor on 1/20/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import Foundation

class ScheduleAPI {
    
    struct Request: FootballDataRequest {
        let matchday: Int
        var urlString: String { return "competitions/PL/matches/?matchday=\(matchday)" }
    }
    
    struct Response: Codable, Equatable, Hashable {
        let matches: [Match]
        let competition: Competition
    }
    
    private let api = APIClient<Response>()
    private(set) var matches = [Match]()
    
    func getMatches(completion: @escaping (Result<[Match]>) -> Void) {
        let request = Request(matchday: 24) // todo: paginate; matchday param
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
