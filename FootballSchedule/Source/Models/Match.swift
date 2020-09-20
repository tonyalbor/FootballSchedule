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
    let date: String // TODO: make this a Date (probably need to set date formatter in JSON Decoder)
    let status: String
//    let lastUpdated: Date // TODO
//    let matchDay: String
    enum CodingKeys: String, CodingKey {
        case id
        case homeTeam
        case awayTeam
        case score
        case status
        case date = "utcDate"
    }
}
