//
//  ScorersAPI.swift
//  FootballSchedule
//
//  Created by Tony Albor on 1/27/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import Foundation

final class ScorersAPI {
    
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
    private let database = Database<[Scorer]>()
    private(set) var scorers = [Scorer]()
    private static let currentScorersKey = "currentScorers"
    
    func getScorers(competitionCode: String,
                    completion: @escaping (Result<[Scorer]>) -> Void) {
        if let currentScorers = database.get(key: ScorersAPI.currentScorersKey) {
            scorers = currentScorers
            completion(.success(currentScorers))
            return
        }
        Log.verbose("Hitting Scorers API")
        let request = Request(code: competitionCode)
        api.request(request) { [weak self] response in
            let result = response.map { $0.scorers }
            if case let .success(value) = result {
                self?.scorers = value
                self?.database.save(record: value, key: ScorersAPI.currentScorersKey)
            }
            completion(result)
        }
    }
}
