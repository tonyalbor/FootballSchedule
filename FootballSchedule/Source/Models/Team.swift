//
//  Team.swift
//  FootballSchedule
//
//  Created by Tony Albor on 1/27/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

struct Team: Codable, Equatable, Hashable {
    let id: Int
    let name: String
}

let eplTeams = [
    Team(id: 57, name: "Arsenal FC"),
    Team(id: 61, name: "Chelsea FC"),
    Team(id: 62, name: "Everton FC"),
    Team(id: 63, name: "Fulham FC"),
    Team(id: 64, name: "Liverpool FC"),
    Team(id: 65, name: "Manchester City FC"),
    Team(id: 66, name: "Manchester United FC"),
    Team(id: 67, name: "Newcastle United FC"),
    Team(id: 73, name: "Tottenham Hotspur FC"),
    Team(id: 76, name: "Wolverhampton Wanderers FC"),
    Team(id: 328, name: "Burnley FC"),
    Team(id: 338, name: "Leicester City FC"),
    Team(id: 340, name: "Southampton FC"),
    Team(id: 346, name: "Watford FC"),
    Team(id: 354, name: "Crystal Palace FC"),
    Team(id: 394, name: "Huddersfield Town AFC"),
    Team(id: 397, name: "Brighton & Hove Albion FC"),
    Team(id: 563, name: "West Ham United FC"),
    Team(id: 715, name: "Cardiff City FC"),
    Team(id: 1044, name: "AFC Bournemouth"),
]
