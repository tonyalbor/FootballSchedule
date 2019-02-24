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
    private(set) var matches = [Match]()
    
    func getCurrentMatches(competitionCode: String, completion: @escaping (Result<[Match]>) -> Void) {
        competitionAPI.getCompetition(code: competitionCode) { [weak self] result in
            switch result {
            case let .success(response):
                self?.getMatches(competitionCode: competitionCode,
                                 matchday: response.currentSeason.currentMatchday,
                                 completion: completion)
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func getMatches(competitionCode code: String, matchday day: Int, completion: @escaping (Result<[Match]>) -> Void) {
        let request = Request(competitionCode: code, matchday: day)
        api.request(request) { [weak self] result in
            if case let .success(response) = result {
                self?.matches = response.matches
            }
            completion(result.map { $0.matches })
        }
    }
}
