//
//  Scorer.swift
//  FootballSchedule
//
//  Created by Tony Albor on 1/27/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

struct Scorer: Codable, Equatable, Hashable {
    let player: Player
    let team: Team
    let numberOfGoals: Int
}
