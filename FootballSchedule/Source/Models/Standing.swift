//
//  Standing.swift
//  FootballSchedule
//
//  Created by Tony Albor on 1/27/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

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
