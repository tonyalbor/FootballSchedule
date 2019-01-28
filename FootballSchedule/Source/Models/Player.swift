//
//  Player.swift
//  FootballSchedule
//
//  Created by Tony Albor on 1/27/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

struct Player: Codable, Equatable, Hashable {
    let id: Int
    let name: String
    let firstName: String
    let lastName: String?
    let countryOfBirth: String
    let nationality: String // TODO: find a way to map to emoji
    let position: String
}
