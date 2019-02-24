//
//  Team.swift
//  FootballSchedule
//
//  Created by Tony Albor on 1/27/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import UIKit

enum TeamLogo: String {
    case arsenal, bournemouth, brighton, burnley, cardiff, chelsea,
         crystalPalace, everton, fulham, huddersfield, leicester,
         liverpool, manchesterCity, manchesterUnited, newcastle,
         southampton, tottenham, watford, westHam, wolverhampton
    
    func asUIImage() -> UIImage {
        return UIImage(named: rawValue)!
    }
}

struct Team: Codable, Equatable, Hashable {
    let id: Int
    let name: String
}

let shortTeamNames = [
    57: "Arsenal",
    61: "Chelsea",
    62: "Everton",
    63: "Fulham",
    64: "Liverpool",
    65: "Man City",
    66: "Man United",
    67: "Newcastle",
    73: "Tottenham",
    76: "Wolves",
    328: "Burnley",
    338: "Leicester City",
    340: "Southampton",
    346: "Watford",
    354: "Crystal Palace",
    394: "Huddersfield",
    397: "Brighton",
    563: "West Ham",
    715: "Cardiff",
    1044: "Bournemouth",
]

let teamLogos: [Int: TeamLogo] = [
    57: .arsenal,
    61: .chelsea,
    62: .everton,
    63: .fulham,
    64: .liverpool,
    65: .manchesterCity,
    66: .manchesterUnited,
    67: .newcastle,
    73: .tottenham,
    76: .wolverhampton,
    328: .burnley,
    338: .leicester,
    340: .southampton,
    346: .watford,
    354: .crystalPalace,
    394: .huddersfield,
    397: .brighton,
    563: .westHam,
    715: .cardiff,
    1044: .bournemouth,
]
