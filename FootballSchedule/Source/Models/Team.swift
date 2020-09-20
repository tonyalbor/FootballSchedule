//
//  Team.swift
//  FootballSchedule
//
//  Created by Tony Albor on 1/27/19.
//  Copyright © 2019 Tony Albor. All rights reserved.
//

import UIKit

enum TeamLogo: String {
    case arsenal, astonVilla, atalanta, bournemouth, brighton, burnley, cardiff,
         chelsea, crystalPalace, dinamoZagreb, everton, fulham, huddersfield, leeds,
         leicester, liverpool, lyon, manchesterCity, manchesterUnited, newcastle,
         norwich, realMadrid, shakhtar, sheffieldUnited, southampton, tottenham, watford, westBrom,
         westHam, wolverhampton
    
    func asUIImage() -> UIImage {
        guard let image = UIImage(named: rawValue) else {
            fatalError("Team image name not found: \(rawValue)")
        }
        return image
    }
}

struct Team: Codable, Equatable, Hashable {
    let id: Int
    let name: String
}

//astonVilla, norwich, sheffieldUnited 

let shortTeamNames = [
    57: "Arsenal",
    58: "Aston Villa",
    61: "Chelsea",
    62: "Everton",
    63: "Fulham",
    64: "Liverpool",
    65: "Man City",
    66: "Man Utd",
    67: "Newcastle",
    68: "Norwich",
    73: "Tottenham",
    74: "West Brom",
    76: "Wolves",
    86: "Real Madrid",
    102: "Atalanta",
    328: "Burnley",
    338: "Leicester",
    340: "Southampton",
    341: "Leeds Utd",
    346: "Watford",
    354: "Crystal Palace",
    356: "Sheffield Utd",
    394: "Huddersfield",
    397: "Brighton",
    523: "Lyon",
    563: "West Ham",
    715: "Cardiff",
    755: "Dinamo Zagreb",
    1044: "Bournemouth",
    1887: "Shakhtar Donetsk",
]

struct CacheItem<Cachable: Codable>: Codable {
    let savedAt: Date
    let item: Cachable
}

let teamLogos: [Int: TeamLogo] = [
    57: .arsenal,
    58: .astonVilla,
    61: .chelsea,
    62: .everton,
    63: .fulham,
    64: .liverpool,
    65: .manchesterCity,
    66: .manchesterUnited,
    67: .newcastle,
    68: .norwich,
    73: .tottenham,
    74: .westBrom,
    76: .wolverhampton,
    86: .realMadrid,
    102: .atalanta,
    328: .burnley,
    338: .leicester,
    340: .southampton,
    341: .leeds,
    346: .watford,
    354: .crystalPalace,
    356: .sheffieldUnited,
    394: .huddersfield,
    397: .brighton,
    523: .lyon,
    563: .westHam,
    715: .cardiff,
    755: .dinamoZagreb,
    1044: .bournemouth,
    1887: .shakhtar,
]
