//
//  Score.swift
//  FootballSchedule
//
//  Created by Tony Albor on 1/27/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

struct Score: Codable, Equatable, Hashable {
    let halfTime: MatchResult?
    let fullTime: MatchResult?
    let winner: MatchResult?
    let extraTime: MatchResult?
    let penalties: MatchResult?
}
