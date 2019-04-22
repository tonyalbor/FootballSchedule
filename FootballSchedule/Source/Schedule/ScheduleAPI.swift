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
    private let matchesDatabase = Database<[Match]>()
    private let seasonDatabase = Database<Season>()
    
    private static let currentMatchesKey = "currentMatches"
    
    func seasonKey(competitionCode: String) -> String {
        return "currentSeason:\(competitionCode)"
    }
    
    func matchesKey(competitionCode: String, matchday: Int) -> String {
        return "matches:\(competitionCode):\(matchday)"
    }
    
    func getCurrentMatches(competitionCode: String, completion: @escaping (Result<[Match]>) -> Void) {
        // figure out if stored matchday is still active:
        // go through the stored matches for that matchday
        // look for the matches that don't have final scores
        // look for any match that current date is later than start date
        // if there is even just one - this matchday is stale
//        if let currentMatchday = matchdayDatabase.get(key: "matchday:\(competitionCode)") {
//            if let currentMatches = readMatches(competitionCode: competitionCode, matchday: currentMatchday) {
//                // all done?
//                let dontHaveFinalScores = currentMatches.filter { (match) -> Bool in
//                    return match.score.fullTime?.awayTeam == nil || match.score.fullTime?.homeTeam == nil
//                }
//
//            }
//        }
//        if let currentMatches = matchesDatabase.get(key: ScheduleAPI.currentMatchesKey) {
//            matches = currentMatches
//            // TODO: check the matches to see if they've all been played. if so, hit network instead of returning these old matches
//            completion(.success(currentMatches))
//            return
//        }
        let currentSeasonKey = seasonKey(competitionCode: competitionCode)
        if let currentSeason = seasonDatabase.get(key: currentSeasonKey) {
            let currentMatchesKey = matchesKey(competitionCode: competitionCode, matchday: currentSeason.currentMatchday)
            if let currentMatches = matchesDatabase.get(key: currentMatchesKey) {
                completion(.success(currentMatches))
                return
            }
        }
        Log.verbose("hitting competition API for current matches")
        competitionAPI.getCompetition(code: competitionCode) { [weak self] result in
            switch result {
            case let .success(response):
                self?.getMatches(
                    competitionCode: competitionCode,
                    matchday: response.currentSeason.currentMatchday,
                    completion: { [weak self] result in
                        if case .success = result {
                            self?.seasonDatabase.save(record: response.currentSeason, key: currentSeasonKey)
                        }
                        completion(result)
                    })
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func getMatches(competitionCode code: String, matchday day: Int, completion: @escaping (Result<[Match]>) -> Void) {
        let key = matchesKey(competitionCode: code, matchday: day)
        if let value = matchesDatabase.get(key: key) {
            completion(.success(value))
            return
        }
        let request = Request(competitionCode: code, matchday: day)
        api.request(request) { [weak self] response in
            let result = response.map { $0.matches }
            if case let .success(value) = result {
                self?.matchesDatabase.save(record: value, key: key)
            }
            completion(result)
        }
    }
}
