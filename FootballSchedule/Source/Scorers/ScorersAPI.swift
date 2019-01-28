//
//  ScorersAPI.swift
//  FootballSchedule
//
//  Created by Tony Albor on 1/27/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import Foundation

class ScorersAPI {
    
    struct Request: FootballDataRequest {
        let code: String
        var urlString: String { return "competitions/\(code)/scorers" }
    }
    
    struct Response: Codable, Equatable, Hashable {
        let competition: Competition
        let season: Season
        let scorers: [Scorer]
    }
    
    private let api = APIClient<Response>()
    private(set) var scorers = [Scorer]()
    
    func getScorers(competitionCode: String,
                    completion: @escaping (Result<[Scorer]>) -> Void) {
        let request = Request(code: competitionCode)
        api.request(request) { [weak self] result in
            switch result {
            case let .success(response):
                self?.scorers = response.scorers
                completion(.success(response.scorers))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
