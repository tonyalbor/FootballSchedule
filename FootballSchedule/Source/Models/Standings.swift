//
//  Standings.swift
//  FootballSchedule
//
//  Created by Tony Albor on 1/27/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

struct Standings: Codable, Equatable, Hashable {
    let type: String
    let table: [Standing]
}
