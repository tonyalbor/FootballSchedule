//
//  StandingsAPI.swift
//  FootballSchedule
//
//  Created by Tony Albor on 1/20/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import Foundation

final class StandingsAPI {
    
    struct Request: FootballDataRequest {
        var urlString: String { return "competitions/2021/standings" }
    }
    
    struct Response: Codable, Equatable, Hashable {
        let competition: Competition
        let season: Season
        let standings: [Standings] // [TOTAL, HOME, AWAY]
    }
    
    private let api = APIClient<Response>()
    private let database = Database<[Standing]>()
    private(set) var table = [Standing]()
    private static let currentStandingsKey = "currentStandings"
    
    func getTable(completion: @escaping (Result<[Standing]>) -> Void) {
        if let standings = database.get(key: StandingsAPI.currentStandingsKey) {
            table = standings
            completion(.success(standings))
            return
        }
        Log.verbose("Hitting Standings API")
        api.request(Request()) { [weak self] result in
            let mappedResult = result.map { $0.standings.first(where: { $0.type == "TOTAL" })?.table ?? [] } // error if total not found?
            if case let .success(standings) = mappedResult {
                self?.table = standings
                self?.database.save(record: standings, key: StandingsAPI.currentStandingsKey)
            }
            completion(mappedResult)
        }
    }
}
