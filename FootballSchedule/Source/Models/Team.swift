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
    Team(id: 57, name: "Arsenal FC"): "Arsenal",
    Team(id: 61, name: "Chelsea FC"): "Chelsea",
    Team(id: 62, name: "Everton FC"): "Everton",
    Team(id: 63, name: "Fulham FC"): "Fulham",
    Team(id: 64, name: "Liverpool FC"): "Liverpool",
    Team(id: 65, name: "Manchester City FC"): "Man City",
    Team(id: 66, name: "Manchester United FC"): "Man Utd",
    Team(id: 67, name: "Newcastle United FC"): "Newcastle Utd",
    Team(id: 73, name: "Tottenham Hotspur FC"): "Tottenham",
    Team(id: 76, name: "Wolverhampton Wanderers FC"): "Wolves",
    Team(id: 328, name: "Burnley FC"): "Burnley",
    Team(id: 338, name: "Leicester City FC"): "Leicester",
    Team(id: 340, name: "Southampton FC"): "Southampton",
    Team(id: 346, name: "Watford FC"): "Watford",
    Team(id: 354, name: "Crystal Palace FC"): "Crystal Palace",
    Team(id: 394, name: "Huddersfield Town AFC"): "Huddersfield",
    Team(id: 397, name: "Brighton & Hove Albion FC"): "Brighton & Hove Albion",
    Team(id: 563, name: "West Ham United FC"): "West Ham",
    Team(id: 715, name: "Cardiff City FC"): "Cardiff",
    Team(id: 1044, name: "AFC Bournemouth"): "Bournemouth",
]

