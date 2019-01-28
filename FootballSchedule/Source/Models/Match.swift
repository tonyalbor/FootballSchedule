//
//  Match.swift
//  FootballSchedule
//
//  Created by Tony Albor on 1/27/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

struct Match: Codable, Equatable, Hashable {
    let id: Int
    let homeTeam: Team
    let awayTeam: Team
    let score: Score
//    let date: Date // TODO
    let status: String
//    let lastUpdated: Date // TODO
//    let matchDay: String
}
