//
//  ScheduleAPI.swift
//  FootballSchedule
//
//  Created by Tony Albor on 1/20/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import Foundation

final class CompetitionAPI {
    
    struct Request: FootballDataRequest {
        let code: String
        var urlString: String { return "competitions/\(code)" }
    }

    struct Response: Codable, Equatable, Hashable {
        let competition: Competition
        let currentSeason: Season
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.competition = try Competition(from: decoder)
            self.currentSeason = try container.decode(Season.self, forKey: .currentSeason)
        }
    }
    
    private let api = APIClient<Response>()
    
    func getCompetition(code: String, completion: @escaping (Result<Response>) -> Void) {
        let request = Request(code: code)
        api.request(request, completion: completion)
    }
}

final class ScheduleAPI {
    
    struct Request: FootballDataRequest {
        let competitionCode: String
        let matchday: Int
        var urlString: String { return "competitions/\(competitionCode)/matches/?matchday=\(matchday)" }
    }
    
    struct Response: Codable, Equatable, Hashable {
        let matches: [Match]
    }
    
    private let api = APIClient<Response>()
    private let competitionAPI = CompetitionAPI()
    private let database = Database<[Match]>()
    private(set) var matches = [Match]()
    
    private static let currentMatchesKey = "currentMatches"
    
    func getCurrentMatches(competitionCode: String, completion: @escaping (Result<[Match]>) -> Void) {
        if let currentMatches = database.get(key: ScheduleAPI.currentMatchesKey) {
            matches = currentMatches
            // TODO: check the matches to see if they've all been played. if so, hit network instead of returning these old matches
            completion(.success(currentMatches))
            return
        }
        Log.verbose("hitting competition API for current matches")
        competitionAPI.getCompetition(code: competitionCode) { [weak self] result in
            switch result {
            case let .success(response):
                self?.getMatches(
                    competitionCode: competitionCode,
                    matchday: response.currentSeason.currentMatchday,
                    completion: { [weak self] result in
                        if case let .success(matches) = result {
                            self?.database.save(record: matches, key: ScheduleAPI.currentMatchesKey)
                        }
                        completion(result)
                    })
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func getMatches(competitionCode code: String, matchday day: Int, completion: @escaping (Result<[Match]>) -> Void) {
        let request = Request(competitionCode: code, matchday: day)
        api.request(request) { [weak self] result in
            let mappedResult = result.map { $0.matches }
            if case let .success(response) = mappedResult {
                self?.matches = response
            }
            completion(mappedResult)
        }
    }
}
