//
//  EPLStandingsRequest.swift
//  FootballSchedule
//
//  Created by Tony Albor on 1/20/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import Foundation

struct EPLStandingsRequest: FootballDataRequest {
    var urlString: String { return "competitions/2021/standings" }
}

struct EPLStandingsResponse: Codable, Equatable, Hashable {
    let competition: Competition
    let season: Season
    let standings: [Standings] // [TOTAL, HOME, AWAY]
}

struct Season: Codable, Equatable, Hashable {
    let id: Int
    let currentMatchday: Int
}

struct Standings: Codable, Equatable, Hashable {
    let type: String
    let table: [Standing]
}

struct Standing: Codable, Equatable, Hashable {
    let position: Int
    let team: Team
    let playedGames: Int
    let won: Int
    let draw: Int
    let lost: Int
    let points: Int
    let goalsFor: Int
    let goalsAgainst: Int
    let goalDifference: Int
}
