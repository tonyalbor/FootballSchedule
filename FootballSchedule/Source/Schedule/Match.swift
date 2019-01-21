//
//  Match.swift
//  Football Schedule
//
//  Created by Tony Albor on 1/19/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import Foundation

struct EPLScheduleResponse: Codable, Equatable, Hashable {
    let matches: [Match]
    let competition: Competition
}

struct Competition: Codable, Equatable, Hashable {
    let code: String
    let id: Int
    let name: String
}

struct Team: Codable, Equatable, Hashable {
    let id: Int
    let name: String
}

struct Match: Codable, Equatable, Hashable {
    struct Result: Codable, Equatable, Hashable {
        let awayTeam: Int?
        let homeTeam: Int?
    }
    struct Score: Codable, Equatable, Hashable {
        let halfTime: Result?
        let fullTime: Result?
        let winner: String?
        let extraTime: Result?
        let penalties: Result?
    }
    let id: Int
    let homeTeam: Team
    let awayTeam: Team
    let score: Score
//    let date: Date // TODO
    let status: String
////    let lastUpdated: Date // TODO
//    let matchDay: String
}
