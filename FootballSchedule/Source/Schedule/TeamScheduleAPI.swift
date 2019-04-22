//
//  TeamScheduleAPI.swift
//  FootballSchedule
//
//  Created by Tony Albor on 3/18/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import Foundation

final class TeamScheduleAPI {
    
    static var formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter
    }()
    
    struct Request: FootballDataRequest {
        let teamId: Int
        let dateFrom: Date
        private var dateFromArg: String {
            return TeamScheduleAPI.formatter.string(from: dateFrom)
        }
        var urlString: String { return "teams/\(teamId)/matches"}//?limit=20"}//&dateFrom=\(dateFromArg)" }
        // /v2/teams/{id}/matches
    }
    
    struct Response: Codable, Equatable, Hashable {
        let matches: [Match]
    }
    
    private let api = APIClient<Response>()
    private let database = Database<[Match]>()
    private(set) var matches = [Match]()
    
    private static let currentMatchesKey = "currentManCityMatches"
    
    func getMatches(teamId: Int, completion: @escaping (Result<[Match]>) -> Void) {
        if let currentMatches = database.get(key: TeamScheduleAPI.currentMatchesKey) {
            matches = currentMatches
            completion(.success(currentMatches))
            return
        }
        Log.verbose("hitting team schedule API for current matches")
        let secondsInMinute = 60.0
        let minutesInHour = 60.0
        let hoursInDay = 24.0
        let secondsInDay = secondsInMinute * minutesInHour * hoursInDay
        let request = Request(teamId: teamId, dateFrom: Date())//.addingTimeInterval(-1.0 * secondsInDay * 14.0))
        api.request(request) { [weak self] response in
            switch response {
            case let .success(value):
                self?.matches = value.matches
                self?.database.save(record: value.matches, key: TeamScheduleAPI.currentMatchesKey)
                completion(.success(value.matches))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
